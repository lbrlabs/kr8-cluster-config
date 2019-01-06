local helpers = import 'helpers.libsonnet';
local kube = import 'kube.libsonnet';
local kr8_cluster = std.extVar('kr8_cluster');
local parseYaml = std.native('parseYaml');
local config = std.extVar('kr8');

[
  object
  for object in helpers.list(
    helpers.named(parseYaml(std.extVar('inputArk'))) {
      ['Deployment/%s/ark' % config.namespace]+:
        helpers.patchContainerNamed(
          'ark', {
            image: 'gcr.io/heptio-images/ark:%s' % config.version,
            args: [
              'server',
              '--default-volume-snapshot-locations=digitalocean-blockstore:default',
            ],
            volumeMounts+: [
              {
                name: 'cloud-credentials',
                mountPath: '/credentials',
              },
            ],
            env+: [
              {
                name: 'AWS_SHARED_CREDENTIALS_FILE',
                value: '/credentials/cloud',
              },
              {
                name: 'DIGITALOCEAN_TOKEN',
                valueFrom: {
                  secretKeyRef: {
                    key: 'digitalocean_token',
                    name: 'cloud-credentials',
                  },
                },
              },
            ],
          }
        ) + {
          spec+: {
            template+: {
              spec+: {
                volumes+: [
                  {
                    name: 'cloud-credentials',
                    secret: {
                      secretName: 'cloud-credentials',
                    },
                  },
                ],
                initContainers+: [
                  {
                    image: 'gcr.io/stackpoint-public/ark-blockstore-digitalocean:latest',
                    name: 'ark-blockstore-digitalocean',
                    volumeMounts: [
                      {
                        name: 'plugins',
                        mountPath: '/target',
                      },
                    ],
                  },
                ],
              },
              metadata+: {
                annotations+: {
                  'iam.amazonaws.com/role': config.iam_role,
                },
              },
            },
          },
        },
      /*
      helpers.patchPodMetadata('ark', {
        annotatations: [],
      },
      */
    }
  )
]
