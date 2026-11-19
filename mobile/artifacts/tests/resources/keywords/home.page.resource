*** Settings ***
Resource    ../locators/home.locators.resource
Library    AppiumLibrary

*** Keywords ***
Scroll Down And Click All Promos
    [Documentation]    Scroll to and open the All Promos section.
    Swipe By Percent    50    80    50    30    500ms
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HOME_ALL_PROMOS_BUTTON}    timeout=10s
    Run Keyword If    not ${visible}    Swipe By Percent    50    30    50    80    500ms
    Wait Until Element Is Visible    ${HOME_ALL_PROMOS_BUTTON}    timeout=20s
    Click Element    ${HOME_ALL_PROMOS_BUTTON}

Verify Promotions Screen Is Displayed
    [Documentation]    Verify that the promotions screen is displayed.
    Wait Until Element Is Visible    ${PROMOTIONS_SCREEN_MARKER}    timeout=20s

Open Home Section
    [Arguments]    ${section_name}
    [Documentation]    Scroll to and open a named promotional section.
    ${section_locator}=    Set Variable    xpath=//*[contains(translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'${section_name}') or contains(translate(@content-desc,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'${section_name}')]
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${section_locator}    timeout=10s
    Run Keyword If    not ${visible}    Swipe By Percent    50    80    50    30    500ms
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${section_locator}    timeout=10s
    Run Keyword If    not ${visible}    Swipe By Percent    50    30    50    80    500ms
    Wait Until Element Is Visible    ${section_locator}    timeout=20s
    Click Element    ${section_locator}

Return To Previous Screen
    [Documentation]    Return from a promotional detail screen and verify the prior screen.
    ${back_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SECTION_BACK_BUTTON}    timeout=5s
    Run Keyword If    ${back_visible}    Click Element    ${SECTION_BACK_BUTTON}
    ...    ELSE    Press Keycode    4
    Verify Promotions Screen Is Displayed
