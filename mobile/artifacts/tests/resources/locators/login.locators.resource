*** Variables ***
# Login screen locators
# The app uses standard Android text labels and native controls rather than stable resource IDs.
${LOGIN_MOBILE_NUMBER_INPUT}       xpath=//android.widget.EditText[@hint='Enter phone number' or @text='Mobile Number']
${LOGIN_CONTINUE_BUTTON}           xpath=//*[@content-desc='CONTINUE' or @resource-id='com.playerhub.graton:id/continue_button']
${LOGIN_ALLOW_BUTTON}              xpath=//android.widget.Button[@text='Allow' or @content-desc='Allow']
${LOGIN_WHILE_USING_LOCATION}      xpath=//android.widget.TextView[@text='While using the app' or @text='While Using This App' or @content-desc='While using the app']
${LOGIN_CANCEL_BUTTON}             xpath=//android.widget.Button[@text='Cancel' or @content-desc='Cancel']
${LOGIN_PIN_INPUT}                 xpath=//*[@content-desc='Please enter your Graton Rewards PIN' or @resource-id='com.playerhub.graton:id/pin_input']
${LOGIN_ENABLE_BIOMETRIC_BUTTON}   xpath=//*[@content-desc='ENABLE BIOMETRIC' and @clickable='true']
${LOGIN_OTP_INPUT}                 xpath=//*[@content-desc='Enter the 6-digit code sent to (404) 543-9875' or @resource-id='com.playerhub.graton:id/otp_input']
${LOGIN_SAVE_DEVICE_BUTTON}        xpath=//*[@content-desc='SAVE THIS DEVICE' and @clickable='true']
${LOGIN_DEVICE_SAVED_MESSAGE}      xpath=//*[@content-desc='Your phone number has been verified.' or @content-desc='Device saved' or @text='Device saved successfully' or @content-desc='LIVE JACKPOTS&#10;09/17/2026 5:00 PM']
${LOGIN_HOME_DASHBOARD_TITLE}      xpath=//*[@content-desc='LIVE JACKPOTS&#10;09/17/2026 5:00 PM' or @content-desc='POINT BALANCE' or @content-desc='PROMOTIONS']
