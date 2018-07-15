sudo amazon-linux-extras install docker -y
sudo usermod -a -G docker ec2-user
cat <<EOF > /home/ec2-user/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
cd /etc/yum.repos.d
sudo cp /home/ec2-user/kubernetes.repo .
cat <<EOF >  /home/ec2-user/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
cd /etc/sysctl.d
sudo mv /home/ec2-user/k8s.conf .
sudo sysctl --system
sudo setenforce 0
sudo yum install kubelet kubeadm kubectl -y
sudo systemctl enable docker
sudo systemctl start docker
cd /etc/systemd/system/kubelet.service.d/
sudo sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo touch 90-local-extras.conf
sudo chmod 777 90-local-extras.conf
sudo echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' > /etc/systemd/system/kubelet.service.d/90-local-extras.conf
sudo chmod 755 90-local-extras.conf
sudo swapoff -a
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 >> /home/ec2-user/kubeadm-init.log
mkdir -p /home/ec2-user/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/ec2-user/.kube/config
sudo chown $(id -u):$(id -g) /home/ec2-user/.kube/config
kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
