local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

{
  prometheus+:: {

    serviceMonitorCoreDNS+: {
      spec+: {
        selector+: {
          matchLabels: { 'k8s-app': 'coredns' },
        },
      },
    },

    // Update prometheus (crd) resource
    prometheus+: {
      spec+: {
        externalUrl: config.prometheus.externalUrl,
        // external labels
        externalLabels: config.prometheus.externalLabels,
        // Retention
        retention: config.prometheus.retention,
        // Persistent Storage
        [if 'volumeClaimTemplate' in config.prometheus then 'storage']: {
          volumeClaimTemplate: config.prometheus.volumeClaimTemplate,
        },
        //
        replicas: config.prometheus.replicas,
      } + if 'alertmanager_external_endpoints' in config then {
        // Provide a secret and key that contains additional alertmanager config
        additionalAlertManagerConfigs: {
          name: 'alertmanager-additional-configs',
          key: 'alertmanager-external',
        },
        // mount this secret so we can pass tls certs
        secrets: ['prometheus-tls-files'],
      } else {},
    },

    // Add an ingress
    [if config.ingress_enabled then 'ingress']: kube.Ingress('prometheus-k8s') {
      metadata+: {
        namespace: $._config.namespace,
        annotations+: {
          'kubernetes.io/ingress.class': config.ingress_class,
          [if config.ingress_authenabled then 'nginx.ingress.kubernetes.io/auth-type']: 'basic',
          [if config.ingress_authenabled then 'nginx.ingress.kubernetes.io/auth-realm']: 'Authentication Required - admin',
          [if config.ingress_authenabled then 'nginx.ingress.kubernetes.io/auth-secret']: 'prometheus-password',
        },
      },
      spec: {
        rules: [
          {
            host: config.prometheus.externalName,
            http: {
              paths: [{
                backend: {
                  serviceName: 'prometheus-k8s',
                  servicePort: 9090,
                },
                path: '/',
              }],
            },
          },
        ],
      },
    },

    // Add scraping access to ClusterRole so that it can scrape all namespaces by default
    // Out-of-the-box, the kube-prometheus config only adds individual role bindings for the monitoring, kube-system and default namespaces. This clusterole gives it access to all namespaces.
    // NOTE: the alternative is to put the namespaces in a the list 'namespaces' in this object, but that requires known the namespaces beforehand
    clusterRole+: {
      rules+: [
        {
          apiGroups: [''],
          resources: ['nodes', 'services', 'endpoints', 'pods'],
          verbs: ['get', 'list', 'watch'],
        },
      ],
    },
  },
}
