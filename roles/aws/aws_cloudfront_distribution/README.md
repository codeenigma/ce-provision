# AWS CloudFront distribution
Creates a new AWS CloudFront distribution (CDN) for content delivery.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_cloudfront_distribution:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  tags: {}
  state: present
  aliases: # A list of aliases to serve on.
    - "{{ _domain_name }}"
  validate_certs: false
  viewer_certificate:
    cloudfront_default_certificate: false
    acm_certificate_arn: "" # The certificate must be in us-east-1 for CloudFront.
    ssl_support_method: "sni-only" # Do not include if cloudfront_default_certificate is true.
    #minumum_protocol_version: "TLSv1.2_2019" # If not supplied the AWS default is TLSv1.1_2016.
  origins:
    - custom_origin_config:
        http_port: 80
        https_port: 443
        origin_keepalive_timeout: 5
        origin_read_timeout: 60
        origin_protocol_policy: "https-only"
        origin_ssl_protocols:
          items:
            - "TLSv1.2"
      domain_name: "backend.example.com" # Back end domain name, e.g. the DNS name of the ALB.
      id: "backend-example-com" # Identifying string.
      origin_path: "" # Optional if you to prepend back end calls with a path.
  #s3_origin_access_identity_enabled: false
  default_cache_behavior:
    target_origin_id: "backend-example-com" # Must match the desired origin: id.
    viewer_protocol_policy: redirect-to-https
    allowed_methods:
      items:
        - GET
        - HEAD
        - OPTIONS
        - PUT
        - POST
        - PATCH
        - DELETE
      cached_methods:
        - GET
        - HEAD
        - OPTIONS
    min_ttl: 0
    max_ttl: 300000
    default_ttl: 3600
    forwarded_values:
      query_string: true
      cookies:
        forward: whitelist
        whitelisted_names:
          - "SESS*"
      headers:
        - 'Accept'
        - 'Authorization'
        - 'Host'
    smooth_streaming: false
    compress: true
  cache_behaviors: [] # A list of cache behaviors same as default_cache_behavior with additional path_pattern var required.
  enabled: true
  purge_existing: true # Set to false to append entries instead of replacing them.

```

<!--ENDROLEVARS-->
