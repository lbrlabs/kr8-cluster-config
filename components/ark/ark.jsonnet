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
          }
        ) + {
          spec+: {
            template+: {
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
