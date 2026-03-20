export VERSION := "0.31.0"
GITHUB := env("GITHUB_ACTIONS", "false")
URL := f"https://github.com/apple/pkl/releases/download/{{VERSION}}/pkl-"

default: clean setup darwin-arm64 darwin-x8664 linux-arm64 linux-x8664

darwin-arm64: (pkg f"{{URL}}macos-aarch64" "darwin" "arm64")

darwin-x8664: (pkg f"{{URL}}macos-amd64" "darwin" "x8664")

linux-arm64: (pkg f"{{URL}}linux-aarch64" "linux" "arm64")

linux-x8664: (pkg f"{{URL}}linux-amd64" "linux" "x8664")

setup:
    {{ if GITHUB != "false" { "ops setup" } else {""} }}

pkg uri os arch:
    mkdir -p "./dist/{{os}}-{{arch}}/bin"
    curl -L -o "./dist/{{os}}-{{arch}}/bin/pkl" {{uri}}
    chmod 755 ./dist/{{os}}-{{arch}}/bin/pkl
    ops opkg build --secure --arch {{arch}} --os {{os}} --target-path "./dist/{{os}}-{{arch}}" --output-path ./

publish:
    ops publish --repo pel --channel stable *.opkg

clean:
    rm -rf ./dist
    rm -rf *.opkg
