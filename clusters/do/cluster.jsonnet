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
    ark: { path: 'components/ark' },
    ark_location_do: { path: 'components/ark_location' },
    pharos: { path: 'components/pharos' },
    //prometheus: { path: 'components/prometheus' },
    //grafana: { path: 'components/grafana' },
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
  pharos+: {
    subpath: 'generated/do',
  },

  guestbook+: {
    url: 'gb.briggs.io',
  },
  ark+: {
    cloud_credentials: {
      cloud: 'AgBqhDgS4a4cnJ5ETTUCv+xOOK1eV23lb5IoXiqI2USCmbTiDTSojBJnF9kTIZzMUjlgjXGnfV3FfTA7a+KV5urmJCGv3WkrzvxI7nH0mu4CF769071WVJviR9MLGPMYgYG2JvCY5ijLsyb6xtJ+e319tDTS9rVQSLfocu/hyPhzVjJpTdGSh71d8neKditM/3syWsF9rOq6374gqjSl4Xs12vchnoBEpIaMRjquNTkjnBgxr/uOTnfG4+MKVRV/Q/RAO5pru7eKpaPxdeB0wXjFTlc409TkyX78mtiJdwTJ7hL4DU9peRkPlb1JLBKMWLz/RxKzZjhdMlbMTVyOhhO9uTppN32aRqobkZ7lvBMvUnrkQrBwQ45nOcFJ6XxGsOkqafs39eSj/sRfFW7ddnlGMopw2tfw4eS4wcBThbx8bm/9GGfMUzuXlFPNCji3/RZyaRIVEGoVEeBgnntWLny85v3SAyJrK50Gycocbmfw9BYDpEczViU79XhLn+Biwc2oH4mcAEXvJZjnXfFB67o88sN4SKKFfsnjIufylP9e6QRls0sXWg1sNEMqO6mvL8CbwfvJQKbjBre9FReJ3whUmSwrmO2yWuP39Wu1nHTmyJeTOXE7H0K7LNbg9JMCz1V/dXx4tjc3QU94E0M0O2tBppcldkJLhu/0ap57H+On7oOIFD9iwa3UkJ5UAZfJQ9ja+bXMp1y6iAr/Lusn2wq0zImC8LRwD6sWC3ye8ppqDpB8IpCMjxLjuYHD8dUgRHZn/3wxM1TnBtjOCymtos4Q4GVfRhUzsAl2DtahpPLgWMWIcUQFz/cFX3DKIuJ1YjeoFhGBpGGW84VfyctFagchXWqk',
      digitalocean_token: 'AgBVh+30kTtIDaSlZbEvMDBL5KmjcsQ2OvwBXtPab13hCIxrlQMTZp96uhGeNM+JiYHpxaQ2mUvhsC4oSLBnQ5FjTOKS0eZc8JvYNqAfRc7YjzNEpfaWFWE2KmBweLgvc0JvxhxjX2+250sSVL46lqnaF9f0msEdATd8z8Rcsk/v/qcE9vomJOxvvKB0iaYLdoBFd6Y6wf5QXYUQNxDzHlfEnHvDitLVfS4LEQutmKpnS5GVT8XqN/CFPFgGjZwjjiJhoKo1mXS+rPa7PL30vCAq1pCtSqxZNNNThNKK91+btp8KjTUkNMcANmTEAzSYyLBx34mvn5nen6T5x58ebfnzanitM/edCDrkotDjrbmquqOs4T5Ax4wPIYLI3igevbmPWdEaX/BzRC75b6IDQ70FOyUQWTu2uXQrB2YMqbtXGBGcSJ6mHI5EaZx4PDHZ/YsUl/jNp0OvEZs1f8IiV7sy9U1k4/rXpskrzz3N8y2qf3bTwJI46Ha58HbdG3toaYM9SO1vYx2hS64zgw1YduZh01l4H/ooMojiqEAzhjTgUHdP0KpIVfrdvdhIpEwnWuW2u8zR1a097Uvnx1fXW0bILPANWfsWpeXx4A6i4BGzDZWm2qArOMQ4T2blGpi5+ezGnVN7Q4aWzRNM1yz3E/bwJbBrGZ867X7N4c3Omb0LOClhw7fSC6ufoxRHceflTI0o4iKOsuItfvsHKVdgpJ+O4mAHYVpnmHu+ObmJZJ1tzRZc5YmFznbm9rSjR9LQO3EdJPjL7LELjOf9OYb7FnDv',
    },
  },
  ark_location_do+: {
    backup_name: 'default',
    bucket_name: 'lbrlabs',
    cloud_provider: 'aws',
    backup_config: {
      region: $._cluster.region_name,
      s3Url: 'https://sfo2.digitaloceanspaces.com',
    },
    volume_provider: 'digitalocean-blockstore',
    volume_name: 'default',
    volume_config: {
      region: $._cluster.region_name,
    },
  },
  prometheus+: {
    ingress_class: 'nginx',
    prometheus+: {
      externalName: 'prometheus.briggs.io',
    },
  },

  grafana+: {
    ingress_name: 'grafana.briggs.io',
  },

  sealed_secrets+: (import 'sealed-secret.key'),
}
