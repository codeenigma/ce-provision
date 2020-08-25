#!/bin/sh
set -eu
# Perform actual hooks.
GIT_DIR=$(git rev-parse --show-toplevel 2> /dev/null)
for file in $(find "$GIT_DIR/$0.d" -name "*.hook"); do 
  chmod +x "$file"
  /bin/sh "$file" "$@"
done