all: build

.PHONY: build
build:
	@docker build -t c3go .

.PHONY: run
run:
	@docker run -t c3go .
