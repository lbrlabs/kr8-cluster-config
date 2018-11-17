local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');
local kr8_cluster = std.extVar('kr8_cluster');

kube.objectValues(
  {
    BackupStorageLocation: {
      apiVersion: 'ark.heptio.com/v1',
      kind: 'BackupStorageLocation',
      metadata: {
        name: config.name,
        namespace: config.namespace,
      },
      spec: {
        provider: config.cloud_provider,
        objectStorage: {
          bucket: config.bucket_name,
        },
        config: config.config,
      },
    },
  }
)
