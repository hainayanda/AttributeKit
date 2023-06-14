set -eo pipefail

xcodebuild -workspace Example/AttributeKit.xcworkspace \
            -scheme AttributeKit-Example \
            -destination platform=iOS\ Simulator,OS=16.4,name=iPhone\ 14 \
            clean test | xcpretty