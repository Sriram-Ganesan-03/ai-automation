*** Settings ***
Resource    ../config/common.resource
Resource    ../locators/login.locators.resource
Resource    ../locators/shared-components.locators.resource
Library    AppiumLibrary
Library    String

*** Keywords ***
Launch Graton
    [Documentation]    Launch the app and wait for the login screen to be ready.
    Wait Until Element Is Visible    ${LOGIN_MOBILE_NUMBER_INPUT}    timeout=30s

Enter Mobile Number
    [Arguments]    ${mobile_number}
    [Documentation]    Enter the mobile number into the app's phone field using the standard Appium text API.
    Wait Until Element Is Visible    ${LOGIN_MOBILE_NUMBER_INPUT}    timeout=20s
    ${field_exists}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_MOBILE_NUMBER_INPUT}    timeout=5s
    Run Keyword If    ${field_exists}    Click Element    ${LOGIN_MOBILE_NUMBER_INPUT}
    Run Keyword And Ignore Error    Clear Text    ${LOGIN_MOBILE_NUMBER_INPUT}
    Input Text    ${LOGIN_MOBILE_NUMBER_INPUT}    ${mobile_number}
    Hide Keyboard

Click Continue
    [Documentation]    Continue through to the app permission and device activation flow.
    Wait Until Element Is Visible    ${LOGIN_CONTINUE_BUTTON}    timeout=20s
    Click Element    ${LOGIN_CONTINUE_BUTTON}
    Sleep    2s

Allow Device Permission
    [Documentation]    Accept the system permission dialog when prompted. Some builds auto-grant this.
    ${allow_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_ALLOW_BUTTON}    timeout=3s
    Run Keyword If    ${allow_visible}    Click Element    ${LOGIN_ALLOW_BUTTON}

Select Location Permission While Using This App
    [Documentation]    Choose the location permission option when the system dialog appears.
    ${location_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_WHILE_USING_LOCATION}    timeout=3s
    Run Keyword If    ${location_visible}    Click Element    ${LOGIN_WHILE_USING_LOCATION}

Cancel Permission Popup
    [Documentation]    Dismiss the follow-up notification or permission popup if it appears.
    ${cancel_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_CANCEL_BUTTON}    timeout=3s
    Run Keyword If    ${cancel_visible}    Click Element    ${LOGIN_CANCEL_BUTTON}

Enter PIN
    [Arguments]    ${pin}
    [Documentation]    Enter the device security PIN through the Android key events used by the custom keypad.
    ${pin_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_PIN_INPUT}    timeout=10s
    Run Keyword If    ${pin_visible}    Enter Numeric Keypad Value    ${pin}

Click Enable Biometric
    [Documentation]    Wait through PIN verification, then tap the biometric option when it appears.
    ${biometric_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_ENABLE_BIOMETRIC_BUTTON}    timeout=60s
    Run Keyword If    ${biometric_visible}    Click Element    ${LOGIN_ENABLE_BIOMETRIC_BUTTON}

Enter OTP
    [Arguments]    ${otp}
    [Documentation]    Enter the OTP through the Android key events used by the verification keypad.
    ${otp_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_OTP_INPUT}    timeout=60s
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
    ${save_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_SAVE_DEVICE_BUTTON}    timeout=60s
    Run Keyword If    ${save_visible}    Click Element    ${LOGIN_SAVE_DEVICE_BUTTON}
    Sleep    3s

Verify Device Saved And User Logged In
    [Documentation]    Confirm that device activation reaches a saved or logged-in state.
    ${device_saved_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_DEVICE_SAVED_MESSAGE}    timeout=60s
    ${dashboard_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_HOME_DASHBOARD_TITLE}    timeout=60s
    ${any_post_login_visible}=    Set Variable If    ${device_saved_visible} or ${dashboard_visible}    ${True}    ${False}
    Run Keyword If    ${any_post_login_visible}
    ...    Log    Post-login flow reached a valid continuation state.
    ...    ELSE    Fail    Expected a post-login or app continuation screen was not reached.

Verify Graton Home Dashboard Is Displayed
    [Documentation]    Verify that the Graton home/dashboard is displayed.
    Wait Until Element Is Visible    ${LOGIN_HOME_DASHBOARD_TITLE}    timeout=60s
