local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

[
  kube.Namespace(config.namespace) {
    metadata+: {
    },
  },
]
