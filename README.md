# Factom Terraform and Ansible

This project contains Terraform projects with Ansible.

**As of July 9th: This project is in alpha stage. It is derived, and not cloned, from
code developed by LayerTech. Attempting to use this project is risky at this time.**

**If you find any security concerns, do not open an Issue or PR. Please email
tech@layertech.io or use discord to contact Xavierwjc#3480 or tomjm#6844**

## Why Terraform?

Terraform is a tool for building and changing infrastructure. infrastructure
may be on Google Cloud, AWS, Azure, Open Stack, or a number of other cloud
based infrastructure systems.

Terraform is "infrastructure as code" and as such can be checked into SCM
and versioned. As opposed to manually configuring infrastructure with a dashboard
or Bash scripts, Terraform behaves idempotently and immutably. This makes
updates safer to perform, and complete rebuilds a trivial matter.

## Why Ansible?

Ansible is a "configuration as code" and can be checked into and versioned in
SCM. This will allow changes and updates to be applied to servers. Additionally
during a complete rebuild these scripts can provision a new Authority Node and
all it needs to begin operation.

### Why This Combination?

This provides and auditable trail to managing changes to servers, including
software updates and patches. This makes disaster recovery a trivial,
automated, and fast affair. Were a flaw, beyond your control, were to allow
malicious users access to the server to install a rootkit, you have the tools
to build a perfect copy on fresh servers in minutes. Changes are low risk; it is
inevitable that you will need to update packages on your servers. This approach
makes it safe to apply changes and recover if something were to fail.

One great business risk to administering servers with SSH only is the creeping
problem of a (SnowflakeServer)[https://martinfowler.com/bliki/SnowflakeServer.html].

Terraform and Ansible ensure that no hidden dependencies become critical to
your uptime.

## How This Project is Organized

Each directory targets a specific cloud provider--except for the ansible directory,
which will apply to any compatible OS. At this time, we have a
directory for Google Cloud Platform (`gcp`). It includes terraform files. After
running terraform, you must follow up with ansible to
provision the servers you've created with terraform. After the node synchronizes
with the Factom network, you will have a fully operational node.
