#!/usr/bin/env bash
set -euo pipefail

# Packages the extension for distribution.
# Builds the WASM binary and bundles it with source and language configs.

VERSION=$(grep '^version' extension.toml | head -1 | sed 's/.*"\(.*\)"/\1/')
NAME="chipkit-${VERSION}"
OUT_DIR="dist"
WASM_TARGET="wasm32-wasip1"
WASM_BIN="target/${WASM_TARGET}/release/zed_chipkit.wasm"

echo "==> Building for ${WASM_TARGET}..."
if ! rustup target list --installed | grep -q "${WASM_TARGET}"; then
    rustup target add "${WASM_TARGET}"
fi
cargo build --target "${WASM_TARGET}" --release

copy_file_if_exists() {
    local file="$1"
    if [ -f "$file" ]; then
        cp "$file" "${OUT_DIR}/${NAME}/"
    fi
}

copy_dir_if_exists() {
    local dir="$1"
    if [ -d "$dir" ]; then
        cp -r "$dir" "${OUT_DIR}/${NAME}/"
    fi
}

echo "==> Packaging ${NAME}..."
rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}/${NAME}"

copy_file_if_exists extension.toml
copy_file_if_exists Cargo.toml
copy_file_if_exists LICENSE
copy_file_if_exists README.md
copy_file_if_exists "${WASM_BIN}"
copy_dir_if_exists src
copy_dir_if_exists languages

cd "${OUT_DIR}"
zip -r "${NAME}.zip" "${NAME}"
cd ..

SIZE=$(du -h "${OUT_DIR}/${NAME}.zip" | cut -f1)
echo "==> Done: ${OUT_DIR}/${NAME}.zip (${SIZE})"
