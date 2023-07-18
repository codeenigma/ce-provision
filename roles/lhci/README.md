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

You can enable VNC support for an environment by setting the `lhci.enable_vnc` variable to `true` which will install the `x11vnc` package on the target machine. Once this is installed, you can either manually or with CI export your `Xvfb` display from that machine like so:

```
x11vnc -display :99 &
```

Note, this is not protected and should not be enabled in general. See also the ce-deploy CI counterpart: https://github.com/codeenigma/ce-deploy/tree/1.x/roles/lhci_run

<!--ROLEVARS-->
## Default variables
```yaml
---
lhci:
  enable_vnc: false
  chrome_package: google-chrome-stable # optionally set specific version, e.g. google-chrome-stable=112.0.5615.165-1
  # Optional npm version handling.
  # cli_version: '0.12.0'
  # cli_state: latest # uncomment to update to latest package each time ce-provision runs
  # lighthouse_version: '10.1.1'
  # lighthouse_state: latest # uncomment to update to latest package each time ce-provision runs
```

<!--ENDROLEVARS-->
