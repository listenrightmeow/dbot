# dbot
Slack Hubot adapter for AWS ECS

```
docker build -t dbot .
docker run -e HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN -d listenrightmeow/dbot
```

### Initial infrastructure build

```
terraform apply -var-file=build/terraform.tfvars build
```

### terraform.tfvars

Be sure to push *.tfvars to S3 for CircleCI retrieval

```
HUBOT_SLACK_TOKEN = "xoxb-XXXXXX-XXXXXX"
HUBOT_AUTH_ADMIN = "XXXXXX"
TERRAFORM_AWS_ACCESS_KEY = "XXXXXX"
TERRAFORM_AWS_SECRET_KEY = "XXXXXX"
AWS_SSH_KEY = "ssh-rsa goes here"
```

### Grunt task

It's suggested that you create an independent IAM account for Terraform access. Update the `grunt/config.js` file with the S3 bucket that is designated to house the .tfvars file. After .tfvar files are created and unique S3 IAM account policies are created, run the `grunt` task to upload S3.

The policy below is what was used for unique S3 bucket access for the Grunt task.

```
{
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::dla-dbot",
                "arn:aws:s3:::dla-dbot/*"
            ]
        }
    ]
}
```

##### config/aws.json
```
{
	"TERRAFORM_AWS_ACCESS_KEY" : "XXXXXX",
	"TERRAFORM_AWS_SECRET_KEY" : "XXXXXX"
}
```