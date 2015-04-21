SOURCES = $(wildcard **/*.go)
.PHONY: clean build static

all: clean build static

clean:
	rm -rf build && rm -rf tmp

build:
	gulp dist

static:
	go-bindata -o="./data.go" -pkg="static" -prefix="build" -tags="EMBED_STATIC" build/... 
