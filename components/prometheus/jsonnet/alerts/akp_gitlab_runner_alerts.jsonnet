{
  // New rules
  prometheusRules+:: {
    groups+: [
      {
        name: 'akp-gitlab-runner.alerts',
        rules: [
          {
            expr: 'changes(ci_runner_errors[10m]) > 0',
            alert: 'GitlabRunnerError',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summmary: 'Errors on gitlab runner',
              description: 'There are more than 1 errors on gitlab runner within last 10 minutes',
            },
          },
        ],
      },
    ],
  },
}
