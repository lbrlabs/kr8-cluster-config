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
    //guestbook: { path: 'components/guestbook' },
    prometheus: { path: 'components/prometheus' },
    //grafana: { path: 'components/grafana' },
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

  sealed_secrets+: (import 'sealed-secret.key'),
}
