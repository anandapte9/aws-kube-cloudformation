# aws-kube-cloudFormation

This project presents YAML based cloudformation template to create a basic Kubernetes Cluster with one master and one node. By basic I mean, in no means this should be used for your test/prod workloads AS-IS, but you are welcome to tweak it as per your need before using. This should be used for demo and learning purposes only. Again this creates infrastructure on AWS and you might end up paying from your pocket based on how long you run your demo.

Mandatory Pre-requisites:
- You must have a valid AWS account. (You can create an account if you don't have one here - https://aws.amazon.com/free/?sc_channel=PS&sc_campaign=acquisition_AU&sc_publisher=google&sc_medium=cloud_computing_b&sc_content=aws_generic_e&sc_detail=aws%20console&sc_category=cloud_computing&sc_segment=141366462134&sc_matchtype=e&sc_country=AU&s_kwcid=AL!4422!3!141366462134!e!!g!!aws%20console&ef_id=WzSKwgAAAKjTwgu9:20180715212230:s )

- You should have aws cli installed on your system and configured to use access key and secret key for your account.

"Nice to haves":
- I always use Atom editor with cloud formation yaml plug-in installed. It just suits me well. However you are welcome to use any editor of your choice.
- git bash if you are on windows, makes it just tad easy to create your own infrastructure, following the documentation AS-IS.

Now lets get onto how you can run this for yourself -

- do a git clone of the repo. git clone https://github.com/anandapte9/aws-kube-cloudformation.git
- Navigate to the folder aws-kube-cloudFormation/parameters and rename parameters.example.json to parameters.json. Change the parameters to suit your choice - definitely change the S3 bucket name (as the one in the example would already exist).
- Navigate to the folder aws-kube-cloudFormation/commands and open up commands.txt -- This file contains all the commands that you need to run to create your own cluster from ground up.
- First of all create your ssh-keys.
      ssh-keygen -t rsa -C .
- Give your keyname as kubekey (if you don't want to change key name at a number of places).
- Run aws cli command to import the key pair to your AWS account.
     aws ec2 import-key-pair --key-name kubekey --public-key-material file://kubekey.pub
