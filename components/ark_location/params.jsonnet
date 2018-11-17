{
  local c = self,
  namespace: 'heptio-ark',
  name: c.release_name,
  release_name: 'ark-location',
  kubecfg_gc_enable: false,
  cloud_provider: std.format('%s', $._cluster.cluster_type),
  bucket_name: error 'Must specify a bucket name',
}
