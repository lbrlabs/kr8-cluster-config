local helpers = {
  /* This is for monkeypatching Prometheus alert rules. Pass it the "groups" list (i.e. prometheusAlerts.groups)
     It will convert the group list to a set of named objects using the group's name, then each "rules" object in each group is converted to a named hash using the name "alert/labels.severity".
     For example, if the group is named "kube-prometheus-node-alerting.rules" and one of the rules has "alert: NodeDiskRunningFullTest" and "labels: {severity: warning"}" then the path for that rule
     will be "kube-prometheus-node-alerting.rules": { rules: { "NodeDiskRunningFullTest/warning": {  ... } }"

     A rule can be removed by setting its value to null. When converted back to a list, it will be removed
        "kube-prometheus-node-alerting.rules": { rules: { "NodeDiskRunningFullTest/warning": null }}"
  */
  alertGroupsNamed(objectlist):: {
    [k.name]: k {
      rules: {
        [j.alert + '/' + j.labels.severity]: j
        for j in
          local rules = k.rules;
          std.makeArray(
            std.length(rules),
            function(i)
              rules[i] { _named_object_index:: i }
          )
      },
    }
    for k in
      std.makeArray(
        std.length(objectlist),
        function(i)
          objectlist[i] { _named_object_index:: i }
      )
  },
  // This converts the output of alertGroupsNamed() back to a list of lists
  alertGroupsList(objecthash)::
    // if _named_object_index is not set here, then somehow a new rule name has been added, that wasn't in the list before, so raise that as an error
    local objs = [if objecthash[f] != null then if '_named_object_index' in objecthash[f] then objecthash[f] else error 'An unknown group or alert rule name was referenced: ' + f for f in std.objectFields(objecthash)];
    local objsKeyed = { [if o != null then if '_named_object_index' in o then std.toString(o._named_object_index) else error 'An unknown group or rule name was referenced']: o for o in objs };
    [
      o {
        [if 'rules' in o then 'rules']: $.alertGroupsList(super.rules),  // the rules are hash and need to be converted back to array as well
      }
      for o in std.makeArray(
        std.length(objs),
        function(i)
          local k = std.toString(i);
          if std.objectHas(objsKeyed, k) then objsKeyed[k] else null
      )
      if o != null
    ],

};

(import 'akp_node_alerts.jsonnet') + (import 'akp_gitlab_runner_alerts.jsonnet') +
{
  /*  prometheusAlerts+:: {
      // filter out some of the mixin rule groups entirely, as they need some work
      groups: std.filter(
        function(g)
          // if g.name != 'kubernetes-resources' && g.name != 'kubernetes-system' then true else false,
          if std.startsWith(g.name, 'kubernetes-') then false else true,
        super.groups
      ),
    }, */
}
+ {
  // filter out individual alerts or recording rules by name
  // (uncomment this if needed)
  prometheusAlerts+:: {
    groups: [
      group {
        rules: [
          rule
          for rule in super.rules
          if (
            'alert' in rule
            && rule.alert != 'CPUThrottlingHigh'
            //&& rule.alert != 'KubePersistentVolumeFullInFourDays'
            //&& rule.alert != 'NodeDiskRunningFull'
          ) || 'record' in rule
        ],
      }
      for group in super.groups
    ],
  },

}


// Look through all groups and all alerts and filter out ones we don't want
// groups: [ name: name, rules: [ rule1, rule2, etc. ], ...]

/*+ {
// this breaks because the monitoring mixins has deplicate alert names

  local groups = super.prometheusAlerts.groups,
  prometheusAlerts+:: {
    groups: helpers.alertGroupsList(
      helpers.alertGroupsNamed(groups) {
        'kube-prometheus-node-alerting.rules'+: {
          rules+: {
            'NodeDiskRunningFull/critical'+: {
              annotations+: {
                message: 'testing',
              },
            },
            //            'NodeDiskRunningFull/warning': null,
          },
        },
      }
    ),
  },
}*/



