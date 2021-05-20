# AWS IAM SAML
Creates the necessary policies and roles for SAML-based SSO in AWS and optionally creates Service Provider (SP) includes for [SimpleSAMLphp](https://simplesamlphp.org/).

All tasks in this role are optional and can be skipped by simply not presenting a variable.

Variables are generic for AWS SAML configuration up until the `saml_metadata_document` variable. Groups are intended to be LDAP groups, but in reality they can be any array of values you wish to pass to AWS to match against the `eduPersonAffiliation` SAML attribute on login.

Variables from `linotp_server` onwards assume you use SimpleSAMLphp as your organisation's SAML Identity Provider (IdP) and should not be used unless you have a SimpleSAMLphp instance set up in a specific way.

<!--TOC-->
<!--ENDTOC-->

## Configuring SimpleSAMLphp
If you do not wish to make use of the automatic SimpleSAMLphp configuration you can simply ignore this section, with the default variables all the tasks will be skipped. If you do wish to use these tasks then you will need to ensure your provisioning server can commit to a Git repository that contains your SimpleSAMLphp configuration code. How you organise your SimpleSAMLphp repo is up to you, however there are some important points about config file organisation below.

The role will create two SimpleSAMLphp files, an include file intended to be used to populate a consolidated login page of a series of AWS accounts, as you might require for a support team or IT department, and an SP for the AWS account. If you do not wish to use either of these files you can simply disregard them and the ensuing instructions.

As you will probably have several SPs and the `saml20-sp-remote.php` file can quickly get unmanageably long, we recommend you put each SP in an include file. That is the assumed behaviour of this role, that's why it creates an array of SP metadata for a single SP in a file of its own (see the `templates/simplesamlphp_sp.j2` template file). Here is an example of an `saml20-sp-remote.php` file using includes:

```php
<?php
foreach (glob("/path/to/your/service-providers/*.php") as $filename)
{
  include($filename);
}
```

As long as this role has the `saml_sp_path` variable set to match the path you are including your SP files and you have provided the `X509Certificate` data required in the `saml_sp_certificate` variable, Ansible will build the file from the template and put it in the right place in your repository and the SP be available on a URL similar to this one, where `123456789012` is the AWS account number:

* https://www.example.com/simplesamlphp/saml2/idp/SSOService.php?spentityid=urn:amazon:123456789012

We set our SimpleSAMLphp repo to build automatically on change, if you do not then you will of course need to manually deploy the SimpleSAMLphp configuration to your IdP before the SP becomes available.

As we stated already, you can completely disregard the consolidated login page include file, however if you wish to make use of it here is a PHP code snippet leveraging the `core:PHP` filter which you can use as an `authproc` filter in the metadata for your AWS consolidated login page. We assume this metadata would be within another include file in the same directory you specified under `saml_sp_path`:

```php
    15 => array(
      'class' => 'core:PHP',
      'code' => '
        # Make $attributes global so includes can use it
        global $attributes;
        $attributes = $state["Attributes"];
        $aws_accounts = array();
        # Loop through our include files which array_push() into $aws_accounts
        # Array of AWS ARNs built by the includes in the "aws" directory
        foreach (glob("/path/to/your/includes/*.php") as $filename) {
          include($filename);
        }
        # Save the array back into state for later
        $state["Attributes"]["https://aws.amazon.com/SAML/Attributes/Role"] = $aws_accounts;
      ',
    ),
```

If you use the above, clearly `path/to/your/includes` needs to match the `saml_include_path` variable in this role.

To make use of the [LinOTP2](https://linotp.org/) integration supported here, see our SimpleSAMLphp module on GitHub: https://github.com/codeenigma/ce2fa

If you intend to use LDAP groups for the groups variables you will need to configure the `ldap` module for SimpleSAMLphp correctly, specifically the `ldap:AttributeAddUsersGroups` filter which is documented here: https://simplesamlphp.org/docs/stable/ldap:ldap#section_3

Be sure to leave the default attribute name `groups` as is, this role assumes that is the case.

## Dependencies
This requires boto and AWS-CLI on the provisioning server.


<!--ROLEVARS-->
## Default variables
```yaml
aws_iam_saml:
  aws_profile: "{{ _aws_profile }}" # Boto profile to use for AWS connections
  region: "eu-west-2" # AWS region to use
  tags: [] # AWS tags to apply
  aws_account_alias: "" # IAM account alias - human readable name to order SSO page
  provider_name: "SAMLProvider" # The name of your SAML provider in the AWS console
  admin_role: "Administrators" # The name of your admin IAM role in the AWS console
  admin_groups: [] # An array of groups you wish to permit to assume the admin IAM role
  readonly_role: "ReadOnly" # The name of your read-only IAM role in the AWS console
  readonly_groups: [] # An array of groups you wish to permit to assume the read-only IAM role
  billing_role: "Billing" # The name of your billing access IAM role in the AWS console
  billing_policy: "BillingPolicy" # The name of the customer-managed IAM policy to allow billing access only
  billing_groups: [] # An array of groups you wish to permit to assume the billing access IAM role
  saml_metadata_document: "" # The SAML metadata from your IdP in multiline XML format
  linotp_server: "" # Optional LinOTP endpoint URL for 2FA
  saml_repository: "" # Git repository URL for SimpleSAMLphp
  saml_repository_directory: "simplesamlphp" # Temp directory to clone SimpleSAMLphp into
  saml_repository_branch: "master" # Branch of SimpleSAMLphp repo to work in
  saml_include_path: "" # Location to save the AWS admin include
  saml_sp_path: "" # Location to save account-specific SP in
  saml_sp_certificate: "" # The value for the X509Certificate
```

<!--ENDROLEVARS-->
