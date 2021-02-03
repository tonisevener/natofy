#! /bin/sh

PRODUCT_DIR=".."
PROJECT_NAME="Natofy"
DERIVED_DATA_PATH="${HOME}/Desktop/DerivedDataCLI"
SCREENSHOTS_PATH="${HOME}/Desktop/screenshots"

rm -rf $DERIVED_DATA_PATH
rm -rf $SCREENSHOTS_PATH
xcodebuild -scheme NatofyScreenshots -project "${PRODUCT_DIR}/${PROJECT_NAME}.xcodeproj" -derivedDataPath "${DERIVED_DATA_PATH}" -destination 'platform=iOS Simulator,name=iPhone 12 mini' build test
#xcodebuild -scheme NatofyScreenshots -project "${PRODUCT_DIR}/${PROJECT_NAME}.xcodeproj" -derivedDataPath "${DERIVED_DATA_PATH}" -destination 'platform=iOS Simulator,name=iPad Pro (9.7-inch)' build test

cd ${DERIVED_DATA_PATH}/Logs/Test/
for i in *.xcresult; do
    xcparse screenshots --os --model --test-plan-config $i ${SCREENSHOTS_PATH}
done

exit 0
