local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

[
  if object.kind == 'Secret' then {} else object
  for object in helpers.list(
    // object list is converted to hash of named objects, then they can be modified by name

    helpers.named(helpers.helmInput) + {
      'CustomResourceDefinition/aksclusters.compute.azure.crossplane.io'+: {

        spec+: {
          validation+: {
            openAPIV3Schema+: {
              properties+: {
                spec+: {
                  properties+: {
                    nodeCount+: {
                      /*
                      maximum: null,
                      minimum: null,
                      */
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  )
]
