*** Settings ***
Resource    ../config/common.resource
Resource    ../locators/login.locators.resource
Resource    ../locators/shared-components.locators.resource
Library    AppiumLibrary
Library    String

*** Keywords ***
Launch Graton
    [Documentation]    Launch the app and wait for the login screen to be ready.
    Open Application Session
    Wait Until Element Is Visible    ${LOGIN_MOBILE_NUMBER_INPUT}    timeout=30s

Enter Mobile Number
    [Arguments]    ${mobile_number}
    [Documentation]    Enter the mobile number through the native Android input path used by the app.
    Wait Until Element Is Visible    ${LOGIN_MOBILE_NUMBER_INPUT}    timeout=20s
    @{phone_point}=    Create List    640    1060
    Tap With Positions    300ms    ${phone_point}
    Enter Numeric Keypad Value    ${mobile_number}
    Hide Keyboard

Click Continue
    [Documentation]    Continue through to the app permission and device activation flow.
    Wait Until Element Is Visible    ${LOGIN_CONTINUE_BUTTON}    timeout=20s
    @{continue_point}=    Create List    540    1486
    Tap With Positions    300ms    ${continue_point}
    Sleep    2s

Allow Device Permission
    [Documentation]    Accept the system permission dialog when prompted. Some builds auto-grant this.
    ${allow_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_ALLOW_BUTTON}    timeout=10s
    Run Keyword If    ${allow_visible}    Click Element    ${LOGIN_ALLOW_BUTTON}

Select Location Permission While Using This App
    [Documentation]    Choose the location permission option when the system dialog appears.
    ${location_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_WHILE_USING_LOCATION}    timeout=10s
    Run Keyword If    ${location_visible}    Click Element    ${LOGIN_WHILE_USING_LOCATION}

Cancel Permission Popup
    [Documentation]    Dismiss the follow-up notification or permission popup if it appears.
    ${cancel_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_CANCEL_BUTTON}    timeout=10s
    Run Keyword If    ${cancel_visible}    Click Element    ${LOGIN_CANCEL_BUTTON}

Enter PIN
    [Arguments]    ${pin}
    [Documentation]    Enter the device security PIN using Android key events when the custom PIN keypad is shown.
    ${pin_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_PIN_INPUT}    timeout=10s
    Run Keyword If    ${pin_visible}    Enter Numeric Keypad Value    ${pin}

Click Enable Biometric
    [Documentation]    Tap the enable biometric option when that screen is shown; skip if the app flow does not reach it.
    ${biometric_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_ENABLE_BIOMETRIC_BUTTON}    timeout=10s
    Run Keyword If    ${biometric_visible}    Click Element    ${LOGIN_ENABLE_BIOMETRIC_BUTTON}

Enter OTP
    [Arguments]    ${otp}
    [Documentation]    Enter the OTP using Android key events when the custom verification keypad is shown.
    ${otp_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_OTP_INPUT}    timeout=10s
    Run Keyword If    ${otp_visible}    Enter Numeric Keypad Value    ${otp}

Enter Numeric Keypad Value
    [Arguments]    ${value}
    [Documentation]    Press the Android numeric keycodes for each digit in a custom keypad value.
    @{digits}=    Split String To Characters    ${value}
    FOR    ${digit}    IN    @{digits}
        ${keycode}=    Evaluate    int($digit) + 7
        Press Keycode    ${keycode}
    END

Click Save Device
    [Documentation]    Save the activated device if the save-device button appears; skip otherwise.
    ${save_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_SAVE_DEVICE_BUTTON}    timeout=10s
    @{save_point}=    Create List    540    2087
    Run Keyword If    ${save_visible}    Tap With Positions    300ms    ${save_point}
    Sleep    3s

Verify Device Saved And User Logged In
    [Documentation]    Confirm that device activation reaches a saved or logged-in state.
    ${device_saved_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_DEVICE_SAVED_MESSAGE}    timeout=10s
    ${dashboard_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_HOME_DASHBOARD_TITLE}    timeout=10s
    Run Keyword If    ${device_saved_visible} or ${dashboard_visible}
    ...    Log    Post-login flow reached a valid continuation state.
    ...    ELSE    Fail    Expected a post-login or app continuation screen was not reached.

Verify Graton Home Dashboard Is Displayed
    [Documentation]    Verify that the Graton home/dashboard is displayed.
    Wait Until Element Is Visible    ${LOGIN_HOME_DASHBOARD_TITLE}    timeout=20s
