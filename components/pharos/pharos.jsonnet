local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

kube.objectValues(
{

  pharos_service_account: kube.ServiceAccount('pharos') {
    metadata+: {
      namespace: config.namespace,
    },
  },

  pharos_cluster_admin: {
    apiVersion: 'rbac.authorization.k8s.io/v1',
    kind: 'ClusterRoleBinding',
    metadata: {
      name: 'pharos-clusterole-binding',
    },
    roleRef: {
      apiGroup: 'rbac.authorization.k8s.io',
      kind: 'ClusterRole',
      name: 'cluster-admin',
    },
    subjects: [
      {
        kind: 'ServiceAccount',
        name: 'pharos',
        namespace: config.namespace,
      },
    ],
  },

  pharos_deployment: kube.Deployment('pharos') {
      spec+: {
        template+: {
          spec+: {
            serviceAccountName: 'pharos',
            containers_+: {
              pharos: kube.Container('pharos') {
                image: config.image + ':' + config.version,
                args: [
                  '--ignore-resource=gittracks.faros.pusher.com/v1alpha1',
                ],
              },
            },
          },
        },
      },
  },

  pharos_track: {
    apiVersion: 'faros.pusher.com/v1alpha1',
    kind: 'GitTrack',
    metadata: {
      name: 'components',
      namespace: config.namespace,
    },
    spec: {
      repository: 'https://github.com/jaxxstorm/cluster_config',
      reference: 'master',
      subPath: config.subpath,
    },
  },

},
)
