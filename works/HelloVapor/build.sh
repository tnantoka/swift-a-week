#!/bin/sh

echo "Downloading dependencies..."
swift build &>/dev/null
echo "Fixing SPM bug..."
rm -rf Packages/Vapor-0.2.6/Tests/ &>/dev/null
echo "Building..."
swift build
echo "Running..."
.build/debug/HelloVapor

