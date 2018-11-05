local kube = import '../../lib/kube.libsonnet';
local config = std.extVar('kr8');
local apptio = import 'apptio.libsonnet';

kube.objectValues(
  {
    agent_secret: apptio.SealedSecret('kiam-agent') {
      data: config.agent_secret,
    },
    server_secret: apptio.SealedSecret('kiam-server') {
      data: config.server_secret,
    },
  }
)
