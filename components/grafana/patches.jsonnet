local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');
[
  object
  for object in helpers.list(
    // object list is converted to hash of named objects, then they can be modified by name
    helpers.named(helpers.helmInput) + {
      ['Deployment/' + config.release_name]+: helpers.patchContainer({
        volumeMounts: [
          {
            mountPath: '/etc/grafana/grafana.ini',
            name: 'config',
            subPath: 'grafana.ini',
          },
          {
            mountPath: '/var/lib/grafana',
            name: 'storage',
          },
        ],
      }) + { spec+: { template+: { spec+: { volumes:
        [
          {
            configMap: {
              name: 'grafana',
            },
            name: 'config',
          },
          {
            name: 'storage',
          },
        ] } } } },
    },
  )
] + [
  kube.Namespace(config.namespace),
]
