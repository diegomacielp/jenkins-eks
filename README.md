# Jenkins EKS
Usando Jenkins para integração contínua no EKS

## Pré requisitos ##

1.  Crie uma chave de acesso à <a href="https://aws.amazon.com/pt/premiumsupport/knowledge-center/create-access-key/">AWS</a> e dê permissão para o gerenciamento de <a href="https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html">Cluster EKS</a>.
2.  Crie um cluster EKS utilizando o <a href="https://eksctl.io/introduction/#installation">eksctl</a>:</br>
    \# *eksctl create cluster --name test-cicd --region us-east-2 --nodegroup-name group-nodes --node-type t3.small --managed --nodes 1*
    ![github](./prints/eks.png "EKS")
3.  Instale o serviço do <a href="https://www.jenkins.io/doc/book/installing/">Jenkins</a>:</br>
    I. Instale os plugins *Docker plugin, Docker Pipeline e Kubernetes Continuous Deploy Plugin*.
4.  Crie uma conta no <a href="https://hub.docker.com/">Docker Hub</a>.
5.  Instale o binário do <a href="https://kubernetes.io/docs/tasks/tools/">kubectl</a>.

## Criando credenciais de acesso ##

<p align="justify">Será necessária a criação de duas credenciais no Jenkins, uma para autenticação do Docker Hub e outra para o cluster EKS.</p>
<p>Clique em <i>Gerenciar Jenkins</i> e <i>em Manage Credentials</i>:</p>

![github](./prints/jenkins1.png "Credenciais")

Clique em <i>Global credentials</i>:

![github](./prints/jenkins2.png "Credenciais")

Clique em <i>Add Credentials</i>:

![github](./prints/jenkins3.png "Credenciais")

<p align="justify">A primeira credencial criada será para autenticação no Docker Hub, selecione o tipo Username with password e o escopo Global, por fim passe os dados de acesso:</p>

![github](./prints/jenkins4.png "Credenciais")

<p align="justify">Para a criação da credencial do EKS, o mesmo procedimento será tomado, porém o tipo da credencial será <i>Kubernetes configuration (kubeconfig).</i> Selecione <i>Enter durectly</i> e cole o conteúdo do arquivo <i>~/.kube/config</i> da máquina onde o cluster foi criado.</p>

![github](./prints/jenkins5.png "Credenciais")

## Liberando o acesso do Jenkins ao cluster EKS ##

\# *kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous*

