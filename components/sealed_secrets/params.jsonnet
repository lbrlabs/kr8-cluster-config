{
  namespace: 'kube-system',
  release_name: 'sealed_secrets',
  kubecfg_gc_enable: true,
  tls_key: error 'Must provide a tls key',
  tls_cert: error 'Must provide a tls cert',
}
