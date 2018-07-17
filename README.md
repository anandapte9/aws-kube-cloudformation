# aws-kube-cloudFormation

This project presents YAML based cloudformation template to create a basic Kubernetes Cluster with one master and one node. By basic I mean, in no means this should be used for your test/prod workloads AS-IS, but you are welcome to tweak it as per your need before using. This should be used for demo and learning purposes only. Again this creates infrastructure on AWS and you might end up paying from your pocket based on how long you run your demo.

Mandatory Pre-requisites:
- You must have a valid AWS account. (You can create an account if you don't have one here - https://aws.amazon.com/free/?sc_channel=PS&sc_campaign=acquisition_AU&sc_publisher=google&sc_medium=cloud_computing_b&sc_content=aws_generic_e&sc_detail=aws%20console&sc_category=cloud_computing&sc_segment=141366462134&sc_matchtype=e&sc_country=AU&s_kwcid=AL!4422!3!141366462134!e!!g!!aws%20console&ef_id=WzSKwgAAAKjTwgu9:20180715212230:s )

- You should have aws cli installed on your system and configured to use access key and secret key for your user account. (Your user should have Full access to Cloudformation, access to S3 bucket and Lambda functions) Following this link if you don't have aws cli configured - https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

"Nice to haves":
- I always use Atom editor with cloud formation yaml plug-in installed. It just suits me well. However you are welcome to use any editor of your choice.
- git bash if you are on windows, makes it just tad easy to create your own infrastructure, following the documentation AS-IS.

Now lets get onto how you can run this for yourself -

- Do a git clone of the repo. git clone https://github.com/anandapte9/aws-kube-cloudformation.git
- Run environment.sh script from git bash (started within your root folder), enter the name of the bucket and region.

      sh environment.sh

This is what the script does

- Creates your ssh-keys.

- Imports the key to your AWS account.

- Creates Bucket and load appropriate files.

- Runs aws cli command to create the cloud formation stack.

- Checks the status of the stack (it should take about 10-15 mins to complete). You can also view the status from AWS cloudformation web console.

- Once stack creation complete, get the bastion Public IP address from the outputs and login from git bash from the root folder.

      ssh -i kubekey ec2-user@<BASTION_PUBLIC_IP_ADDRESS>

- Login to master node from bastion host.

      ssh -i kubekey ec2-user@<KUBE_MASTER_PRIVATE_IP>

- Run the following commands to get the status of your cluster.

      kubectl get nodes (it should show two nodes - one set as master)

      kubectl get pods --all-namespaces (it should show all the system pods in the running status).
