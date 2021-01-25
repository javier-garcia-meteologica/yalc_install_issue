#!/bin/bash

# Directory containing this script
SCRIPT_DIR="$(dirname "$(realpath "$0" )")"

# Build dep3/chalk

(
cd "$SCRIPT_DIR/chalk"
# clean
rm chalk-4.1.0.tgz /tmp/chalk-4.1.0.tgz node_modules dist
npm i
npm pack
mv chalk-4.1.0.tgz /tmp
yalc publish
)

# Build dep2

(
cd "$SCRIPT_DIR/dep2"
# clean
rm deps-dep2-0.0.1.tgz /tmp/deps-dep2-0.0.1.tgz node_modules dist
npm i
npm pack
mv deps-dep2-0.0.1.tgz /tmp
yalc publish
)

# Build dep1

(
cd "$SCRIPT_DIR/dep1"
# clean
rm deps-dep1-0.0.1.tgz /tmp/deps-dep1-0.0.1.tgz node_modules dist
npm i
npm pack
mv deps-dep1-0.0.1.tgz /tmp
yalc publish
)

# Install project dependencies

(
cd "$SCRIPT_DIR/project"
rm -r .yalc yalc.lock node_modules package-lock.json # Clean environment
npm i
)
