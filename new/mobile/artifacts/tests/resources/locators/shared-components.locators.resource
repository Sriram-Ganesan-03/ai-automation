*** Variables ***
# Shared permission and dialog locators
${DIALOG_ALLOW_PERMISSION}         xpath=//android.widget.Button[@text='Allow' or @content-desc='Allow']
${DIALOG_LOCATION_PERMISSION}      xpath=//android.widget.TextView[@text='While using the app' or @text='While Using This App' or @content-desc='While using the app']
${DIALOG_CANCEL}                   xpath=//android.widget.Button[@text='Cancel' or @content-desc='Cancel']
${DIALOG_TOAST_MESSAGE}            xpath=//*[contains(@text,'saved') or @content-desc='toast_message']
${NAVIGATION_HOME_TAB}             xpath=//android.widget.TextView[@text='Home' or @content-desc='Home']
${NAVIGATION_PLAYERHUB_TAB}        xpath=//android.widget.TextView[@text='PlayerHub' or @content-desc='PlayerHub']
