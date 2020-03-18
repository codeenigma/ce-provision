# ClamAV Clamscan

<!--TOC-->
<!--ENDTOC-->
## Configuration
This role will install the ClamAV base package which will allow us to run clamscan on demand and email scan reports to an email address.
NOTE: This approach will not install clamd. Check the clamav_daemon role if this is what you are looking for.

<!--ROLEVARS-->
## Default variables
```yaml
---

clamav_clamscan:

  email: 'admins@example.com'
  schedule: '0 0 * * *'

```

<!--ENDROLEVARS-->
