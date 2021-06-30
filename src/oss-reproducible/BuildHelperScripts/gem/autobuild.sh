#!/bin/bash

PREBUILD_SCRIPT="$1"
BUILD_SCRIPT="$2"
POSTBUILD_SCRIPT="$3"

if [ ! -z "$PREBUILD_SCRIPT" -a -f "/build-helpers/$PREBUILD_SCRIPT" ]; then
	echo "Executing pre-build script: [$PREBUILD_SCRIPT]"
	source "/build-helpers/$PREBUILD_SCRIPT"
else
	echo "No custom pre-build script found."
fi

if [ ! -z "$BUILD_SCRIPT" -a -f "/build-helpers/$BUILD_SCRIPT" ]; then
	pwd
	echo "Executing build script: [$BUILD_SCRIPT]"
	source "/build-helpers/$BUILD_SCRIPT"
else
	echo "No custom build script found. Using auto-builder."

	echo "Executing gem build scripts"
	gem build --output /build-output/output.archive
fi

if [ ! -z "$POSTBUILD_SCRIPT" -a -f "/build-helpers/$POSTBUILD_SCRIPT" ]; then
	echo "Executing post-build script: [$POSTBUILD_SCRIPT]"
	source "/build-helpers/$POSTBUILD_SCRIPT"
fi

echo "Autobuild complete."
