*** Terraform ***

-> It is a popular Iac tool which is specfically useful as an infrastructure provisioning tool. Managed by Hashicorp org.
-> it helps in deployment at various places like Vm, private and public cloud, physical machine.
-> Providers enable Terraform manage cloud platforms like AWS, Azure, G-Cloud et.
-> code is declarative, which transform actual to desierd way
-> Terraform works in three phases: 1)init, 2)Plan, 3)Apply
1)init: - In this phase the terraform initializes the project and identifies the providers to be used for the target environment.
2)plan: - In this phase terraform drafts a plan to get to the target state.
3)apply: - In this phase, terraform makes the necessary changes, required on the target environment to bring it to the desierd state.
-> every object that terrform manages is called a "resource". 
-> Resource can be a compute instance a database server in the cloud, or on physical server on-premise that terraform manages.
-> Terraform manages the lifecycle of the resources from its provisioning to configuration to decommissioing.
-> terraform records the state of the infrastructure as it is seen and ensure all state is defined and active with updates all time.
-> The state is a blueprint of the infrastructure deployed by the terraform.
-> it can configure datasource.

-----------------

-> HCL – Declarative Language:  and the file ends with ".tf" uses for terraform.
Ex: aws.tf

resource "aws_instance" "webserver" {
    ami = "ami-0c2f25c1f66a1ff4d"
    instance_type = "t2.micro"
}

-> Resoure: - it is an object data for terraform manages.
            - it could be a file on local host or it could be a virtual machine on the cloud.
			- it could be services like s3 busket, DB, IM users or IM grps.

-> Local type resource and random pit resource are basic to learn and understand.

-> HCL basic:
- The HCL file consists of blocks and arguments.
- A Block is defined within curly braces, and it contains a set of arguments in key value pair format representing the configuration data.
Ex: sample outline.

<block> <parameters> {
  key1 = value1
  key2 = value2
}

- Block: it contains information about the infrastructure platform, and a set of resources within that platform that we want to create.

Ex: creating a file in a directory. in local.tf

resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content = "We love pets!"
}

- Block Name = resource ( Resource Block can be identified by the keyword called "Resource".
- Resource Type = - "local_file" (This is a fixed value and depends on the provider, where we want to create the resource)
                  - Resource Type provides two bits of information, 
				  - First is the Provider, which is represented by the word before the underscore in the resource type.
				  - "local" = resource provider, "local_file" = resource type, local=provider, and file=resource 
				  - Resource name = "pet", it is the logical name used to identify the resource, and it can be name anything.
				  - The curly braces {} we have the "arguments" for resource which are written in key value pair format.
				  - These "arguments" are specific to the type of resource we are creating, which in this case is the local_file.
				  - First argument is the filename, where we have assign the absolute path to the file we want to create.
				  - content argument for the content to the file.
				  
- The simple terraform consists of 4 stages: 1) write the configuration file, 2) init, 3) plan, 4) apply

--------------------------

=> Terraform basics:

-> Using terraform providers
- There are mainly 3 type of providers: 1) official, 2) partner, 3) community 

-> config directory:
- The "main.tf" is a where file containing resource definition, common configurations are added. 
- The "variables.tf" contains varibale declarations.
- The "outputs.tf" contains outputs from resources.
- The "Providers.tf" contains Provider definition.

-> Multiple Providers:
- " random provider " is one of the example for multiple providers.
- when adding a new/editing resource provider, always do "terraform init" first, so that it will install the resource provider first.

-> using input varibles:
- we can create and assign variables just like in other languages powershell,c,bash,etc.
- To assign the varibles we need a new config file called "variables.tf", where we store all the variables.

Ex: Here "content" is the varible name, default is the "value" for the varible name. IN "variables.tf File"
variable "content" {
       default = "we love pets!"
}

IN "main.tf File"

resource "local_file" "pet" {
  filename = var.filename      // here var.<name> is used to take values for varible file.
  content = var.content
}

-> understanding the varible block:
- exploreing other args in the varible block

