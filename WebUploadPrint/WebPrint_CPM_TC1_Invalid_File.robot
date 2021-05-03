*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/InvalidFileType.xlsx
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Suite Setup     Open Browser To Login Page
Test Template   Verify File upload Button Feature
Suite Teardown     Log Out Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


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
#Dashboard Should Open

#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services

Verify File upload Button Feature
   [Arguments]        ${TEST CASE}      ${FILE PATH}     ${FILE NAME}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     link-navPrintQueue
    Click Element   id:link-navPrintQueue
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     printQueueUploadButton
    element should be enabled   id:printQueueUploadButton
    element should be disabled  id:printQueueDeleteButton

#Verify Portal upload
    Click Element   id:printQueueUploadButton

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     xpath://*[@id="printQueueUploadModalModalHeader"]
    Click Element   xpath://*[@id="multiFileSelectUploadDragDrop"]/div[1]/cui-button/span/button
    choose file     id:multiFileSelectUpload    ${file_path}

#Verify incorrect file format message
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      xpath: //*[@id="fileAddError0"]
    element should be visible   xpath: //*[@id="fileAddError0"]
    element should contain      xpath: //*[@id="fileAddError0"]     ${FILE NAME}

    ${done_btn}     set variable    printQueueUploadModalDoneButton
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${done_btn}
    element should be visible       ${done_btn}
    element should be enabled       ${done_btn}
    click button    ${done_btn}
    ${table_entry}      set variable    //*[@id="document_link_0"]
    Wait Until Keyword Succeeds    35 sec    5 sec    element should not be visible      ${table_entry}

Log Out Close Browsers
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers

###################################################################################################################


