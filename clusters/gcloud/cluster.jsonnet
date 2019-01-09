{
  _cluster+: {
    tier: 'dev',
    region_name: 'us-west1',
    cluster_name: 'gcloud',
    cluster_type: 'gke',
    dns_domain: 'lbrlabs.com',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
    nginx_ingress: { path: 'components/nginx_ingress' },
    external_dns: { path: 'components/external_dns' },
    cert_manager: { path: 'components/cert_manager' },
    prometheus: { path: 'components/prometheus' },
    pharos: { path: 'components/pharos' },
    ark: { path: 'components/ark' },
    ark_location_gcloud: { path: 'components/ark_location' },
  },


  pharos+: {
    subpath: 'generated/gcloud',
  },
  guestbook+: {
    url: 'guestbook.lbrlabs.com',
  },
  external_dns+: {
    extraEnv: {
      CF_API_KEY: 'AgCwfJ1jnneJM2v4AfH/K6xSuL8limGGSntRxW54EWcm1DjWYPMv0RdBPUSPdm6aYFNdLxdb5MAVVWCio3RuxCiNuhFjzQcW7VzzVwyHTh2ev8vMpbu9GrC1liz5cTMDEoaxO/EsJ2h4bO9dUmfBCygBnXuIqpt3POzAiwzNkhvQLNxBZuvuea1n/ZGxec6rA1cmu/P/TqV2rXeWqamr2WLUAM40w3WUXGkxXANGBAPLlgd5pMUtR06h+JHlnB1S1pRzzdGJF3lS6ra0qh8VW30OtVFM8+Ug2GHR4OwCuE21EQ/jgjrf6+xTbQ3jKfY3un1gwUyyrDWM2wP/IojyT3o0/UxO7sTHLqUfhY/3mW291JHncl5mowDZe79iOHN2nvva0N5qHE0zdBxgR0Y4/jFeLJ2rn9rooj8b7zcfBLyKK7ZR1zrf85hfwAmS0eMIKqyqvy9F3xy5+x0PbwmDEzZH5scj8Ha4uFDuaf+VHvU/eLwPnlcpi2x32ah5Rgd9hy2MmTW7KLqJFUWkSuJHFZKOwBlJltPFtWft9/KnC/OsuqrwmbH+eNeCq/FVmUjrKzqpcCR73fisLSDj9ESm/WUOd3pHNgJqulau1oqs86gs55agH9CXX3xeIQTPy0NqGvBIjvAAN53TRXfRRTX2Bv1wycrln4dC3esueDDo2bY4akpkkfqbKcAkFY7upZXwK7SZjlyC4TzgoWuxy9IbZfejhfT6kT0B6pZEvCKWGJbYl2a5y8X3',
      CF_API_EMAIL: 'AgADc4Huy+twMefddwn9FoaswqbKWkiJ0m41F4NVY5dkKXLTfWRtBtkydk77esETR+VYljTuMV0/2WyttFIC6GWO0aRWH9m6k58ZqzO5Qz4B27RCe+pLFfDPJEazyMXGzyKG8t0jtYXUpzNv5v6lk2uWzCvdhDOXq1/QpxI066QRsoLPdOjraHBvxRHEw4nxI6pAm8rsVUEXFff9Me7b92spuY2g3BtpPjg2e6rsm7jip79yUydGKCEvTixnV8nW0bej3/Bf/IHCKyDl6eSHY276D6zL1q40jyq0EaKLRwsErfmqNBKbNwnI9tDEuY0Dh7NG74C4BPECvuOCp8nC6Jv3IBLd7OnoLwQfw3qtgTR1DicZVXVF4HdImg43fBFc98kgLBuXvg+QpuobZOJx3kw4EeR95aOn/yBAhUlUq43Fvuq1KyA7nFwtmWbkjulC6sFe7D4xZX6cd2CmLFafnFT1e9oYP4Fq+VPduNMyPFgV6EZrNrsBSVTET8qVE3EQA3NXgpcsm5wf0+PgItbSRBJE2F2s2Bd7bqLZfOi8+JG4ucVNap8J0bm7wPmwhXuJd7LgQt07JiVaWmAARaFJX6H6znjaNfHo7d890IemZpJAP02zqffzBpFzV3JEY0FkoJCFc5052s0fSh/IwDbrlV5lFvZm7ZwEaikjiGyXi+IuMD65AQout3sJCHS2Tcsp/tDjVuA/n3FCMy+Xca1UCKH/V2XE',
    },

    provider: 'cloudflare',
    txtPrefix: 'gcloud',
    txtOwnerId: 'gcloud-lbr',
    domainFilters: [
      'lbrlabs.com',
      'briggs.io',
      'briggs.work',
    ],
  },

  prometheus+: {
    ingress_class: 'nginx',
    ingress_enabled: true,
    prometheus+: {
      externalName: 'gcloud-prometheus.lbrlabs.com',
    },
    password+: 'AgDLNaXOhGgxdSWquOVjLD8Om3joOlhhFIvzxPWG6Qz5EU7r6bS4VP1kRa92aaBKM2LZJajSCV//+0niQXCqKYaR8L+YArBEMu6pFdiFGYtoi04ZOv7EbB4f6f0cofP3wdZX5DAwAAPT4YKmh53Y0g8JWVbwuP30uUZg0F6DJrVO2TBnvM3+drQ6Cc5FEYXiIGmvVWEWfDn4cq/jQXYa3T6XzSj3Exp3VxlEoxkPXl9wjl+bhL7L1NmypcFOBdJN7A94QK3sxsEN5kwJ7aZMn3JXh0leuQHuS9xlJX7qZiRLBXTl3OrRn4FpMc3qNkLV2/i8WevlPglraMOfsnLFem2RriqxifcpsZ4TR59IgJDlwtYFM0PFVzFrY795PC5jmYSy+CBHxORBWKRbN7pQyunFZYwXyb22vBuOKGqTxG7bYi2Szx9XoT21q86BsUBQaIzv1zsWPq6FBcGYfTnRJZ0fSeujBczHsoIs0RxADRYEXU1pLwSvTg74yZ8MA8/yzO8xcMhHfhvuzpdtrpuXXAF2IeIZYXGLfCY6i1cmpvGa/QcTMdKMqUSJ1/VhVkuRSq0nQnu+zR0trf8KEccneaVJCQqnU6KyQxNioKyo7N8yPTp5RwSsYSdx5yYnUGbanLDAm2CP7ermZvMRw43AYK+yCwvIecoLE/iXM1syaIYVdC8fWhauELUrcvMgu9W01MsVgO/lS/Rq+6IppToH7ZxM9wEuVdgLouG4v1DNTQfTQ+esMOXwNI35zwKd4Q==',
  },
  grafana+: {
    ingress_name: 'grafana.lbrlabs.com',
  },
  ark+: {
    cloud_credentials: {
      cloud: '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',
    },
  },

  ark_location_gcloud+: {
    backup_name: 'default',
    bucket_name: 'lbrlabs-ark',
    cloud_provider: 'gcp',
    backup_config: {},
    volume_provider: 'gcp',
    volume_name: 'default',
    volume_config: {},
  },

  sealed_secrets+: (import 'sealed-secret.key'),
}
