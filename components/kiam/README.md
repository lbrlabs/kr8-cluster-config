
tls keys in sealed secrets for the server and agent must be generated. Generate secret files, based upon the process here

https://github.com/uswitch/kiam/blob/master/docs/TLS.md


```
go get -u github.com/cloudflare/cfssl/cmd/...
mkdir tmp
cd tmp
rm -f *
```


To create/recreate secrets for a cluster, first make sure that sealed secrets is already operational in the cluster.

In the component's directory, run the "secrets" task, with KR8_CLUSTER environment variable set to the cluster name. This needs to talk to the cluster, and the default
context is "${USER}@${KR8_CLUSTER}". Set the KR8_CONTEXT as a task parameter, to override the context:

```
$ KR8_CLUSTER=uw2d-k2 task secrets KR8_CONTEXT=cspargo@uw2d2
```

If this runs successfully, this will produce a file called tmp/kiam-secrets.json containing the secrets.

Copy this file into the cluster's directory and add it to the git repo.

```
$ cp tmp/kiam-secrets.json $KR8_BASE/clusters/development/uw2d/uw2d-k2
$ git add $KR8_BASE/clusters/development/uw2d/uw2d-k2/kiam-secrets.json
```

Add params for this component to reference the secrets file. For this example, edit $KR8_BASE/clusters/development/uw2d/uw2d-k2/cluster.jsonnet

```
  _components+: {
    ..
    kiam: { path: 'components/kiam' },
  },
  kiam+: (import 'kiam-secrets.json') + {
    ... extra params go here
  },
  
```


