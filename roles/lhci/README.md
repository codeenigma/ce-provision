# LHCI

Installs the LHCI CLI for automated accessibility and performance testing. See https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/getting-started.md

The role installs `Xvfb` for 'headful' running of Google Chome. This is preconfigured to run in the background with a display ID of 99, so you should run this command before running any `lhci` tests to ensure Chrome has an X session to run in:

```
export DISPLAY=:99
```

Here is an example `lighthouserc.yml` file for running `lhci` in a local `ce-dev` container on a project called 'example':

```yaml
ci:
  collect:
    url:
      - https://www.example.local/
    settings:
      chromeFlags:
        - "--no-sandbox"
        - "--ignore-certificate-errors"
      output: "html"
    numberOfRuns: 1
    headful: true
  upload:
    outputDir: "./reports"
    target: "filesystem"
```

Using this example and executing `lhci collect && lhci upload` in the same directory will make it run a test against https://www.example.local/ and store the report files in `./reports` relative to `lighthouserc.yml`.

<!--ROLEVARS-->
<!--ENDROLEVARS-->
