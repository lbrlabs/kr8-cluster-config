local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

local kp = (import 'kube-prometheus/kube-prometheus.libsonnet') + (import 'kube-prometheus/kube-prometheus-kubeadm.libsonnet') + {
  _config+:: {
    namespace: 'monitoring',
    // versions to use
    versions+:: {
      //      prometheus: 'v2.3.1',
    },
    // FIXME update these to proxy via nexus
    imageRepos+:: {
      prometheus: 'quay.io/prometheus/prometheus',
      alertmanager: 'quay.io/prometheus/alertmanager',
      kubeStateMetrics: 'quay.io/coreos/kube-state-metrics',
      kubeRbacProxy: 'quay.io/coreos/kube-rbac-proxy',
      addonResizer: 'quay.io/coreos/addon-resizer',
      nodeExporter: 'quay.io/prometheus/node-exporter',
      prometheusOperator: 'quay.io/coreos/prometheus-operator',
    },
    // if external alertmanager ips are configured, then don't monitor the local alertmanager, because there isn't one
    [if 'alertmanager_external_endpoints' in config then 'jobs']:: std.mergePatch(super.jobs, {
      Alertmanager: null,
    }),
    /*    kubeStateMetrics+:: {
          baseCPU: '200m',
          baseMemory: '350Mi',
        }, */
  },
  // Merge in our prometheus customisations and rules
} + (import 'prometheus.jsonnet') + (import 'node-exporter.jsonnet') + (import 'rules/rules.jsonnet') + (import 'alerts/alerts.jsonnet');

kube.objectValues(
  // Namespace is created in the namespace component
  //{ ['00namespace-' + name]: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus) } +

  {
    ['0prometheus-operator-' + name]: kp.prometheusOperator[name] {
      metadata: std.mergePatch(super.metadata, {
        creationTimestamp: null,  // remove this
      }),
    }
    for name in std.objectFields(kp.prometheusOperator)
  } +
  { ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
  { ['kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
  //{ ['alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
  { ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +
  //{ ['grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) }+
  (import 'service-monitors.jsonnet') +  // define service monitors
  (import 'alertmanager-external.jsonnet') +  // define external alertmanager endpoint
  (import 'secret.jsonnet') +  // define basic auth secret
  {}
)
