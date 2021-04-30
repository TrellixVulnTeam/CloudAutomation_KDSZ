*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Library     DataDriver  ../TestData/Fold.xlsx
Suite Setup     Check total number of Fold options
Test Template   Validation of Fold dropdown
Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed

*** Test Cases ***
Validation of Fold combobox setting Fold values as ${FOLD NAME}
    Validation of Fold dropdown

*** Keywords ***

Check total number of fold options
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
#Click CPM and verify Page Opens
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
    wait until page contains element   ${default_settings_btn}
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      saveChangesButton

#Check page size count
    element attribute value should be   //*[@id="fold-listbox-item-printer"]   aria-setsize   5
    sleep_call_1

Validation of Fold dropdown
    #sleep_call
    #sleep_call
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    #sleep_call
    [Arguments]        ${FOLD}     ${FOLD CONTROL}       ${FOLD NAME}
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${FOLD}
    click element   ${FOLD}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${FOLD CONTROL}
    click element   ${FOLD CONTROL}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      saveChangesButton
    click button    saveChangesButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${default_settings_btn}
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      saveChangesButton
    element attribute value should be   ${FOLD CONTROL}   title   ${FOLD NAME}


Reset , Log Out and Close Browsers
    set selenium timeout    20
    click element   fold
    click element   fold-listbox-item-printer
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Save Changes
    click button    saveChangesButton
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


