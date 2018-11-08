{
  _cluster+: {
    tier: 'prod',
    region_name: 'sfo2',
    cluster_name: 'do',
    cluster_type: 'digitalocean',
    dns_domain: 'briggs.work',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
    nginx_ingress: { path: 'components/nginx_ingress' },
    external_dns: { path: 'components/external_dns' },
    //guestbook: { path: 'components/guestbook' },
    cert_manager: { path: 'components/cert_manager' },
  },

  external_dns+: {
    extraEnv: {
      CF_API_KEY: 'AgBnob2nqW5nwh11JSXqC1QFlZ2L5xQhiM7icaONxJnSFwqUWdvsKpdwXcD0AwFVSmREmFl0PPOw9zvwO8jlKCgNdoPZIAU/3MwlW1/LNx3EvdHx5Dm9tFVllEKj7cVW3GjjKFO/zwS/UsTBZcMouaneHgSgmeU5+tezCfdfW8SSJQNy84eKN5qNUS7cc1DUgudO3yVsImsd+AlqRIkSu0UzqIWEeuCPSvoaDpmRDy0L/P28omtQSyFrfKqiVvAgfbgDI9X34CVEUZS55qTY/so9POBDCz93RZklza135kw9II3Bg6tXOHPrimiO9Lwy6jyJzCguQMqUh+MNAkVHV1UndK0+9Tf9SE8CbL7p6DeUhkmWJQTHk3/gcG7Dqoh4hu4/5i968yVJe8ZBJ1emdES+BY+9rjKz5FGWUGWrUcLzm54LV71lwziemnQoedXs7QBSWzEtZT4A/6MYvwcwUDhShwleCpDJs15hkuM4/Ndufllu6YLt+dxWZ1ht8is+45vVXSZ3Xa14S+w49QJxi366jDZxYh/UVeq8+ldyy7vnXVZQnDic27YNWV4MXiLyzCzvYPdD6gDqFN8XmbLH1nqmsJPxYVKaBBQ4R+RvellXZJpVQr6gi8LcKuQQ6h8MPCacL+rE28WYuk9PkMS0lno62xD/MlU73+wINMZheUVUdQsoZGvybqdrTB9F6RFJSWcBGcI0tzs1rTHRJwOWidBVdrzxSxAk1wolrw6L/eKJ3dkDgBl7',
      CF_API_EMAIL: 'AgBtSz7VKrEwd8UdTf+EQ6QOfmESUx/RcUCPybqFgkG5QHh8Ysz7wAsYA4OnzXmkR5Nc/20Cfhm7bgtd0vjjuPNMJ7BPZXhHcLMR5pJ4wTEcfaSWhazDiHJbrIPnTq8dIjTXzAZIy1Vqqv/NIEUgfyXjaNc0Sn1yd1FBb2rmKi0cwhra0AOszrb6157lAU4qDPXjGETb9sfYy5UpeduZB89w30d3uCfELQcrb8h0Woxp3EYp6+UpZIp4CyRz10SoAJdZdInrlHwx7XD4IEaGu06varmc/w8LmKrXMsRdkvLf05vs4G60dHV121qbRVFVZqi9DYRNnkPvGLNJr9ZH8SWDoiKjU9WCCnl1Ep8kJis9Ys7buENyazohqbBPhvvcavMzN2Czu6ymMnRAdWUJi0JjuSMQ3rCUB8/WbF3DWxZZhePBcv1Tog5AsF0n7qZw99sX2KQcE6Lo6w7/N8NTl3ZnQCqXB5FgHrqVuBaOSj8EeETXCD1d3k3CKYluyRtoBHxRTTHZvyNPs20wh0z6gbGXwKrNo9q4+YO6tElSUFOXYlkYAAMmWd2Vu4TGsDoodjawp/q87Nhsq/SpIWEpzkPBQuMR3A1s6fhFMnAkv9hbgfI2ABry9cE5fsuT5c0WP+4wwF5BQgkCwivjHxtH+zS0fxBabAmWGL4jL9JzEChdSaQTCg1qLmqx6xnIDKtJ5Vs2exGgsIqrovZlV4J9dzh05XlZ',
    },

    provider: 'cloudflare',
    txtPrefix: 'do',
    txtOwnerId: 'do-lbr',
    domainFilters: [
      'lbrlabs.com',
      'briggs.io',
      'briggs.work',
    ],
    tolerateMasters: false,
  },

  /*
  guestbook+: {
    url: 'gb.briggs.io',
  },
  */

  sealed_secrets+: (import 'sealed-secret.key'),
}
