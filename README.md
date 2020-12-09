# terraform module - rancher

Sets up a Rancher server instance on top of OpenStack with support for FreeIPA and an the opporunity for storing backups on a MINIO S3 bucket.

For an overview of the options, checkout [variables.tf](./variables.tf)

## Request SSL Certificate with FreeIPA

First fix selinux context on the data partition:

```sh
chcon -R -t cert_t /opt/rancher/data/ssl
semanage fcontext -a -t cert_t '/opt/rancher/data/ssl(/.*)?'
```

Then create a service and request a certificate (`-g` defines the key size, default is 2048, which is a bit weak these days):

```sh
kinit <admin user>
ipa service-add rancher/$(hostname -f)@EXAMPLE.COM
ipa-getcert request -K rancher/$(hostname -f)@EXAMPLE.COM -k /opt/rancher/data/ssl/key.pem -f /opt/rancher/data/ssl/cert.pem -g 4096
```
