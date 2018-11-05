local kr8_cluster = std.extVar('kr8_cluster');
{
  CN: 'Kiam Agent',
  key: {
    algo: 'rsa',
    size: 2048,
  },
  names: [
    {
      O: 'Apptio',
      OU: kr8_cluster.cluster_name,
    },
  ],
}
