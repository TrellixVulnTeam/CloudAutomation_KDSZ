*** Settings ***
Library  SeleniumLibrary
#Library     Printerautomation.py
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                   https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${mobile_job}                   mobile.doc
#${IP}                           10.195.7.210
#${PIN}                          1234

*** Keywords ***
Open Browser To Login Page
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_password}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services

Mobile submission
    [Arguments]        ${IP}   ${PIN}
    set selenium timeout    20
    ${mobile_status}=   mobile_submit_all
    log     ${mobile_status}
    reload page
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${email_job1_status}        Ready
    element text should be      ${email_job1_description}      A test document to upload
    element should contain      ${tbl_printqueue}        mobile.doc
    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Mobile

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${mobile_job}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    Wait Until Keyword Succeeds    40 sec    5 sec    page should contain   Print Job History
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${print_job_name1}        ${mobile_job}
    click element       ${name_printqueue}


Log out
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers
###################################################################################################################


