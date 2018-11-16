local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');
local kr8_cluster = std.extVar('kr8_cluster');

kube.objectValues(
  {
    BackupStorageLocation: {
      apiVersion: 'ark.heptio.com/v1',
      kind: 'BackupStorageLocation',
      metadata: {
        name: config.release_name,
        namespace: config.namespace,
      },
      spec: {
        provider: config.cloud_provider,
        objectStorage: {
          bucket: config.bucket_name,
        },
        config: {
          s3Url: config.s3_url,
          region: config.region,
        },
      },
    },
  }
)
