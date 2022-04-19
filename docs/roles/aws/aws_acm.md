# AWS Certificate Manager

Fork from https://github.com/FairwindsOps/ansible-acm

Creates AWS certificate requests. Allows for passing a validation domain. From the AWS [documentation](http://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate.html):

> To ensure that email is sent to the administrative addresses for an apex domain, such as example.com, rather than to the administrative addresses for a subdomain, such as test.example.com, specify the ValidationDomain option in the RequestCertificate API or the request-certificate AWS CLI command. This feature is not currently supported in the console.

Additionally, this role attempts to be idempotent by running `aws acm list-certificates` and ensuring that the domain of the cert being requested is not included in the current list of certificates.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_acm:
  region: "{{ _aws_region }}"
  aws_profile: "{{ _aws_profile }}"
  tags: "{{ _aws_tags }}"
  domain_name: subdomain.example.com
  validate: true # you need to set this to false if the validation zone is not in Route 53 or you do not have CLI access
  export: true
  route_53:
    aws_profile: "{{ _aws_profile }}" # the zone might not be in the same account as the certificate
    state: present
    zone: example.com

```

<!--ENDROLEVARS-->
