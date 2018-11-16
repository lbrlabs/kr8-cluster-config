{
  namespace: 'heptio-ark',
  release_name: 'ark-location',
  kubecfg_gc_enable: false,
  cloud_provider: std.format('%s', $._cluster.cluster_type),
  region: std.format('%s', $._cluster.region_name),
  bucket_name: error 'Must specify a bucket name',
  s3_url: error 'Must specify s3 url',
}
