{
  // New rules
  prometheusRules+:: {
    groups+: [
      {
        // control plane recording rules
        name: 'akp-k8s-controlplane.rules',
        local apiserver_latency(quantile) = {
          expr: 'histogram_quantile(' + quantile + ', rate(apiserver_request_latencies_bucket[5m])) / 1e+06',
          record: 'apiserver_latency_seconds:quantile',
          labels: {
            quantile: std.toString(quantile),
          },
        },
        local scheduler_latency(metric, quantile) = {
          expr: 'histogram_quantile(' + quantile + ', sum(' + metric + '_microseconds_bucket) BY (le, cluster)) / 1e+06',
          record: 'cluster:' + metric + '_seconds:quantile',
          labels: {
            quantile: std.toString(quantile),
          },
        },
        rules: [
          apiserver_latency(quantile)
          for quantile in ['0.99', '0.9', '0.5']
        ] + [
          scheduler_latency(metric, quantile)
          for metric in ['scheduler_e2e_scheduling_latency', 'scheduler_scheduling_algorithm_latency', 'scheduler_binding_latency']
          for quantile in ['0.99', '0.9', '0.5']
        ],
      },
    ],
  },
  //  test: $.prometheusRules,
}
