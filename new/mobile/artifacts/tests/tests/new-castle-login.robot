*** Settings ***
Resource    ../resources/config/common.resource
Resource    ../resources/keywords/login.page.resource
Resource    ../resources/keywords/home.page.resource

Suite Setup    Open Application Session
Suite Teardown    Close Application Session

*** Test Cases ***
Graton Login Flow Saves Device And Opens Dashboard
    [Tags]    raw-file    login    mobile    dashboard
    Log    ▶ Launch the Graton app and continue through login flow.
    Launch Graton
    Log    ▶ Enter the mobile number and continue.
    Enter Mobile Number    4045439875
    Click Continue
    Log    ▶ Accept the permission prompt and location access.
    Allow Device Permission
    Select Location Permission While Using This App
    Cancel Permission Popup
    Log    ▶ Complete secure sign-in and biometric enrollment.
    Enter PIN    5791
    Click Enable Biometric
    Enter OTP    123456
    Click Save Device
    Verify Device Saved And User Logged In
    Verify Graton Home Dashboard Is Displayed
    Scroll Down And Click All Promos
    Verify Promotions Screen Is Displayed
    Return To Previous Screen
    Open Home Section    SHOWS AT GRATON
    Verify Promotions Screen Is Displayed
    Return To Previous Screen
    Open Home Section    GAMING AT GRATON
    Verify Promotions Screen Is Displayed
    Return To Previous Screen
    Open Home Section    DINING AT GRATON
    Verify Promotions Screen Is Displayed
    Return To Previous Screen