Ex: 3 diff args in variable.
variable "content" {
       default = "we love pets!"
	   type = string      // it is the type and can be string,number,bool,list,map,object,tuple,etc. Type default value is "any".
	   description = " it can be anything regarding the variable"    // it is the description.
}

- List = it is like array, duplicate values are allowed in List. The number of values = ["mr","mrs","sir"], where index 0 = Mr, 1 = Mrs, 2 = sir. 
Ex:
variable "prefix" {
  default = ["Mr", "Mrs", "Sir"]
  type = list(string)   // can also be type = list(string), type = list(number). 
}

resource "random_pet" "my-pet" {
  prefix = var.prefix[0]
}

- Map = data represented in the form of key value pairs. 
Ex:
variable file-content {
  type = map   // can also be type = map(string) for string, type = map(number) for numbers. 
  default = {
      "statement1" = "We love pets!"      // "statement1" = key and "We love pets!" = value 
      "statement2" = “We love animals!"
  }
}

resource local_file my-pet {
  filename = "/root/pets.txt"
  content = var.file-content["statement2"]
}

- Set = it is similar to the list, only is diff is you can't have duplicate values in the set.
Ex:
variable "prefix" {
  default = ["Mr", "Mrs", "Sir"]
  type = set(string)   // can also be type = set(string), type = set(number). 
}

resource "random_pet" "my-pet" {
  prefix = var.prefix[0]
}

- object = we can create comlpex data by combine all types of varibles.
Ex:
variable "bella" {
  type = object({
    name = string
    color = string
    age = number
    food = list(string)
    favorite_pet = bool
 })
 default = {
  name = "bella"
  color = "brown"
  age = 7
  food = ["fish", "chicken", "turkey"]
  favorite_pet = true
 }
}

- tuple = it is similar to the list, diff is that in list we can only add a similar type of varibles, in tuple you can add different type of varibles.
Ex:
variable kitty {
  type = tuple([string, number, bool]) // here in tuple, there are diff varible types: string = cat, number = 7, bool = true 
  default = ["cat", 7, true]
}

-> using terraform input variables:

- can use cmds in diff forms 
Ex: terraform apply -var "filename=/root/pets.txt" -var "content=We love Pets!" -var "prefix=Mrs" -var "separator=." -var "length=2"

- The file should end with terraform.tfvars or terraform.tfvars.json only.
- if you some other name we need to apply with the following name
Ex: terraform apply -var-file variables.tfvars

- Terraform variable definition precedence order to select the variables in the following order:
a) Environment varibales 
b) terraform.tfvars
c) *.auto.tfvars(alphabetical order)
d) apply -var or -var-file (command-line flags)

-> Resource Attributes:
- use ${random_pet.my-pet.id} from one varible to another.

-> Resources Dependencies:
- "implicit dependency" = which creates in order and deletes in reverse order. (reference expression is used implicit).
- we can custom and make use of "depends_on" so that it depends and ensure local file is created only after the random pet is created this called "explicit dependency".
Ex: for explicit dependency:
resource "local_file" "whale" {
  filename   = "/root/whale"
  content    = "whale"
  depends_on = [local_file.krill]
}

resource "local_file" "krill" {
  filename = "/root/krill"
  content  = "krill"
}

-> Output variables:
- refer kodekloud ppt page 125 
Note: cmd = terraform output  // will show/print the output values 

--------------------------------------

=> Terraform State:
-> State of Terraform:
-  refer page 130, says the full flow of the terraform init,plan,apply and tell the terraform tf.state file as well.

-> Purpose of state:
- terraform tf.state file can be consider as a blueprint of the state.
- terraform tf.state can be used to state of truth and which allows you to delete or add things according to thier dependency.
- always take the updated version of the terraform tf.state file to avoid the conflicts.
- Which location is the terraform state file stored by default? = configuration directory.
- Which option should we use to disable state? = we cant disable the state.
Note: Try to keep the terraform tf.state file in the remote state like (AWS s3, google cloud storage, terraform cloud etc.)
Note: cmd = terraform show  // will show the terraform.tfstate 

