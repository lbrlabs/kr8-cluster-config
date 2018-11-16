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

  guestbook+: {
    url: 'gb.briggs.io',
  },
  ark+: {
    cloud_credentials: {
      cloud: 'AgB/cg751+zDsGq3zyTIzx4FomtyF2iLp4dbqSDN0235RSFLH65A/WgnG8uwew79hGcbOskgcQNPKJvQnd9S77eKsg2hukiVKxew0aSFWnkbyVNO0YegY3+kd/GJ2cIm2rBBYeZIZSh4SZgKbIehV72LO8FmsB+LrAvIc58QewymAcow28mp+qFnZ4bPSqB6qbSmN3NyphQ4jEftLWzIidhZudcN6S959WntwNJwoapQS2Y5YMa+1b+p4YnIoX/wNQ4ki3Pwoi8MtW0AwsJqWkT1Z4xuh7HnM1uQqCb2YG3AAwmKZ4qmbARAPi/KAvjzYLONeWuPityp9O/qccZCMRdMS9NXzg14QiZMSqzPt0Y7xQpOn/bNfafV6GMkR6Apjh3vJrGCQ3gqL2iHouvj8vTYwuv+omlWlOmy74xKka6DiVorpfPUSF0n/EKGvEL0zHqEp6pTHKlEOd/X2+WXn6qpuPGrArEujTXJp+P4fwTH4wCP+tfHFYdtc99k1bV5jLjnzjEhItD45X7n7j2QSQ4UyBUrQ2HApHo4S7HyZ6OurdABMzTrBHpWI4CRhOTiis0ezl9qnFbPQXw5+TgRH3AvFe3y47t9x9KQSmPn/Tw1UgyUt1QgiLY0bwJF6OF+l98lKcJO+/As2oTimrAV7osyCYnEIFfVFwnTVScPbtGCEvpe8cspEH1BJu+s3nvA5Q58dQ2iFjcW6hGfZ45za8bLj7bncwzi3FKWtAClHlvkPcS5JpTzR8sa+g6wNrKYbSV6W7i+WmGgoTry4pVAxtA+RA4xW5t36GfCSMm7r4jGBInXOVitnWyXuBsI/ehXHa3PNcb8vmsH/dovMzJ+1dmRdWZq',
      digitalocean_token: 'AgAO4Xnf1kLIEqGsbx3j/vDe97RZtKINDYZr1AZzzevUerx99BkpZonPEqDnLUFsdxDGD644FMqamVXsmvSxHirA1ZsJ/NUqsZ4lkUPmBwhyThgR2vTBiZuQHgPxGH5REsPJD4R5QPZU78OPoKX8F3KM+Jgn3KXApudpuGMulUBZ6LDxd5E9+V/H9UYXnhDYnKJnhMSLB3NCgIMn5GizZwRoGct700l1E3wvDZC9/7Cyuxf01LPONlT2s08pikDPuA8cXLC5qYCcZLg4k39y7dJlaaGoifuD2rw3T6U59NqfxAIfO7AjuP/6Syfu3A8wCAT1YhTscH8mLgJfVkeQa+CGvUbsZfPQn0fjlxTQ07M53bx6hD/t5UHCoIDEL1TsiqNz7Q0O+7WApcehDXo6kJdDGsf0CLXmAFV9cx90dzVW9L4kuOOQ0OVyny0m1EcPtH5yfeF2ji5rhmbyD4J+RPkPEKXiDrA7dI2ZnUeGR+5CtkbW50/S8TULSl746c2zv6xvl87OGORlf2EW5Clw1Z4C//bArBacnIr9n0RpQ04u96VKC29XtgXKqsuCcbK8Z33+n/U1oURaQjEssyUaCSXObplXlYgFaPtdlkVo/+oBPhkIjQAvRjSwaqkqFN59LwQsj9i8ectQ0UWOCqQuD2/R/XifWHwrKc/x6ZDlnQiW+FZkMCVLk/iqi0Lu3tSsPBtPEK0KuTs2YfyM5FWljdB0YBpCRDik5Rv9KY7Z6c0kN2E+DTuke3vBwnrOD54nFsc+p/kv3aejOMCnZa/gsRQt',
    },
  },
  ark_location_do+: {
    release_name: 'ark-backup-do',
    bucket_name: 'lbrlabs-ark',
    cloud_provider: 'aws',  // the ark plugin is s3 compat
    s3_url: 'https://sfo2.digitaloceanspaces.com',
  },

  sealed_secrets+: (import 'sealed-secret.key'),
}
