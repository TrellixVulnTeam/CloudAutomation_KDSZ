*** Settings ***
Library  SeleniumLibrary
Library     ../Library/CloudLogin.py
Library     DataDriver  ../TestData/Staple.xlsx
Suite Setup     Check total number of staple bins
Test Template   Validation of Staple dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed

*** Test Cases ***
Validation of Staple combobox setting Staple values as ${STAPLE NAME}
    Check total number of staple bins
    Validation of Staple dropdown
    Reset , Log Out and Close Browsers


*** Keywords ***

Check total number of staple bins
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
    wait until page contains element   ${default_settings_btn}
    click button    ${default_settings_btn}
    sleep_call
    #wait until page contains element    settingsUpdatingBusySpinner
    wait until page contains element    saveChangesButton
#Check page size count
    element attribute value should be   //*[@id="staple-listbox-item-printer"]   aria-setsize   15
    sleep_call_1

Validation of Staple dropdown
    #sleep_call
    #sleep_call
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    #sleep_call
    [Arguments]        ${STAPLE}     ${STAPLE CONTROL}       ${STAPLE NAME}
    set selenium timeout    20
    #wait until page contains element    holePunch
    #scroll element into view        holePunch
    sleep_call_1
    click element   ${STAPLE}
    sleep_call_1
    click element   ${STAPLE CONTROL}
    click button    saveChangesButton
    sleep_call_2
    wait until page contains element   ${default_settings_btn}
    click button    ${default_settings_btn}
    sleep_call
    #wait until page contains element    settingsUpdatingBusySpinner
    wait until page contains element    saveChangesButton
    element attribute value should be   ${STAPLE CONTROL}   title   ${STAPLE NAME}





#
#
#
#    sleep_call
#    sleep_call
#    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
#    sleep_call
#    [Arguments]        ${STAPLE}     ${STAPLE CONTROL}       ${STAPLE NAME}
#
#    sleep_call
#    #wait until page contains element    holePunch
#    #scroll element into view        holePunch
#    sleep_call_1
#    click element   ${STAPLE}
#    sleep_call_1
#    click element   ${STAPLE CONTROL}
#    element attribute value should be   ${STAPLE CONTROL}   title   ${STAPLE NAME}
#    sleep_call_1
#    ${status}=       run keyword and return status  element attribute value should be   ${STAPLE CONTROL}   title   ${STAPLE NAME}
#
#    Run keyword if  ${status}==False    click button    cancelChangesButton
#    ...         ELSE    click button    saveChangesButton
#    #wait until page contains element    settingsUpdatingBusySpinner
#    sleep_call
#    click button    ${default_settings_btn}
#    sleep_call

Reset , Log Out and Close Browsers
    set selenium timeout    20
    sleep_call_1
    click element   staple
    click element   staple-listbox-item-printer
    sleep_call_1
    click button    saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


