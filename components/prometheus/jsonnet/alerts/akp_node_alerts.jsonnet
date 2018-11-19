{
  // New rules
  prometheusRules+:: {
    groups+: [
      {
        name: 'akp-k8s-kubelet.alerts',
        rules: [
          {
            expr: 'kube_node_status_condition{job="kube-state-metrics",condition="DiskPressure", status="true"} == 1',
            alert: 'KubeNodeDiskPressure',
            labels: {
              severity: 'warning',
            },
            'for': '5m',
            annotations: {
              summmary: 'Disk Pressure on node',
              description: 'Disk Pressure on node {{ $labels.node }}',
            },
          },
          {
            expr: 'kube_node_status_condition{job="kube-state-metrics",condition="OutOfDisk", status="true"} == 1',
            alert: 'KubeNodeOutOfDisk',
            labels: {
              severity: 'warning',
            },
            'for': '5m',
            annotations: {
              summmary: 'Out of disk on node',
              description: 'Out of disk on node {{ $labels.node }}',
            },
          },
          {
            expr: 'kube_node_status_condition{job="kube-state-metrics",condition="MemoryPressure", status="true"} == 1',
            alert: 'KubeNodeMemoryPressure',
            labels: {
              severity: 'warning',
            },
            'for': '5m',
            annotations: {
              summmary: 'Memory Pressure on node',
              description: 'Memory Pressure on node {{ $labels.node }}',
            },
          },
          {
            expr: '(kube_node_spec_taint{key!="node-role.kubernetes.io/master"} and on (node) kube_node_labels {label_kubernetes_io_role = "master"}) == 1',
            alert: 'KubeMasterNodeMissingTaint',
            labels: {
              severity: 'critical',
            },
            'for': '5m',
            annotations: {
              summmary: 'Master node is missing taint',
              description: 'Master taint missing for master {{ $labels.node }}',
            },
          },
        ],
      },
    ],
  },
}
