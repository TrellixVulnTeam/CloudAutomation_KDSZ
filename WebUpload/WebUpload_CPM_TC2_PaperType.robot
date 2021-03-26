*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py
Library     DataDriver  ../TestData/PaperType.xlsx
Suite Setup     Check total number of paper types
Test Template   Validation of Paper type dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Page Types listed

*** Test Cases ***
Validation of Paper type combobox setting page type as ${PAPER TYPE NAME}
    Check total number of paper types
    Validation of Paper type dropdown
    Reset , Log Out and Close Browsers


*** Keywords ***

Check total number of paper types
    Open Browser    ${LOGIN URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${username}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${password}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   //*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

#Open Print default settings
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

    click button    ${default_settings_btn}
    sleep_call_2

#Check page size count
    element attribute value should be   //*[@id="paperType-listbox-item-printer"]   aria-setsize   24
    sleep_call_2

Validation of Paper type dropdown
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    [Arguments]        ${PAPER TYPE}     ${PAPER TYPE CONTROL}       ${PAPER TYPE NAME}     ${ERROR_TEXT}   ${CHECK}

    sleep_call
    scroll element into view        holePunch
    sleep_call_2
    click element   ${PAPER TYPE}
    sleep_call_2
    click element   ${PAPER TYPE CONTROL}

    run keyword if  ${CHECK}==True     page should contain   ${ERROR_TEXT}
    sleep_call_2

    #Icon ID gets generated run time, hence cannot track it.

    element attribute value should be   ${PAPER TYPE CONTROL}   title   ${PAPER TYPE NAME}
    sleep_call_2
    ${status}=       run keyword and return status  element attribute value should be   ${PAPER TYPE CONTROL}   title   ${PAPER TYPE NAME}

    Run keyword if  ${status}==False    click button    cancelChangesButton
    ...         ELSE    click button    saveChangesButton
    #wait until page contains element    settingsUpdatingBusySpinner
    sleep_call
    click button    ${default_settings_btn}
    sleep_call_2

Reset , Log Out and Close Browsers
    sleep_call_2
    click element   paperType
    click element   paperType-listbox-item-printer
    sleep_call_2
    click button    saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call_2
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


