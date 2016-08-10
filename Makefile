# Set an output prefix, which is the local directory if not specified
.PHONY: clean all devbuild dev

.SUFFIXES:
.SUFFIXES: .less .css

DOCKER_IMAGE=maintainerati/wontfix-cabal-site

LESS_FILES=static/less/main.less
CSS_FILES=static/css/main.min.css

LESSC = lessc
LESSCFLAGS = -x --clean-css
all: less

devbuild:
	docker build --rm --force-rm -f Dockerfile.dev -t $(DOCKER_IMAGE):dev .

less: devbuild $(CSS_FILES)

$(CSS_FILES):
	docker run --rm -it \
		-v $(CURDIR)/:/usr/src/wontfix-cabal-site \
		--workdir /usr/src/wontfix-cabal-site \
		$(DOCKER_IMAGE):dev \
		sh -c '$(LESSC) $(LESSCFLAGS) $(LESS_FILES) > $@'

