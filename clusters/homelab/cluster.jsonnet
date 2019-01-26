{
  _cluster+: {
    tier: 'prod',
    region_name: 'home',
    cluster_name: 'homelab',
    cluster_type: 'baremetal',
    dns_domain: 'home.lbrlabs.com',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
  },

  sealed_secrets+: (import 'sealed-secret.key'),
}
