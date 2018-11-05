{
  agent: {
    gatewayTimeoutCreation: '1s',
    image: {
      tag: 'v2.8',
    },
    tolerations: [
      // tolerate all nodes, so agent runs on all nodes. We use a nodeselector to make sure it's only on nodes and not master
      { operator: 'Exists' },
    ],
    nodeSelector: {
      // run on master nodes only
      'node-role.kubernetes.io/node': '',
    },
    host: {
      port: 8181,
      iptables: true,
      interface: 'cali+',
    },
    updateStrategy: 'RollingUpdate',
  },
  rbac: {
    create: true,
  },
  server: {
    gatewayTimeoutCreation: '1s',
    tolerations: [
      {
        // we want this on master nodes
        key: 'node-role.kubernetes.io/master',
        operator: 'Exists',
        value: '',
        effect: 'NoSchedule',
      },
    ],
    sessionDuration: '15m',
    roleBaseArn: null,
    assumeRoleArn: null,
    nodeSelector: {
      // run on master nodes only
      'node-role.kubernetes.io/master': '',
    },
    updateStrategy: 'RollingUpdate',
    extraHostPathMounts: [
      {
        name: 'ssl-certs',
        mountPath: '/etc/ssl/certs',
        hostPath: '/etc/pki/ca-trust/extracted/pem',
        readOnly: true,
      },
    ],
  },
}
