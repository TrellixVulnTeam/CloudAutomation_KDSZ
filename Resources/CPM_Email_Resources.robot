*** Settings ***
Library  SeleniumLibrary
#Library     Printerautomation.py
Variables    ../PageObjects/Locators.py


*** Variables ***
${URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      headlessChrome
${USER}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${FILENAME2}                    Test Mail.html
${FILENAME3}                    emailBody.html

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call
    set selenium timeout    20
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    page should contain     No data available
    Wait until Element Is Visible   ${name_printqueue}
    Click Element   ${name_printqueue}
    #Wait until Element Is Visible   ${txt_delegate}
    sleep_call_2

Email submission with
    [Arguments]        ${FILENAME}
    set selenium timeout    20
    ${email_status}=   send_email_singleattachment      ${FILENAME}
    log     ${email_status}
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    sleep_call
    ${pagestatus}=  run keyword and return status   element text should be  ${email_job1_status}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    ${pagestatus}=  run keyword and return status   element text should be  ${email_job2_status}  Processing
    run keyword if  ${pagestatus}   reload page

    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    #click element   ${name_printqueue}
    wait until element is visible       ${tbl_printqueue}

    element text should be      ${email_job1_description}      Test Mail
    element text should be      ${email_job2_description}      Test Mail

    element should contain      ${email_job1}        Test Mail.html
    element should contain      ${email_job2}        ${FILENAME}

    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        E-Mail
    element should be visible   ${email_icon_job2}
    element attribute value should be      //*[@id="documents-row-1-client"]/lpm-source-renderer/div     title        E-Mail

    element text should be      ${email_job1_status}        Ready
    element text should be      ${email_job2_status}        Ready

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${FILENAME}
    log     {print_job_status}

    sleep_call
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    sleep_call
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    sleep_call_2
    click element   link-navJobHistory
    sleep_call_2
    #page should contain
    reload page
    sleep_call
    sleep_call
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName

    element text should be      ${print_job_name1}     ${FILENAME}
    sleep_call_2

    Click Element   link-navPrintQueue

#Now call printer simulation for second job
    sleep_call

    ${print_job_status} =   printer_automation  ${FILENAME2}
    log     {print_job_status}

    sleep_call
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    sleep_call_2
    click element   link-navJobHistory
    reload page
    sleep_call
    sleep_call
    #page should contain
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName

    element text should be      ${print_job_name}     Test Mail.html
    sleep_call_2

    Click Element   link-navPrintQueue

Check blank subject email job
    set selenium timeout    20
    ${email_status}=   blank_subject
    log     ${email_status}
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    sleep_call
    ${pagestatus}=  run keyword and return status   element text should be  ${email_job1_status}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    wait until element is visible       ${tbl_printqueue}
    sleep_call
    element text should be      ${email_job1_description}   ${EMPTY}
    element should contain      ${email_job1}        emailBody.html
    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        E-Mail
    element text should be      ${email_job1_status}        Ready

    sleep_call

#Call the Print Device Automation Python script for releasing the jobs
    ${print_job_status} =   printer_automation  ${FILENAME3}
    log     {print_job_status}

    sleep_call
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    sleep_call_2
    click element   link-navJobHistory
    sleep_call
    reload page
    sleep_call
    sleep_call
    #page should contain
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName

    element text should be      ${print_job_name}     ${FILENAME3}
    sleep_call

    Click Element   link-navPrintQueue

Check blank body email job
    set selenium timeout    20
    ${email_status}=   blank_body
    log     ${email_status}

    sleep_call_2
    reload page
    sleep_Call_2
    reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}

    wait until element is visible       ${tbl_printqueue}
    sleep_call_2

    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    sleep_call_2

    element should not be visible   ${txt_table}
    element text should be      ${txt_nojob}     No data available

Log out
    click element   ${lnk_username}
    set selenium timeout    20
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################


