{
  _cluster+: {
    tier: 'prod',
    region_name: 'sfo2',
    cluster_name: 'do',
    cluster_type: 'digitalocean',
    dns_domain: 'briggs.work',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
    nginx_ingress: { path: 'components/nginx_ingress' },
    //external_dns: { path: 'components/external_dns' },
  },


  /*
  external_dns+: {
    provider: 'aws',
    tolerateMasters: true,
    txtPrefix: 'kops',
    txtOwnerId: 'kops',
    domainFilters: [
      'leebriggs.net',
    ],
  },

  sealed_secrets+: (import 'sealed-secret.key'),
  */
}
