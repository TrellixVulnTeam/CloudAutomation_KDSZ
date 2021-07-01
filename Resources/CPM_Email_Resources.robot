*** Settings ***
Library  SeleniumLibrary
#Library     Printerautomation.py
Variables    ../PageObjects/Locators.py


*** Variables ***
${URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${FILENAME2}                    Test Mail.html
${FILENAME3}                    emailBody.html
${IP}                           10.195.6.123
${PIN}                          1234
*** Keywords ***
Open Browser To Login Page
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible     ${email_job1_status}

Email submission with
    [Arguments]        ${IP}   ${PIN}  ${FILENAME}
    set selenium timeout    20
    ${email_status}=   send_email_singleattachment_all      ${URL}      ${FILENAME}
    log     ${email_status}
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${email_job1_status}        Ready
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${email_job2_status}        Ready

    element text should be      ${email_job1_description}      Test Mail
    element text should be      ${email_job2_description}      Test Mail

    element should contain      ${email_job1}        Test Mail.html
    element should contain      ${email_job2}        ${FILENAME}

    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        E-Mail
    element should be visible   ${email_icon_job2}
    element attribute value should be      //*[@id="documents-row-1-client"]/lpm-source-renderer/div     title        E-Mail

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${FILENAME}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name1}        ${FILENAME}
    element text should be      ${print_job_name1}     ${FILENAME}
    Click Element   link-navPrintQueue

    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${FILENAME2}
    log     {print_job_status}

#Now call printer simulation for second job
    ${print_job_status} =   printer_automation    ${IP}   ${PIN}  ${FILENAME2}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        ${FILENAME2}
    element text should be      ${print_job_name}     ${FILENAME2}

    Click Element   link-navPrintQueue

Check blank subject email job
    set selenium timeout    20
    [Arguments]        ${IP}   ${PIN}
    ${email_status}=   blank_subject      ${URL}
    log     ${email_status}
    reload page
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${email_job1_status}        Ready

    element text should be      ${email_job1_description}   ${EMPTY}
    element should contain      ${email_job1}        emailBody.html
    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        E-Mail
    element text should be      ${email_job1_status}        Ready


#Call the Print Device Automation Python script for releasing the jobs
    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${FILENAME3}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        emailBody.html

    element text should be      ${print_job_name}     ${FILENAME3}
    Click Element   link-navPrintQueue

Check blank body email job
    set selenium timeout    20
    ${email_status}=   blank_body      ${URL}
    log     ${email_status}
    reload page
    Wait Until Keyword Succeeds    40 sec    5 sec    page should contain        No data available

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


