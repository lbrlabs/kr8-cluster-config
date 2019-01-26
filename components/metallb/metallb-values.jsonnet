local config = std.extVar('kr8');

{
  existingConfigMap: 'metallb-config',
  rbac: {
    create: true,
  },
}
