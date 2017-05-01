FROM openshift/jenkins-slave-base-centos7

MAINTAINER James Eckersall <james.eckersall@gmail.com>

RUN \
  yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo && \
  yum install -y docker-ce

RUN \
  ln -s /home/jenkins/.dockercfg /root/.dockercfg
