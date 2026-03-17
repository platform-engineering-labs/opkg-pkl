export VERSION := "0.31.0"
URL := f"https://github.com/apple/pkl/releases/download/{{VERSION}}/pkl-"

default: clean darwin-arm64 darwin-x8664 linux-arm64 linux-x8664

darwin-arm64: (pkg f"{{URL}}macos-aarch64" "darwin" "arm64")

darwin-x8664: (pkg f"{{URL}}macos-amd64" "darwin" "x8664")

linux-arm64: (pkg f"{{URL}}linux-aarch64" "linux" "arm64")

linux-x8664: (pkg f"{{URL}}linux-amd64" "linux" "x8664")

pkg uri os arch:
    mkdir -p "./dist/{{os}}-{{arch}}/bin"
    curl -L -o "./dist/{{os}}-{{arch}}/bin/pkl" {{uri}}
    ops opkg build --arch {{arch}} --os {{os}} --target-path "./dist/{{os}}-{{arch}}" --output-path ./

clean:
    rm -rf ./dist
    rm -rf *.opkg