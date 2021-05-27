GO=go

SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

VERSION := v0.1.0
BUILD := `git rev-parse --short HEAD`
TARGETS := {{Name}}
project={{RepoBase}}/{{RepoGroup}}/{{Name}}

LDFLAGS += -X "$(project)/version.BuildTS=$(shell date -u '+%Y-%m-%d %I:%M:%S')"
LDFLAGS += -X "$(project)/version.GitHash=$(shell git rev-parse HEAD)"
LDFLAGS += -X "$(project)/version.Version=$(VERSION)"
LDFLAGS += -X "$(project)/version.GitBranch=$(shell git rev-parse --abbrev-ref HEAD)"

all: check build

build: $(TARGETS) $(TEST_TARGETS)

$(TARGETS): $(SRC)
	$(GO) build -ldflags '$(LDFLAGS)' $(project)/cmd/$@

image: $(TARGETS)
	docker build -t {{Name}}:$(VERSION)-$(BUILD) .

.PHONY: clean all build check image

lint:
	@gometalinter --disable-all --enable=gosec --exclude="Errors unhandled"  ./...
	@golangci-lint run --deadline=5m

packages = $(shell go list ./...|grep -v /vendor/)
test: check
	$(GO) test ${packages}

cov: check
	gocov test $(packages) | gocov-html > coverage.html

check:
	@echo skip go vet

clean:
	rm -f $(TARGETS)

publish:
