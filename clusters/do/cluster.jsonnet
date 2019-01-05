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
    //ark: { path: 'components/ark' },
    //ark_location_do: { path: 'components/ark_location' },
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

  guestbook+: {
    url: 'gb.briggs.io',
  },
  ark+: {
    cloud_credentials: {
      cloud: 'AgBjZfjtvXNa1Kf1tomi2bJ+xv8sp9dSSA/5rzdorzJ0k6u7QLvN4F2TQIVSWOlNZJxRr5RBqGN5IKuiYCJOiPnnJjfwlkZGAw/TsPckfs9YgAsLwzmCITL3Bqv32EGjEhrvsCnNP3fbbIkVmvls/Fx59N1FZl/zSeEfTNBn23/u5YndRsNWUsIydkE8Sca5OI6hX4NTndlP01XSg10WJUC94S4N4Uk/NGltA2viJbNYCJrDcB+uBS77IEiSxDe7/lLFPzT6jMkwqtC0MY5hkLZZu2QeeaPqnqpqaGqmfQLUWkbCjtD6/L+KuF+PYWVYpd0NmoG05CuiQXxmEEnOssgAMiVIxH0Yk3qBmsncZJFE0gOexB71XxYvdsZ/iwo/HmZbDj67cAPmHeTYCyXCeyIa07SziJMySUChzBKRgucaji2/jyiu85BhJVgpOferTmnVc4ipZDRbhSWsGc+UW20ZkbDnM5cc9P/5xruUbzG66UXqoYTzHC34UQFz1lOEbPdyEGWq8mRaTNOmFVWJmGK9h2K8fDyVOUyq4gYETUPuFJWFDLi8tYqG9Jj30VSFWmMkVAIonkf7QgFQuBWgtc/h25J+0tA39at+QJJVC8zTA/nMJc1fJ7kf17XbcYJt5q4W9DGuupoB13iypyweYNhXthOOWHYbMxgQSYPGX5jouNQoIy2q+Iv4a7ctbJ26pZyDXjg0Howwdcdwzjvn5iRqc+bqi9jNPuzAAhivLp8rw42nalDvyIrOzk28zmTW2a4B4hWPla1VmFBBdiMvbSiu63ezZocyWoYqSMyGAiraNap9ERQvDf7235PIsbgA+qilXH9g9Q6kPSHQoVulYDM0uWgr',
      digitalocean_token: 'AgAfJqcBNfHr5i5zRdSqghMkmgAspRgr/dFMakCn54mky1qumUR3OTKG2/GOo8Y2Qe67dRcfo6+NB+cdFzrk4+Lo5tDpujVbVwDyxxonUKUU9u0Vk6BJak4yKgfqC2PRj2mdp7SJRPlYZt0psC8CRUqAvhm9R34Tc1bq5jdKrcAH8P9ouvcHd+sMzej1xLAXNEr8b34jhdh4tULL9iXiRbDR0xWU1jPH8I17cj2QRDS6VSsn611hr83NL62747uLbbryKL3lf9u/4UtlX73l+DDKpGoyLVgbvK83M0ekojRVaYZRuIFeJ3mDM03o5/yoa1T+4pNRgB7CAiiLrWjQYNoJP/fDdMJrkGQ041q/z8TimcwQNIlBsS7zVFSLKR0shIFNO8F/+kg5WxFkIxPldgimYQYn9jYMmbg0aopGlrSKNyz2rjC0ZgIhNqPXXoJsNTiYiPymU0zB3FzcCX9yYvFSuXmQ79p1doY5eTaSo2Fq9E1B00iOMqTjTi2dQUBczs0gaGj3+1Nq2NONCwcXU8gsbO9o3C8AJRqqHG21ZSbapoiSqY8vSR4Ju8EWRAMU74K0hAOc8pQs7H6Caag5XCGuIv1FZBREeUk9aLEoxcrxzYXo1pdAlrGunPDMckCkT3RPx5sBTA95ZlUsxOJ0yy0VCFeXR1xpi8GebOgvCXKDGAfifi+bjS982NxW1jt5yFuAm/k4fJUwPkFdgwg4d0yyXpKNMni0f91iISiPPt6ENscHmL6OxXCPZcJK5QIT9aplvWQGMYdya4FSMCOAgYB7',
    },
  },
  ark_location_do+: {
    name: 'default',
    bucket_name: 'lbrlabs-ark',
    cloud_provider: 'aws',  // the ark plugin is s3 compat
    config: {
      s3Url: 'https://sfo2.digitaloceanspaces.com',
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
