local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

local mlbconfig = {
  'address-pools': [
    { name: 'default', protocol: 'layer2', addresses: config.addresses },
  ],
};

[

  kube.ConfigMap('metallb-config') {
    metadata+: {
      namespace: config.namespace,
      labels: {
        app: 'metallb',
      },
    },
    data: {
      config: std.toString(mlbconfig),
    },
  },

]
