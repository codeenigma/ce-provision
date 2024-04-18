# AWS Certificate Manager

Fork from https://github.com/FairwindsOps/ansible-acm

Creates AWS certificate requests. Allows for passing a validation domain. From the AWS [documentation](http://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate.html):

> To ensure that email is sent to the administrative addresses for an apex domain, such as example.com, rather than to the administrative addresses for a subdomain, such as test.example.com, specify the ValidationDomain option in the RequestCertificate API or the request-certificate AWS CLI command. This feature is not currently supported in the console.

Additionally, this role attempts to be idempotent by running `aws acm list-certificates` and ensuring that the domain of the cert being requested is not included in the current list of certificates.

Whenever this role runs it will set the `aws_acm_certificate_arn` variable so you have the ARN of the certificate, whether it exists already or it is newly created. If applicable it will *also* set the `aws_acm_obsolete_certificate_arn` variable, so you can choose to use that to automatically delete a certificate that has been replaced later.

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
  domain_name: www.example.com
  extra_domains: [] # list of Subject Alternative Name domains and zones
  #  - domain: www2.example.com
  #    zone: example.com
  #    aws_profile: us-east-1
  validate: true # you need to set this to false if the validation zone is not in Route 53 or you do not have CLI access
  export: false
  route_53:
    aws_profile: "{{ _aws_profile }}" # the zone might not be in the same account as the certificate
    zone: example.com

```

<!--ENDROLEVARS-->
