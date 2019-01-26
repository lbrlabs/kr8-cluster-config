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
    metallb: { path: 'components/metallb' },
    nginx_ingress: { path: 'components/nginx_ingress' },
  },

  sealed_secrets+: (import 'sealed-secret.key'),
  metallb+: {
    addresses: ['192.168.1.250-192.168.1.254'],
  },
}
