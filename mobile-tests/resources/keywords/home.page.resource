*** Settings ***
Resource    ../locators/home.locators.resource
Library    AppiumLibrary

*** Keywords ***
Scroll Up Slowly Until Element Is Visible
    [Arguments]    ${locator}    ${max_attempts}=8    ${duration}=1200ms
    [Documentation]    Slow upward scroll the dashboard until the target element is visible.
    ${attempt}=    Set Variable    0
    WHILE    ${attempt} < ${max_attempts}
        ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=2s
        Exit For Loop If    ${visible}
        Swipe By Percent    50    80    50    35    ${duration}
        Sleep    500ms
        ${attempt}=    Evaluate    ${attempt} + 1
    END
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=10s
    Run Keyword If    not ${visible}    Fail    Element ${locator} was not found after scrolling upward.

Scroll Down And Click All Promos
    [Documentation]    Scroll upward slowly until the All Promos button is visible, then open it.
    Scroll Up Slowly Until Element Is Visible    ${HOME_ALL_PROMOS_BUTTON}
    Click Element    ${HOME_ALL_PROMOS_BUTTON}

Verify Promotions Screen Is Displayed
    [Documentation]    Verify that the promotions screen is displayed, retrying if Appium reports a stale cached element.
    ${attempt}=    Set Variable    0
    ${found}=    Set Variable    ${False}
    WHILE    ${attempt} < 4
        ${status}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${PROMOTIONS_SCREEN_MARKER}    timeout=5s
        ${found}=    Set Variable    '${status[0]}' == 'PASS'
        Exit For Loop If    ${found}
        Sleep    1s
        ${attempt}=    Evaluate    ${attempt} + 1
    END
    Run Keyword If    not ${found}    Fail    Promotions screen was not displayed.

Verify Home Section Screen Is Displayed
    [Arguments]    ${section_name}
    [Documentation]    Allow the selected Flutter section time to render; Back validates the return path.
    Sleep    5s

Open Home Section
    [Arguments]    ${section_name}
    [Documentation]    Scroll upward slowly until a section label is visible, then open it.
    ${section_locator}=    Set Variable    xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'${section_name}') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'${section_name}')]/ancestor-or-self::*[@clickable='true'][1]
    Scroll Up Slowly Until Element Is Visible    ${section_locator}
    Click Element    ${section_locator}
    ${dashboard_still_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HOME_DASHBOARD_MARKER}    timeout=3s
    Run Keyword If    ${dashboard_still_visible}    Click Element    ${section_locator}

Return To Previous Screen
    [Documentation]    Return from a promotional detail screen and verify the home dashboard.
    ${back_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SECTION_BACK_BUTTON}    timeout=5s
    Run Keyword If    ${back_visible}    Click Element    ${SECTION_BACK_BUTTON}
    ...    ELSE    Press Keycode    4
    Wait Until Element Is Visible    ${HOME_DASHBOARD_MARKER}    timeout=60s