-> Terraform state considerations:
- it conatins a sensitive data information as a result you need to store it in a secure place.
Note: no manual edits needs to done in this file.

----------------------------------------

=> Working with Terraform:

-> Terraform commands:
- CMD terraform validate // it validates the contents in the .tf file
- CMD terraform fmt  // it is used to formate the contents in the .tf file
- CMD terraform show // it is used to show the contents present in the state of .tf file
- CMD terraform show -json // to show in json formate.
- CMD terraform providers // to see the list of all providers in the terraform.
- CMD terraform mirror // to mirror and create the same config to the new path.
- CMD terraform output // to list all the output variables, to list specific - CMD terraform output <output_name>.
- CMD terraform refresh // it will modify the state file if any changes are made.
- CMD terraform graph // helps in visual representation of the dependency that are available.
- CMD terraform providers -help // gives additional features on it.

Note: - The terraform apply failed in spite of our validation working! This is because the validate command only carries out a general verification of the configuration.
        It validated the resource block and the argument syntax but not the values the arguments expect for a specific resource!
	  - providers are the plugins that are present.
	  
-> Mutable vs Immutable Infrastructure:
- Where you change or update the main.tf say file_permisssion it first destory older changes and recreate with new changes.
- Mutable: means we can change the resources 
- Immutable: We can't change the resources, it makes easy to update and delete the versions.

-> lifeCycle Rules:
- lifecycle rules help us in telling what procress needs to be done, in what order.
Ex: 1) create_before_destroy // it creates before the destory 
lifecycle {
  create_before_destroy = true
}
Ex: 2) prevent_destroy // it prevents the destory
lifecycle {
  prevent_destroy = true
}
Ex: 3) ignore_changes   // ignore the changes made in the list[] of ignore_changes.
lifecycle {
  ignore_changes = [
    tags
  ]
}

-> Data Sources:
- if we want to make a use of new file that is created in bash script we use data sources.
- Data sources are the read attributes from resources which are provisioned outside its control.
- it is only for reading the data.
- refer 192 page.

-> Meta-Arguments:
- Multiple instances of the same resources. 
- it is used to change the behaviour of the resources.
- Example: depends_on and Lifecycle etc..

-> Count:
-  to multiple resources we use count and it creates as a "list".
Ex: For Count
resource "local_file" "pet"{
   filename = var.filename
   
   count = 3             // creates 3 instances
}

-> For each:
- it only works with "map" or a "set" in variables.
- need to check and review again.

-> version constraints:
- Everytime when you create a resource it pulls the lastest version of the terraform.
- if we want to change the version we can do that by the terraform providers.
Ex: version example
terraform {
  required_providers {
    local = {                      // local provider 
      source = "hashicorp/local"   // This is the source
       version = "1.4.0"           // Providing the specific version, we can also use !=1.4.0, > 1.1.0, < 1.1.0, etc.
  }
 }
} 

resource "local_file" "pet"{
  filename = "root/krill,txt"
  content = "we love books"
}
Note: also can use "> 3.45.0, !=3.46.0, < 3.48.0" , == is not vaild, 
--------------------------------------------------------------

=> Terraform With AWS:

Ex: 
provider "aws" {                               // provider AWS
	region = "us-west-2"                       // in which region 
	access_key = "AKIAI44QH8DHBEXAMPLE"        // credentials 1
	secret_key = "je7MtGbClwBF/2tk/h3yCo8n…"   // credentials 2 
}
resource "aws_iam_user" "admin-user" {         // aws_iam_user=resource type , aws=provider, iam_user=resource type
	name = "lucy"
	tags = {
	  Description = "Technical Team Leader"
	}
}

----------------------------------------------------------------

=> Remote State:

-> terraform state command: 
- we should edit the terraform state directly, it is not a good practice.
- we can use commmands like show,list,move,pull,etc.
Ex: terraform state rm local_file.hall_of_fame // to remove.

----------------------------------------------------------------------

=> Terraform Provisioners:

=> Terraform Import, taining resources and debugging:

=> Terraform modules:

=> Terraform Functions:

-------------------------------------------------------------------------



