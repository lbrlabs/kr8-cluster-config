local k = import 'ksonnet.beta.3/k.libsonnet';

local psp = k.policy.v1beta1.podSecurityPolicy;

local unrestricted = psp.new() +
                     psp.mixin.metadata.withName('lbr.000-unrestricted') +
                     psp.mixin.metadata.withAnnotations({ 'seccomp.security.alpha.kubernetes.io/allowedProfileNames': '*' }) +
                     psp.mixin.spec.withPrivileged(true) +
                     psp.mixin.spec.withAllowPrivilegeEscalation(true) +
                     psp.mixin.spec.withAllowedCapabilities('*') +
                     psp.mixin.spec.withVolumes('*') +
                     psp.mixin.spec.withHostNetwork(true) +
                     psp.mixin.spec.withHostPorts([{ min: 0, max: 65535 }]) +
                     psp.mixin.spec.withHostPid(true) +
                     psp.mixin.spec.withHostIpc(true) +
                     psp.mixin.spec.runAsUser.withRule('RunAsAny') +
                     psp.mixin.spec.seLinux.withRule('RunAsAny') +
                     psp.mixin.spec.supplementalGroups.withRule('RunAsAny') +
                     psp.mixin.spec.fsGroup.withRule('RunAsAny');

local restricted = psp.new() +
                   psp.mixin.metadata.withName('lbr.100-restricted') +
                   psp.mixin.metadata.withAnnotations({
                     'seccomp.security.alpha.kubernetes.io/allowedProfileNames': 'docker/default',
                     'seccomp.security.alpha.kubernetes.io/defaultProfileName': 'docker/default',
                   }) +
                   psp.mixin.spec.withPrivileged(false) +
                   psp.mixin.spec.withAllowPrivilegeEscalation(false) +
                   //  This is redundant with non-root + disallow privilege escalation,
                   //  but we can provide it for defense in depth.
                   psp.mixin.spec.withRequiredDropCapabilities('ALL') +
                   psp.mixin.spec.withVolumes(['configMap', 'emptyDir', 'projected', 'secret', 'downwardAPI', 'persistentVolumeClaim']) +
                   psp.mixin.spec.withHostNetwork(false) +
                   psp.mixin.spec.withHostIpc(false) +
                   psp.mixin.spec.withHostPid(false) +
                   psp.mixin.spec.runAsUser.withRule('MustRunAsNonRoot') +
                   psp.mixin.spec.seLinux.withRule('RunAsAny') +
                   // Forbid adding the root group
                   psp.mixin.spec.supplementalGroups.withRule('MustRunAs').withRanges([{ min: 1, max: 65535 }]) +
                   psp.mixin.spec.fsGroup.withRule('MustRunAs').withRanges([{ min: 1, max: 65535 }]) +
                   psp.mixin.spec.withReadOnlyRootFilesystem(true);


[
  k.core.v1.list.new(unrestricted),
  k.core.v1.list.new(restricted),
]
