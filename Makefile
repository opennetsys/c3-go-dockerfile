all: build

# example:
# $ make build
.PHONY: build
build:
	@docker build -t c3go --build-arg token="$$GITHUB_TOKEN" .

# example:
# $ make run IMAGEID=2380c1928723
.PHONY: run
run:
	@docker run -v /var/run/docker.sock:/var/run/docker.sock -p 3330:3330 -p 5000:5000 $$IMAGEID

# example:
# $ make help CONTAINERID=fd33bf15c99d
.PHONY: help
help:
	@docker exec -it $$CONTAINERID c3-go help

# example:
# $ make push CONTAINERID=fd33bf15c99d IMAGEID=hello-world
.PHONY: push
push:
	@docker exec -it $$CONTAINERID c3-go push $$IMAGEID

.PHONY: pull
pull:
	@docker exec -it $$CONTAINERID c3-go pull $$IMAGEID --host "123.123.123.123"

.PHONY: localhostproxy
localhostproxy:
	# proxy localhost to 123.123.123.123 required so that docker container can communicate with host machine
	@sudo ifconfig lo0 alias 123.123.123.123/24
