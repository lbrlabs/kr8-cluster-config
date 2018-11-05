local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

// remove Secret objects
[
  if object.kind == 'Secret' then {} else object
  for object in helpers.helmInput
]
