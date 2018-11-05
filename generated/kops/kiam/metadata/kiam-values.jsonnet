agent:
  gatewayTimeoutCreation: 1s
  host:
    interface: cali+
    iptables: true
    port: 8181
  image:
    tag: v2.8
  nodeSelector:
    node-role.kubernetes.io/node: ""
  tolerations:
  - operator: Exists
  updateStrategy: RollingUpdate
rbac:
  create: true
server:
  extraHostPathMounts:
  - hostPath: /etc/pki/ca-trust/extracted/pem
    mountPath: /etc/ssl/certs
    name: ssl-certs
    readOnly: true
  gatewayTimeoutCreation: 1s
  nodeSelector:
    node-role.kubernetes.io/master: ""
  sessionDuration: 15m
  tolerations:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
    operator: Exists
    value: ""
  updateStrategy: RollingUpdate

