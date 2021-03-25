*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py
Library     DataDriver  ../TestData/Fold.xlsx
Suite Setup     Check total number of Fold options
Test Template   Validation of Fold dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co
${BROWSER}                      headlessChrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed

*** Test Cases ***
Validation of Fold combobox setting Fold values as ${FOLD NAME}
    Check total number of fold options
    Validation of Fold dropdown
    Reset , Log Out and Close Browsers


*** Keywords ***

Check total number of fold options
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
    element attribute value should be   //*[@id="fold-listbox-item-printer"]   aria-setsize   5
    sleep_call_1

Validation of Fold dropdown
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    [Arguments]        ${FOLD}     ${FOLD CONTROL}       ${FOLD NAME}

    sleep_call_2
    scroll element into view        saveChangesButton
    sleep_call_2
    click element   ${FOLD}
    sleep_call_2
    click element   ${FOLD CONTROL}
    element attribute value should be   ${FOLD CONTROL}   title   ${FOLD NAME}
    sleep_call_2
    ${status}=       run keyword and return status  element attribute value should be   ${FOLD CONTROL}   title   ${FOLD NAME}

    Run keyword if  ${status}==False    click button    cancelChangesButton
    ...         ELSE    click button    saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call_1
    click button    ${default_settings_btn}
    sleep_call_1

Reset , Log Out and Close Browsers
    sleep_call_1
    click element   fold
    click element   fold-listbox-item-printer
    sleep_call_1
    click button    saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call_1
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


