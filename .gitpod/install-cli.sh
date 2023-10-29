#!/bin/bash

script_dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "🔥 Installing everything..."
echo "🔥 Installing kubectl..."
sudo curl -o /usr/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x /usr/bin/kubectl
echo "✅ kubectl is ready"
echo "🔥 Installing terraform..."
$script_dirname/install_terraform.sh
echo "✅ terraform is ready"
echo "🔥 Installing helm..."
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update -y
sudo apt-get install -y helm
echo "✅ helm is ready"
echo "🔥 Installing kubeconfig..."
eval $(gp env -e)
#$SMARTIRE_KUBECONFIG
echo "✅ kubeconfig is ready"
echo "🔥 Setting docker registry..."

echo "✅ docker registry is ready"
echo "✅ dev env is ready"