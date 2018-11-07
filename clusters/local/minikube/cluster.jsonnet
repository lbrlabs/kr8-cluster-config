{
  _cluster+: {
    tier: 'local',
    region_name: 'local',
    cluster_name: 'minikube',
    cluster_type: 'local',
    dns_domain: 'localhost',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
  },

}
