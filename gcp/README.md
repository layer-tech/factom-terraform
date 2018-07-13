# Factom Terraform on Google Cloud

This project will create infrastructure needed to create two authority nodes
and two guard nodes and one monitoring server. If you alter these files after creation, terraform will
create a plan for application for you to review prior to performing any infrastructure
updates.

## Requirements

* Terraform 0.11.7

## Getting Started

All steps occur in this directory. Ensure you have a Service Account Key from
Google and saved it as account.json in this directory. Then

    cp terraform.tfvars.example terraform.tfvars

Open `terraform.tfvars` and update the values to reflect your SSH user name
and SSH key location.

## Usage

Before using, initialize the project.

     terraform init

See the plan before applying.

    terraform application


Apply the plan

    terraform apply

And enter `yes`.
