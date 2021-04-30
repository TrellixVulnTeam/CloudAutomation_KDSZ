*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Library     DataDriver  ../TestData/PaperType.xlsx
Suite Setup     Check total number of paper types
Test Template   Validation of Paper type dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Page Types listed

*** Test Cases ***
Validation of Paper type combobox setting page type as ${PAPER TYPE NAME}
    Validation of Paper type dropdown


*** Keywords ***

Check total number of paper types
    Open Browser    ${URL}    ${BROWSER}
    set selenium timeout    20
#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

#Open Print default settings
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_upload}
    click button    ${default_settings_btn}
    #wait until page contains element    settingsUpdatingBusySpinner
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout

#Check page size count
    element attribute value should be   //*[@id="paperType-listbox-item-printer"]   aria-setsize   24

Validation of Paper type dropdown

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    [Arguments]        ${PAPER TYPE}     ${PAPER TYPE CONTROL}       ${PAPER TYPE NAME}     ${ERROR_TEXT}   ${CHECK}
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${PAPER TYPE}
    click element   ${PAPER TYPE}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${PAPER TYPE CONTROL}
    click element   ${PAPER TYPE CONTROL}

    run keyword if  ${CHECK}==True     page should contain   ${ERROR_TEXT}

    click button    saveChangesButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_upload}
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    element attribute value should be   ${PAPER TYPE CONTROL}   title   ${PAPER TYPE NAME}


Reset , Log Out and Close Browsers
    set selenium timeout    20
    sleep_call_2
    click element   paperType
    click element   paperType-listbox-item-printer
    click button    saveChangesButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_upload}
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


