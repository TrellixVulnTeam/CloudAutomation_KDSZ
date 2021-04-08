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

*** Keywords ***
Open Browser To Login Page
    set selenium timeout    20
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
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

Mobile submission
    #[Arguments]        ${FILENAME}
    set selenium timeout    20
    ${mobile_status}=   mobile_submit
    log     ${mobile_status}
    sleep_call_2
    wait until element is visible     ${txt_nojob}
    #${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    #run keyword if  ${joblist}   reload page
    #reload page
    wait until element is visible   ${email_job1_status}
    ${pagestatus}=  run keyword and return status   element text should be  ${email_job1_status}  Processing
    run keyword if  ${pagestatus}   reload page


    Wait until Element Is Visible   ${name_printqueue}
    wait until element is visible       ${tbl_printqueue}

    element text should be      ${email_job1_description}      A test document to upload
    element should contain      ${tbl_printqueue}        mobile.doc
    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Mobile

    #element text should be     //*[@id="documents-row-0-client"]/lpm-source-renderer/div      Mobile
    #sleep_call
    reload page
    wait until element is visible   ${email_job1_status}
    element text should be      ${email_job1_status}        Ready

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${mobile_job}
    log     {print_job_status}

    sleep_call
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    Wait until Element Is Visible   ${name_printqueue}
    wait until page does not contain element    ${mobile_job}
    sleep_call_2
    click element   link-navJobHistory
    wait until page contains    Print Job History
    #reload page
    #wait until page contains    Print Job History
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName
    wait until element is visible     ${print_job_name1}
    element text should be      ${print_job_name1}     ${mobile_job}
    sleep_call_2

Log out
    set selenium timeout    20
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################


