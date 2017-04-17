# Set an output prefix, which is the local directory if not specified
.PHONY: clean all build devbuild less serve

.SUFFIXES:
.SUFFIXES: .less .css

DOCKER_IMAGE=maintainerati/site

PORT := 1337

LESS_FILES=static/less/main.less
CSS_FILES=static/css/main.min.css

LESSC = lessc
LESSCFLAGS = --clean-css

all: less

build:
	docker build --rm --force-rm -t $(DOCKER_IMAGE) .

serve: build
	docker run --rm -it \
		-v $(CURDIR)/:/usr/src/site \
		--workdir /usr/src/site \
		-p $(PORT):$(PORT)\
		--name site \
		$(DOCKER_IMAGE) hugo server -w --port=$(PORT) --bind=0.0.0.0

less: devbuild $(CSS_FILES)

devbuild:
	docker build --rm --force-rm -f Dockerfile.dev -t $(DOCKER_IMAGE):dev .

$(CSS_FILES): static/less/*.less
	docker run --rm -it \
		-v $(CURDIR)/:/usr/src/site \
		--workdir /usr/src/site \
		$(DOCKER_IMAGE):dev \
		sh -c '$(LESSC) $(LESSCFLAGS) $(LESS_FILES) > $@'

clean:
	rm -rf public
	rm -rf $(CSS_FILES)
