variable "HUBOT_BROSEPHS_SLACK_TOKEN" {}
variable "HUBOT_DEUTSCH_SLACK_TOKEN" {}

variable "HUBOT_AUTH_ADMIN" {}
variable "HUBOT_YOUTUBE_API_KEY" {}
variable "HUBOT_S3_BRAIN_ACCESS_KEY_ID" {}
variable "HUBOT_S3_BRAIN_SECRET_ACCESS_KEY" {}

variable "TERRAFORM_AWS_ACCESS_KEY" {}
variable "TERRAFORM_AWS_SECRET_KEY" {}

variable "PUBNUB_SUBSCRIBE" {}

variable "AWS_SSH_KEY" {}

variable "region" {
	default = "us-east-1"
}

variable "key_name" {
	default = "hubot-deployer-us-east-1-key"
}

variable "instance_type" {
	default = "t2.micro"
}

variable "amis" {
	default = {
		us-east-1 = "ami-4fe4852a"
	}
}

variable "availability" {
	default = "us-east-1a"
}

variable "HUBOT_S3_BRAIN_BUCKET" {
	default = "dla-dbot"
}