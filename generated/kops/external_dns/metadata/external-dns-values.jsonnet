domainFilters:
- leebriggs.net
logLevel: debug
nameOverride: external-dns
nodeSelector:
  node-role.kubernetes.io/master: ""
policy: sync
provider: aws
rbac:
  create: true
registry: txt
tolerations:
- effect: NoSchedule
  key: node-role.kubernetes.io/master
  operator: Exists
  value: ""
txtOwnerId: kops
txtPrefix: kops

