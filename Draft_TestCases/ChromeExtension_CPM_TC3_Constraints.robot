*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
#Library     DataDriver  ../TestData/Constraints.xlsx
#Suite Setup     Check total number of paper types
#Test Template   Validation of Paper type dropdown
#Suite Teardown     Reset , Log Out and Close Browsers

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      headlessChrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Page Types listed


*** Test Cases ***
Chrome extension Login Verification
    Chrome Extension Login verification


*** Keywords ***

Chrome Extension Login verification
    login_job

    Open Browser    ${LOGIN URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window

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
    Wait Until Element Is Visible   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

#Check job and copies value
    sleep_call_2
    ${job_name}     set variable    document_link_0
    ${job_status}   set variable    documents-row-0-documentStatus
    ${job_copies}   set variable    documents-row-0-printOptions.copies.value
    ${job_source}   set variable    //*[@id="documents-row-0-client"]/lpm-source-renderer/div
    ${job_icon}     set variable    //*[@id="documents-row-0-client"]/lpm-source-renderer/div

    sleep_call_2
    element text should be      ${job_status}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}

    sleep_call_1
    ${delete_chkbox}    set variable    documents-select-all
    ${delete_btn}   set variable    printQueueDeleteButton
    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
    element should be disabled      ${delete_btn}
    click element     ${delete_chkbox}
    sleep_call_1
    click element   ${dummy_click}
    element should be enabled      ${delete_btn}
    click button    ${delete_btn}
    sleep_call_1

    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

