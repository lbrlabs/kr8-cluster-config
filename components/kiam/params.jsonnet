{
  namespace: 'kube-system',
  release_name: 'kiam',
  kubecfg_gc_enable: true,
  agent_secret: {
    ca: error 'agent.secret.ca must be set as a sealed secret value',
    cert: error 'agent.secret.cert must be set as a sealed secret value',
    key: error 'agent.secret.key must be set as a sealed secret value',
  },
  server_secret: {
    ca: error 'server.secret.ca must be set as a sealed secret value',
    cert: error 'server.secret.cert must be set as a sealed secret value',
    key: error 'server.secret.key must be set as a sealed secret value',
  },
}
