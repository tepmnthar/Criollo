#!/bin/bash

set -x

# Build Frameworks
xcodebuild clean archive -quiet -project Criollo.xcodeproj -scheme "Criollo (macOS)" CODE_SIGNING_REQUIRED=NO
#xcodebuild clean build -quiet -destination 'platform=iOS Simulator,name=iPhone 8' -project Criollo.xcodeproj -scheme "Criollo" CODE_SIGNING_REQUIRED=NO
#xcodebuild clean build -quiet -destination 'platform=tvOS Simulator,name=Apple TV' -project Criollo.xcodeproj -scheme "Criollo" CODE_SIGNING_REQUIRED=NO
