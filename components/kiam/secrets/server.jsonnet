local kr8_cluster = std.extVar('kr8_cluster');
{
  hosts: [
    'kiam-server',
    'kiam-server:443',
    'localhost',
    'localhost:443',
    'localhost:9610',
  ],
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
