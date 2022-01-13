# AWS vpc lab

Terraform module which creates a vpc instance on AWS.

- [VPC Module Reference](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

Note: Lesson file are contained in the lesson folder.  You can copy the file or make the eit changes yourself

## Lesson 1 - Initial Base VPC
### Usage

create a base file with the following code

```hcl
terraform {
  backend "local" {}
}
provider "aws" {
  region = "us-east-1"
}
```

To run this example you need to execute:
```bash
$ terraform init
```

## Lesson 2 - Adding a Module

Add the following lines of code to your vpc.tf file

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr   = "10.200.0.0/16"
}
```
To run this example you need to execute:
```bash
$ terraform plan
$ terraform apply
```
Goto your Amazon ui and look and search vps.  See if the vpc was created.  Notice it will have a dash because no name was specified.
List the file in the directory.  Notice that a terraform.tfstate file was create.  This holds information about your terraform run

## Lesson 3 - Adding tags (multiple fields values)
Add the tag stanza within the module stanza.  (see lesson/vpc.3)

```hcl
  tags = {
    Name = "vpc lab"
    Terraform = "true"
  }  
```
To run this example you need to execute:
```bash
$ terraform plan
$ terraform apply
```

Verify that "tags" were added to your vpc instance.

## Lesson 4 - adding subenets private and public with multiple availabilty zones
Add the following after the "cidr" line.  (see lesson/vpc.4)

```hcl
  azs = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.200.1.0/24", "10.200.2.0/24"]
  public_subnets  = ["10.200.11.0/24", "10.200.12.0/24"]
```
To run this example you need to execute:
```bash
$ terraform plan
$ terraform apply
```
verify that "subnets" were added to your vpc instance.


## Lesson 5 - Dynamic data and outputing information
Add the following to the end of the file  (see lesson/vpc.5)

```hcl
data "aws_availability_zones" "az" {
  state = "available"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
```

To run this example you need to execute:
```bash
$ terraform plan
$ terraform apply
```
Note that there are no changes being made to the vpc in the plan.  
What information was printed?

Remove the VPC with:
```bash
$ terraform destroy
```
We are going to be change the network on the next section and it works better to remove the current vpc.

## Lesson 6 - Using local variables
Add the following above the module line  (see lesson/vpc.6)

```hcl
locals {
  name   = "vpc lab"
  region = "us-east-1"

  tags = {
    Owner       = "<your initials>"
    Environment = "dev"
  }
}
```
Add a line above the cidr line
```hcl
  name = local.name
```
Replace the tag section with
```hcl
  tags = local.tags
```
Change the azs line to 
```hcl
azs = ["${local.region}-az1", "${local.region}-az2"]
```

To run this example you need to execute:
```bash
$ terraform plan
$ terraform apply
```
Note that the vpc now has a name.  
Note that instead of creating availabilty zones in one location, we are now creating availabilty zones using multiple locations.

## Lesson 7 - Using variables and environment files
The following lesson will use 3 file  (see lesson/vpc.7, variables.7, outputs.7)

Copy the lesson files into the root directory changing the number to tf.  Notice that the outputs have been moved to a separate file. Also there is now a variables.tf file. This file defines varaibles definitions to be used in the terraform template. The values of these files will be filled in by some var files.

Look at the vpc.tf file.  Notice that almost all values have been replaced with variable.  
Look at the variables.tf file.  Notice that the variables and their type have been defined, but only the region has been set for a default.
Look at the files under /var.  Notice that there are 3 separate files with different values.
Look at the shell script apply.sh.  This has been provided so that you can use it as a reference point for the future.  Notice in the script that on the terraform line there is a "--var-file=".  This tells terraform what variables to use.  Also notice on the same line there is a "-state=".  This is going to use a custom state file so that we will have a state file for each variable set.

Run the first environment set by doing 
```bash
$ ./apply.sh vpc1
```
or 
```bash
$ terraform apply -var-file=vars/vpc1.tfvars -state=state/vpc1.tfstate
```

Look in the /state directory and notice that a named state file has been created.
Run the next environment sets
```bash
$ ./apply.sh vpc2
$ ./apply.sh vpc3
```
or
```bash
$ terraform apply -var-file=vars/vpc2.tfvars -state=state/vpc2.tfstate
$ terraform apply -var-file=vars/vpc3.tfvars -state=state/vpc3.tfstate
```
Look in the /state directory and notice that two more named state files have been created.  Verify that that vpcs were created.  Notice that the vpc3 is using a different region. Check the other region to verify creation of the vpc.

Also run the following command
```bash
$ terraform output  -state=state/vpc1.tfstate vpc_id
$ terraform output  -state=state/vpc2.tfstate vpc_id
$ terraform output  -state=state/vpc3.tfstate vpc_id
```
Note that terraform did not rerun.  It pulled the information from the last state file.

Destroy the vpcs 
```bash
$ ./destroy.sh vpc1
$ ./destroy.sh vpc2
$ ./destroy.sh vpc3
```
or
```bash
$ terraform destroy -var-file=vars/vpc1.tfvars -state=state/vpc1.tfstate
$ terraform destroy -var-file=vars/vpc2.tfvars -state=state/vpc2.tfstate
$ terraform destroy -var-file=vars/vpc3.tfvars -state=state/vpc3.tfstate
```
## Lesson 8 - Creating an ec2 instance
The ec2 instance folder is from the following site:

- [Complete EC2 instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/tree/master/examples/complete)

In lesson 5, a concept of "data" and "outputs" was introduced.  These were just shown as "informational" but this information can be used as inputs to other modules.

In the ec2 main.tf look at line 39.  This is retrieving an object id for an amazon linux type as specified by the filter. 
Look at line 91 of main.tf notice that a attribute in the module is being set to the data retrieved. 

In the ec2 main.tf look at the lines 55 and lines 73, notice how the values from vpc module are being used as inputs to other modules.

Go into the ec2 directory and to a
```bash
$ terraform init
$ terraform plan
$ terraform apply
```
Verify that an ec2 instance was created.
