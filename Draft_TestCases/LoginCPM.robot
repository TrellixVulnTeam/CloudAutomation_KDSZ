*** Settings ***
Library     SeleniumLibrary
Variables    ../PageObjects/Locators.py
Resource    ../Resources/LoginCPM.robot

*** Keywords ***
Open My Browser
    [Arguments]     ${URL}  ${BROWSER}
    open browser    ${URL}  ${BROWSER}
    wait until page contains    E-mail


Provide Email address
    [Arguments]     ${USER}
    input text  ${txt_username}    ${USER}

Click Next
    click button    ${btn_next}
    wait until page contains    Password

Provide Password
    [Arguments]     ${PASSWORD}
    input text      ${txt_password}    ${PASSWORD}

Click Login
    click button    ${btn_login}

Check Login successful
    Wait Until Element Is Visible   ${lnk_cpm}

Click CPM
    [Arguments]     ${TITLE}
    Click Element   ${lnk_cpm}
    Switch Window       ${TITLE}
    Title Should Be     ${TITLE}

Verify Print queue is displayed
    [Arguments]     ${TABNAME}
    Wait until Element Is Visible   ${name_printqueue}
    element should contain  ${tab_printqueue}   ${TABNAME}
    Click Element   ${name_printqueue}
