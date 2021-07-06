# solr
If you need to install SOLR, you can do so by adding geerlingguy.solr to the custom galaxy-requirements.yml file in your config repo (see the ce-provision role) and then importing that same role in your playbook. Because of this we don't set any defaults, but here's an excerpt of the interesting ones.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
solr:
  # Pick a SOLR version.
  solr_version: "8.6.0"

  solr_port: "8983"

  solr_xms: "256M"
  solr_xmx: "512M"


  # List of cores to create. Removing one from the list after it's created will not delete it from the server.
  solr_cores:
    - collection1

```

<!--ENDROLEVARS-->
