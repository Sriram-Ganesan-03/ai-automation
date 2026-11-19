*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${EXECUTION_TARGET}          %{EXECUTION_TARGET=local}
${APPIUM_SERVER_URL}         %{APPIUM_SERVER_URL=http://127.0.0.1:4723}
${PLATFORM}                  %{MOBILE_PLATFORM=android}
${DEVICE_NAME}               %{DEVICE_NAME=emulator-5554}
${AVD}                       %{AVD=}
${PLATFORM_VERSION}          %{PLATFORM_VERSION=17}
${AUTOMATION_NAME}           %{AUTOMATION_NAME=UiAutomator2}
${APP_PACKAGE}               %{APP_PACKAGE=com.playerhub.graton}
${APP_ACTIVITY}              %{APP_ACTIVITY=com.playerhub.hub.MainActivity}
${BUNDLE_ID}                 %{BUNDLE_ID=}
${APP_PATH}                  %{APP_PATH=}
${APP_VERSION}               %{APP_VERSION=0.0.0}
${APP_USERNAME}              %{APP_USERNAME=}
${APP_PASSWORD}              %{APP_PASSWORD=}
${BROWSERSTACK_USERNAME}     %{BROWSERSTACK_USERNAME=}
${BROWSERSTACK_ACCESS_KEY}   %{BROWSERSTACK_ACCESS_KEY=}
${BROWSERSTACK_HUB_URL}      %{BROWSERSTACK_HUB_URL=https://hub-cloud.browserstack.com/wd/hub}
${BS_APP_ID}                %{BS_APP_ID=}
${BS_DEVICE}                %{BS_DEVICE=emulator-5554}
${BS_OS_VERSION}            %{BS_OS_VERSION=17}
${BS_PROJECT_NAME}          %{BS_PROJECT_NAME=Graton Mobile Tests}
${BS_BUILD_NAME}            %{BS_BUILD_NAME=local-build}
${SCREENSHOT_DIR}           ${OUTPUT DIR}/screenshots
${VIDEO_DIR}                ${OUTPUT DIR}/videos

*** Keywords ***
Open Application Session
    [Documentation]    Starts the Appium session for the configured execution target and platform.
    Run Keyword If    '${EXECUTION_TARGET}' == 'browserstack'    Open BrowserStack Session
    ...    ELSE IF    '${PLATFORM}' == 'android'    Open Local Android Session
    ...    ELSE    Open Local iOS Session
    Create Directory    ${VIDEO_DIR}
    Start Screen Recording    timeLimit=180s
    Register Keyword To Run On Failure    Capture Page Screenshot

Open Local Android Session
    [Documentation]    Local Appium server driving an Android emulator, device, or simulator.
    Open Application    ${APPIUM_SERVER_URL}
    ...    platformName=Android    automationName=${AUTOMATION_NAME}
    ...    deviceName=${DEVICE_NAME}    avd=${AVD}
    ...    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    ...    app=${APP_PATH}    autoGrantPermissions=true    newCommandTimeout=120

Open Local iOS Session
    [Documentation]    Local Appium server driving an iOS simulator or device.
    Open Application    ${APPIUM_SERVER_URL}
    ...    platformName=iOS    automationName=${AUTOMATION_NAME}
    ...    deviceName=${DEVICE_NAME}    platformVersion=${PLATFORM_VERSION}
    ...    bundleId=${BUNDLE_ID}    app=${APP_PATH}    newCommandTimeout=120

Open BrowserStack Session
    [Documentation]    BrowserStack App Automate session for a remote device farm.
    &{bstack_options}=    Create Dictionary
    ...    userName=${BROWSERSTACK_USERNAME}    accessKey=${BROWSERSTACK_ACCESS_KEY}
    ...    deviceName=${BS_DEVICE}    osVersion=${BS_OS_VERSION}
    ...    projectName=${BS_PROJECT_NAME}    buildName=${BS_BUILD_NAME}    sessionName=${SUITE NAME}
    Open Application    ${BROWSERSTACK_HUB_URL}
    ...    platformName=${PLATFORM}    automationName=${AUTOMATION_NAME}
    ...    app=${BS_APP_ID}    bstack:options=${bstack_options}    newCommandTimeout=120

Close Application Session
    [Documentation]    Ends the Appium session.
    Stop Screen Recording    filename=${VIDEO_DIR}/graton-full-flow
    Close Application

Resolve Locator
    [Arguments]    ${locator}
    [Documentation]    Returns the locator as passed through; can be enhanced by version-aware libraries.
    RETURN    ${locator}
