[![Go Reference](https://pkg.go.dev/badge/github.com/grafana/k6exec.svg)](https://pkg.go.dev/github.com/grafana/k6exec)
[![GitHub Release](https://img.shields.io/github/v/release/grafana/k6exec)](https://github.com/grafana/k6exec/releases/)
[![Go Report Card](https://goreportcard.com/badge/github.com/grafana/k6exec)](https://goreportcard.com/report/github.com/grafana/k6exec)
[![GitHub Actions](https://github.com/grafana/k6exec/actions/workflows/test.yml/badge.svg)](https://github.com/grafana/k6exec/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/grafana/k6exec/graph/badge.svg?token=6MP3G02V9C)](https://codecov.io/gh/grafana/k6exec)
![GitHub Downloads](https://img.shields.io/github/downloads/grafana/k6exec/total)

<h1 name="title">k6exec</h1>

**Launching k6 with extensions**

The launcher will always run the k6 test script with the appropriate k6 binary, which contains the extensions used by the script. In order to do this, it analyzes the script arguments of the "run" and "archive" subcommands, detects the extensions to be used and their version constraints.

The launcher can be integrated into other command line tools as a subcommand. For this purpose, the library contains the functionality of the command line tool as a factrory function that returns [cobra.Command](https://pkg.go.dev/github.com/spf13/cobra#Command).

The launcher can also be used as a go library.

## Install

Precompiled binaries can be downloaded and installed from the [Releases](https://github.com/grafana/k6exec/releases) page.

If you have a go development environment, the installation can also be done with the following command:

```
go install github.com/grafana/k6exec/cmd/k6exec@latest
```

The launcher acts as a drop-in replacement for the k6 command. For more convenient use, it is advisable to create an alias or shell script called k6 for the launcher. The alias can be used in exactly the same way as the k6 command, with the difference that it generates the real k6 on the fly based on the extensions you want to use.

## Usage

<!-- #region cli -->
## k6exec

Lanch k6 with extensions

### Synopsis

Launch k6 with a seamless extension user experience.

The launcher acts as a drop-in replacement for the `k6` command. For more convenient use, it is advisable to create an alias or shell script called `k6` for the launcher. The alias can be used in exactly the same way as the `k6` command, with the difference that it generates the real `k6` on the fly based on the extensions you want to use.

The launcher will always run the k6 test script with the appropriate k6 binary, which contains the extensions used by the script. In order to do this, it analyzes the script arguments of the "run" and "archive" subcommands, detects the extensions to be used and their version constraints.

Any k6 command can be used. Use the `help` command to list the available k6 commands.


```
k6exec [flags] [command]
```

### Flags

```
      --build-service-url string       URL of the k6 build service to be used
      --extension-catalog-url string   URL of the k6 extension catalog to be used
  -h, --help                           help for k6
      --no-color                       disable colored output
  -q, --quiet                          disable progress updates
      --usage                          print launcher usage
  -v, --verbose                        enable verbose logging
```

<!-- #endregion cli -->

## Development

### Tasks

This section contains a description of the tasks performed during development. If you have the [xc (Markdown defined task runner)](https://github.com/joerdav/xc) command-line tool, individual tasks can be executed simply by using the `xc task-name` command.

<details><summary>Click to expand</summary>

#### readme

Update documentation in README.md.

```
go run ./tools/gendoc README.md
```

#### lint

Run the static analyzer.

```
golangci-lint run
```

#### test

Run the tests.

```
go test -count 1 -race -coverprofile=build/coverage.txt ./...
```

#### coverage

View the test coverage report.

```
go tool cover -html=build/coverage.txt
```

#### build

Build the executable binary.

This is the easiest way to create an executable binary (although the release process uses the goreleaser tool to create release versions).

```
go build -ldflags="-w -s" -o build/k6exec ./cmd/k6exec
```

#### snapshot

Creating an executable binary with a snapshot version.

The goreleaser command-line tool is used during the release process. During development, it is advisable to create binaries with the same tool from time to time.

```
goreleaser build --snapshot --clean --single-target -o build/k6exec
```

#### clean

Delete the build directory.

```
rm -rf build
```

</details>
