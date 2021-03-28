*** Settings ***
Library  SeleniumLibrary
#Library     Printerautomation.py
Variables    ../PageObjects/Locators.py


*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${mobile_job}                   mobile.doc

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
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

    ${mobile_status}=   mobile_submit
    log     ${mobile_status}
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    sleep_call_2
    ${pagestatus}=  run keyword and return status   element text should be  ${email_job1_status}  Processing
    run keyword if  ${pagestatus}   reload page


    sleep_call
    Wait until Element Is Visible   ${name_printqueue}

    wait until element is visible       ${tbl_printqueue}

    element text should be      ${email_job1_description}      A test document to upload


    element should contain      ${tbl_printqueue}        mobile.doc

    element should be visible   ${email_icon_job1}

    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Mobile

    #element text should be     //*[@id="documents-row-0-client"]/lpm-source-renderer/div      Mobile

    element text should be      ${email_job1_status}        Ready

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${mobile_job}
    log     {print_job_status}

    sleep_call
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    sleep_call
    click element   link-navJobHistory
    #reload page
    sleep_call
    sleep_call
    #page should contain
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName

    element text should be      ${print_job_name1}     ${mobile_job}
    sleep_call_2

    Click Element   link-navPrintQueue


Log out
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################


