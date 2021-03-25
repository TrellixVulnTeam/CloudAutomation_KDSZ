*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py


*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co
${BROWSER}                      headlessChrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Output Bins listed


*** Test Cases ***

Validation of Color Mono setting
    Open Browser and Login
    Validation of Color Mono default state
    Validation of Color Mono new state
    Reset , Log Out and Close Browsers

*** Keywords ***

Open Browser and Login
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

Validation of Color Mono default state

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

    ${color}                        set variable    //*[@id="color_radio_input"]
    ${mono}                         set variable    //*[@id="blackAndWhite_radio_input"]

    sleep_call_1
    scroll element into view        saveChangesButton
    sleep_call_1

    element attribute value should be       ${color}    aria-checked    true
    element attribute value should be       ${mono}    aria-checked    false

    click element     ${mono}
    click button        saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call_1

    click button    ${default_settings_btn}
    sleep_call_2
    scroll element into view        saveChangesButton

Validation of Color Mono new state

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    ${color}                        set variable    //*[@id="color_radio_input"]
    ${mono}                         set variable    //*[@id="blackAndWhite_radio_input"]

    element attribute value should be       ${mono}    aria-checked    true
    element attribute value should be       ${color}    aria-checked    false

    click element       ${color}
    click button        saveChangesButton
    wait until page contains element    settingsUpdatingBusySpinner
    sleep_call

    click button    ${default_settings_btn}
    sleep_call_2
    scroll element into view        saveChangesButton
    element attribute value should be       ${color}    aria-checked    true
    element attribute value should be       ${mono}    aria-checked    false


Reset , Log Out and Close Browsers
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


