FROM golang:latest

# expose default port
EXPOSE 3330

# set environment path
ENV PATH /go/bin:$PATH

# cd into the api code directory
WORKDIR /go/src/github.com/c3systems/c3-go

# create ssh directory
RUN mkdir ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# allow private repo pull
RUN git config --global url."https://$TOKEN:x-oauth-basic@github.com/".insteadOf "https://github.com/"

# copy the local package files to the container's workspace
ADD . /go/src/github.com/c3systems/c3-go

# install the program
RUN go install github.com/c3systems/c3-go

RUN c3-go generate key /priv.pem

# start application
CMD ["c3-go", "node", "start", "--pem", "/priv.pem", "--uri", "/ipv4/0.0.0.0/tcp/3330", "--data-dir", "/c3"]