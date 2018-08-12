FROM golang:latest

# expose ports
EXPOSE 3330
EXPOSE 5000

# install docker daemon
RUN curl -L -o /tmp/docker-18.03.1-ce.tgz https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
RUN tar -xz -C /tmp -f /tmp/docker-18.03.1-ce.tgz
RUN mv /tmp/docker/* /usr/local/bin

# install ipfs daemon
RUN wget https://dist.ipfs.io/go-ipfs/v0.4.14/go-ipfs_v0.4.14_linux-amd64.tar.gz -O /tmp/go-ipfs.tar.gz
RUN tar xvfz /tmp/go-ipfs.tar.gz
RUN mv go-ipfs/ipfs /usr/local/bin/
RUN ipfs init
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/9001
RUN ipfs daemon &

# set environment path
ENV PATH /go/bin:/usr/local/bin:$PATH

# cd into the api code directory
WORKDIR /go/src/github.com/c3systems/c3-go

# create ssh directory
RUN mkdir ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

ARG token
ENV ENV_TOKEN=$token

# allow private repo pull
RUN git config --global url."https://$ENV_TOKEN:x-oauth-basic@github.com/".insteadOf "https://github.com/"

# copy the local package files to the container's workspace
#ADD . /go/src/github.com/c3systems/c3-go
RUN git clone https://github.com/c3systems/c3-go /go/src/github.com/c3systems/c3-go

# install the program
RUN go install github.com/c3systems/c3-go

RUN c3-go generate key -o priv.pem

COPY . /

# start application
CMD . /start.sh