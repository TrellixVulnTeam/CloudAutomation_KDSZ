*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/FileUpload_Data.xlsx
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Suite Setup     Open Browser To Login Page
Test Template   Change Default Settings
Suite Teardown     Log Out Close Browsers

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
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
#${IP}                           10.195.7.210
#${PIN}                          1234

*** Test Cases ***
Verify portal upload using ${FILE NAME}


*** Keywords ***
Open Browser To Login Page
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Copyright in Login
    Element Text Should Be      xpath:/html/body/div/div[2]/section/div[2]/div/p     ${loginyear}

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    element should be enabled   ${username_text}
    element should be visible   ${username_text}
    ${password_text}    set variable    id:user_password
    element should not be visible   ${password_text}

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next
    element should be enabled   ${nextbtn}
    element should be visible   ${nextbtn}
    element attribute value should be   ${nextbtn}     value   ${next}

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password
    element should be enabled   ${password_text}
    element should be visible   ${password_text}

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login
    element should be enabled   ${loginbtn}
    element should be visible   ${loginbtn}
    element attribute value should be   ${loginbtn}     value   ${login}

#Click Login Button
    Click Button    btn-email-login

#Dashboard Should Open
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home

#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services

Change Default Settings
    [Arguments]        ${IP}   ${PIN}  ${FILE PATH}     ${FILE NAME}
    set selenium timeout    20
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

    ${file_path}                set variable    ${FILE PATH}
    ${file_name_actual}         set variable    ${FILE NAME}

#Verify File upload Button Feature
   # sleep_call
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     link-navPrintQueue
    Click Element   id:link-navPrintQueue
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     printQueueUploadButton
    element should be enabled   id:printQueueUploadButton
    element should be disabled  id:printQueueDeleteButton

#Verify Portal upload
    Click Element   id:printQueueUploadButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      xpath://*[@id="printQueueUploadModalModalHeader"]
    choose file     id:multiFileSelectUpload    ${file_path}
    ${progress_bar}     set variable    //*[@id="_bar"]/progressbar/bar
    ${progress_value}   set variable    //*[@id="_Content"]/div
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${progress_value}
    Wait Until Element Contains     ${progress_value}    100%   timeout=30

    ${progress_value_actual}     Set Variable    xpath://*[@id="_bar"]/progressbar/bar

    element attribute value should be   ${progress_value_actual}    aria-valuenow   100
    ${done_btn}     set variable    printQueueUploadModalDoneButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${done_btn}
    click button    ${done_btn}
    ${job_status}   set variable    documents-row-0-documentStatus
    Wait Until Keyword Succeeds    60 sec    10 sec    element text should be      ${job_status}        Ready

    ${job_name}     set variable    document_link_0
    ${job_status}   set variable    documents-row-0-documentStatus

    element text should be      ${job_name}      ${file_name_actual}

    element text should be      ${job_status}    ${job_status_actual}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Web

#Call the Print Device Automation Python script for releasing the jobs
    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${file_name_actual}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    Wait Until Keyword Succeeds    40 sec    5 sec    element should be visible      dataGridMyPrintJobsId-row-0-jobName
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        ${file_name_actual}

    element text should be      ${print_job_name}     ${file_name_actual}
    Click Element   link-navPrintQueue

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


