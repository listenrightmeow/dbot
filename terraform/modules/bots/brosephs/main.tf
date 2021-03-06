variable "HUBOT_BROSEPHS_SLACK_TOKEN" {}
variable "HUBOT_AUTH_ADMIN" {}
variable "HUBOT_YOUTUBE_API_KEY" {}
variable "HUBOT_S3_BRAIN_ACCESS_KEY_ID" {}
variable "HUBOT_S3_BRAIN_SECRET_ACCESS_KEY" {}
variable "HUBOT_S3_BRAIN_BUCKET" {}
variable "HUBOT_S3_BRAIN_FILE_PATH" {}
variable "PUBNUB_SUBSCRIBE" {}
variable "iam_role" {}
variable "iam_role_policy" {}
variable "ecs_cluster" {}
variable "elb_name" {}

resource "aws_ecs_task_definition" "brosephs-ecs-definition-us-east" {
  family = "brosephs-ecs-family-us-east"
  container_definitions = <<EOF
[
  {
    "name": "brosephs-slackbot",
    "image": "listenrightmeow/dbot:latest",
    "cpu": 128,
    "memory": 128,
    "environment": [
      {
        "name" : "PORT",
        "value" : "8081"
      },{
        "name" : "HUBOT_SLACK_TOKEN",
        "value" : "${var.HUBOT_BROSEPHS_SLACK_TOKEN}"
      },{
        "name" : "HUBOT_AUTH_ADMIN",
        "value" : "${var.HUBOT_AUTH_ADMIN}"
      },{
        "name" : "HUBOT_STANDUP_PREPEND",
        "value" : "@group: "
      },{
        "name" : "HUBOT_YOUTUBE_API_KEY",
        "value" : "${var.HUBOT_YOUTUBE_API_KEY}"
      },{
        "name" : "HUBOT_YOUTUBE_DETERMINISTIC_RESULTS",
        "value" : "true"
      },{
        "name" : "HUBOT_S3_BRAIN_ACCESS_KEY_ID",
        "value" : "${var.HUBOT_S3_BRAIN_ACCESS_KEY_ID}"
      },{
        "name" : "HUBOT_S3_BRAIN_SECRET_ACCESS_KEY",
        "value" : "${var.HUBOT_S3_BRAIN_SECRET_ACCESS_KEY}"
      },{
        "name" : "HUBOT_S3_BRAIN_BUCKET",
        "value" : "${var.HUBOT_S3_BRAIN_BUCKET}"
      },{
        "name" : "HUBOT_S3_BRAIN_FILE_PATH",
        "value" : "brain/deutsch.json"
      },{
        "name" : "PUBNUB_SUBSCRIBE",
        "value" : "${var.PUBNUB_SUBSCRIBE}"
      }
    ],
    "privileged": true,
    "portMappings": [
      {
        "containerPort": 8081,
        "hostPort": 8081
      }
    ],
    "command": ["/bin/sh", "-c", "bin/hubot --adapter slack"]
  }
]
EOF
}

resource "aws_ecs_service" "hubot-brosephs-ecs-service-us-east" {
  name = "brosephs-service"
  cluster = "${var.ecs_cluster}"
  task_definition = "${aws_ecs_task_definition.brosephs-ecs-definition-us-east.arn}"
  desired_count = 1

  iam_role = "${var.iam_role}"

  load_balancer {
    elb_name = "${var.elb_name}"
    container_name = "brosephs-slackbot"
    container_port = 8081
  }
}