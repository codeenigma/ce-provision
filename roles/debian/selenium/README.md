# Selenium role

Install selenium using the standalone version, and chromium as browser.
This role DOES not install any graphic env like Xvfb, tools like 'Google Lighthouse' or 'axe DevTools' do not need it.
These tools can be executed in headless mode, because normally some reports are generated as part of the execution.

<!--ROLEVARS-->
## Default variables
```yaml
---
selenium:
  version: 4.31.0
  port: 4444
  path: "/wd/hub"
  url_server: localhost
```
<!--ENDROLEVARS-->

You can see how selenium is executed in this file templates/start-selenium.sh.j2.
If you stopped, and you need to make selenium available, you can execute:

```
nohup /opt/selenium/start-selenium.sh &
```

And you can stop selenium using:

``` 
/opt/selenium/stop-selenium.sh
```

More browser will be available in future updates

