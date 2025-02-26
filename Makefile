# File generated by cdo from CONTRIBUTING.md; DO NOT EDIT.

SHELL=bash
.SHELLFLAGS=-e -o pipefail -c

.PHONY: __help__
__help__:
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@echo '  all      Clean build'
	@echo '  build    Build the executable binary'
	@echo '  clean    Clean the working directory'
	@echo '  coverage View the test coverage report'
	@echo '  docker   Building a Docker image'
	@echo '  examples Run examples'
	@echo '  format   Format the go source codes'
	@echo '  lint     Run the linter'
	@echo '  makefile Generate the Makefile'
	@echo '  readme   Update README.md'
	@echo '  snapshot Create the executable binary with a snapshot version'
	@echo '  test     Run the tests'
	@echo '  tools    Install the required tools'

# Clean build
.PHONY: all
all: clean makefile format lint test build snapshot readme examples docker

# Build the executable binary
.PHONY: build
build: 
	@(\
		go build -ldflags="-w -s" -o build/k6exec ./cmd/k6exec;\
	)

# Clean the working directory
.PHONY: clean
clean: 
	@(\
		rm -rf ./coverage.txt ./build;\
	)

# View the test coverage report
.PHONY: coverage
coverage: test
	@(\
		go tool cover -html=coverage.txt;\
	)

# Building a Docker image
.PHONY: docker
docker: 
	@(\
		docker build -t k6exec -f Dockerfile.goreleaser build;\
	)

# Run examples
.PHONY: examples
examples: 
	@(\
		find  examples -type f | xargs -n 1 ./build/k6exec run;\
	)

# Format the go source codes
.PHONY: format
format: 
	@(\
		go fmt ./...;\
	)

# Run the linter
.PHONY: lint
lint: 
	@(\
		golangci-lint run ./...;\
	)

# Generate the Makefile
.PHONY: makefile
makefile: 
	@(\
		cdo --makefile Makefile;\
	)

# Update README.md
.PHONY: readme
readme: 
	@(\
		go run ./tools/gendoc README.md;\
		mdcode update;\
	)

# Create the executable binary with a snapshot version
.PHONY: snapshot
snapshot: 
	@(\
		goreleaser build --snapshot --clean --single-target -o build/k6exec;\
	)

# Run the tests
.PHONY: test
test: 
	@(\
		go test -count 1 -race -coverprofile=coverage.txt -timeout 60s ./...;\
	)

# Install the required tools
.PHONY: tools
tools: 
	@(\
		eget szkiba/mdcode;\
		eget golangci/golangci-lint;\
		eget oven-sh/bun;\
	)

