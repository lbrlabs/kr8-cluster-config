local apptio = import 'apptio.libsonnet';
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

{
  prometheus_password: apptio.SealedSecret('prometheus-password') {
    data: {
      auth: config.password,
    },
  },
}
