*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/InvalidFileType.xlsx
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Suite Setup     Open Browser To Login Page
Test Template   Verify File upload Button Feature
Suite Teardown     Log Out Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${username}                     sravantesh.neogi@lexmark.com
#${password}                     Password@1234


*** Test Cases ***
Verify Invalid file upload using ${TEST CASE}


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Copyright in Login

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

#Dashboard Should Open

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div

    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call

Verify File upload Button Feature
   [Arguments]        ${TEST CASE}      ${FILE PATH}     ${FILE NAME}

    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    Wait until Element Is Visible   id:printQueueUploadButton
    element should be enabled   id:printQueueUploadButton
    element should be disabled  id:printQueueDeleteButton

#Verify Portal upload
    Click Element   id:printQueueUploadButton
    Wait until Element Is Visible   xpath://*[@id="printQueueUploadModalModalHeader"]
    Click Element   xpath://*[@id="multiFileSelectUploadDragDrop"]/div[1]/cui-button/span/button
    choose file     id:multiFileSelectUpload    ${file_path}
    sleep_call_2

#Verify incorrect file format message
    element should be visible   xpath: //*[@id="fileAddError0"]
    element should contain      xpath: //*[@id="fileAddError0"]     ${FILE NAME}

    sleep_call_2

    ${done_btn}     set variable    printQueueUploadModalDoneButton
    element should be visible       ${done_btn}
    element should be enabled       ${done_btn}
    click button    ${done_btn}
    sleep_call_2
    ${table_entry}      set variable    //*[@id="document_link_0"]
    element should not be visible   ${table_entry}

Log Out Close Browsers
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


