local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

{
  nodeExporter+:: {
    daemonset+:
      {
        spec+: {
          template+: {
            spec+: {
              tolerations+: [
                // tolerate all nodes
                { operator: 'Exists' },
              ],
            },
          },
        },
      },
    serviceMonitor+:
      {
        spec+: {
          endpoints: [
            {
              port: 'https',
              scheme: 'https',
              interval: '60s',
              bearerTokenFile: '/var/run/secrets/kubernetes.io/serviceaccount/token',
              timeout: '10s',
              tlsConfig: {
                insecureSkipVerify: true,
              },
            },
          ],
        },
      },
  },
}
