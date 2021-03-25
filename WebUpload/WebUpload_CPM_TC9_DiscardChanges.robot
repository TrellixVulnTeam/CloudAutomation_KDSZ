*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co
${BROWSER}                      headlessChrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${tab1name}                     Print Queue
${tab2name}                     Delegates
${tab3name}                     Print Job History
${tab4name}                     Download Print Management Client
${next}                         Next
${login}                        Log In
${id}
${job_status_actual}            Ready
${default_title_actual}         Set Default Print Settings
${delete_dlg_title_actual}      Delete Print Jobs


*** Test Cases ***
Discard Change dialog validation
    Open Browser To Login Page
    Increment Copy validation by 1 to 2
    Validation of Confirmation dialog by Discarding
    Validation of Confirmation Dialog by Saving Changes


*** Keywords ***

Open Browser To Login Page
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

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

    click button    ${default_settings_btn}
    sleep_call_2
    ${default_title}            set variable    printSettingsBreadcrumb
    sleep_call_2

    element attribute value should be   ${default_title}    aria-label   ${default_title_actual}

Increment Copy validation by 1 to 2
    click element   //*[@id="copies_increment"]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  2
    click element   //*[@id="id-11"]/div/div[1]/p

Validation of Confirmation dialog by Discarding
    Click Element   id:link-navPrintQueue
    wait until element is visible       //*[@id="confirmation-modal"]/div[2]/div[1]
    wait until page contains element    //*[@id="confirmation-modal"]/div[2]/div[1]
    click button        confirmation-modal_okButton
    sleep_call_2
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}
    sleep_call_2
    click button    printQueueDefaultPrintSettingsButton
    sleep_call
    textfield should contain    //*[@id="copies_input"]  1

Validation of Confirmation Dialog by Saving Changes
    click element   //*[@id="copies_increment"]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  2
    Click Element   id:link-navPrintQueue
    wait until element is visible       //*[@id="confirmation-modal"]/div[2]/div[1]
    wait until page contains element    //*[@id="confirmation-modal"]/div[2]/div[1]
    click button        confirmation-modal_cancelButton
    sleep_call_2
    textfield should contain    //*[@id="copies_input"]  2



#Log Out Close Browsers
#    ${usermenu}     set variable    userMenu
#    ${logout}       set variable    link-logout
#    click element   ${usermenu}
#    wait until page contains element    ${logout}
#    sleep_call_2
#    click element   ${logout}
#    sleep_call
#    close all browsers

###################################################################################################################


