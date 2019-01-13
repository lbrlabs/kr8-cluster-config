local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');
local apptio = import 'apptio.libsonnet';

local psp_roles = {
  unrestricted_psp: kube.ClusterRole('lbr:psp:unrestricted') {
    rules: [
      {
        apiGroups: ['policy'],
        resources: ['podsecuritypolicies'],
        verbs: ['use'],
        resourceNames: ['lbr.000-unrestricted'],
      },

    ],
  },
  restricted_psp: kube.ClusterRole('lbr:psp:restricted') {
    rules: [
      {
        apiGroups: ['policy'],
        resources: ['podsecuritypolicies'],
        verbs: ['use'],
        resourceNames: ['lbr.100-restricted'],
      },

    ],
  },
};

local role_bindings = {
  //Grant Kubelets (via the system:nodes group) permission to use the unrestricted PSP
  node_binding: kube.RoleBinding('lbr:psp:nodes') {
    roleRef_: psp_roles.unrestricted_psp,
    subjects: [
      {
        kind: 'Group',
        name: 'system:nodes',
        apiGroup: 'rbac.authorization.k8s.io',
      },
      {
        kind: 'User',
        apiGroup: 'rbac.authorization.k8s.io',
        name: 'kubelet',
      },
    ],
  },

  //Grant kube-proxy permission to use the unrestricted PSP
  kube_proxy: kube.RoleBinding('lbr:psp:kube-proxy') {
    roleRef_: psp_roles.unrestricted_psp,
    subjects: [
      {
        kind: 'ServiceAccount',
        name: 'kube-proxy',
        namespace: 'kube-system',
      },
    ],
  },

  //Restrict all Service Accounts by default
  service_accounts: kube.ClusterRoleBinding('lbr:psp:restricted') {
    roleRef_: psp_roles.restricted_psp,
    subjects: [
      {
        kind: 'Group',
        name: 'system:serviceaccounts',
        apiGroup: 'rbac.authorization.k8s.io',
      },
    ],
  },

};

kube.objectValues(psp_roles + role_bindings) +
[
  //These namespaces should be unrestricted
  apptio.allserviceaccounts_namespace_binding(psp_roles.unrestricted_psp, ns)
  for ns in config.unrestricted_namespaces
]
