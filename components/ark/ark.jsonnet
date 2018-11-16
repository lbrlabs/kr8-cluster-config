local helpers = import 'helpers.libsonnet';
local kube = import 'kube.libsonnet';
local kr8_cluster = std.extVar('kr8_cluster');
local parseYaml = std.native('parseYaml');
local config = std.extVar('kr8');

[
  object
  for object in helpers.list(
    helpers.named(parseYaml(std.extVar('inputArk'))) {}
  )
]
