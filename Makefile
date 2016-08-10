# Set an output prefix, which is the local directory if not specified
PREFIX?=$(shell pwd)
BUILDTAGS=

.PHONY: clean all devbuild dev

DOCKER_IMAGE=maintainerati/wontfix-cabal-site

devbuild:
	docker build --rm --force-rm -f Dockerfile.dev -t $(DOCKER_IMAGE):dev .

static/css/main.min.css: devbuild
	docker run --rm -it \
		-v $(CURDIR)/:/usr/src/wontfix-cabal-site \
		--workdir /usr/src/wontfix-cabal-site \
		$(DOCKER_IMAGE):dev \
		sh -c 'cat static/css/normalize.css static/css/bootstrap.min.css static/css/custom.css | cleancss -o $@'

dev: static/css/main.min.css
