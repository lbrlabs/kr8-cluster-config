local config = std.extVar('kr8');
local kr8_cluster = std.extVar('kr8_cluster');
local kube = import 'kube.libsonnet';

// Create a secret with configuration for our external alertmanagers
if 'alertmanager_external_endpoints' in config then
  {
    secret_alertmanager_additional_configs: kube.Secret('alertmanager-additional-configs') + {
      data_: {
        'alertmanager-external': std.manifestJsonEx(
          [
            {
              timeout: '10s',
              scheme: 'https',
              static_configs: [
                {
                  targets: config.alertmanager_external_endpoints,
                },
              ],
              tls_config: {
                //insecure_skip_verify: true,
                // the 'prometheus-tls-files' is mounted into the prometheus pods, giving us access to the cert
                ca_file: '/etc/prometheus/secrets/prometheus-tls-files/puppet_ca_cert.pem',
              },
            },
          ], ' ',
        ),
      },
    },
    secret_prometheus_tls_files: kube.Secret('prometheus-tls-files') + {
      data_: {
        'puppet_ca_cert.pem': kr8_cluster.puppet_ca_cert,
      },
    },
  } else {}
