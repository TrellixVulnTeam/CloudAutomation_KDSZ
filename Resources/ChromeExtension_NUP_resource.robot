*** Settings ***
Library     SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variable ***
${BROWSER}      Chrome
${URL}          https://dev.us.cloud.onelxk.co/
${USER}         sravantesh.neogi@lexmark.com
${PASSWORD}     Password@1234
${TITLE}        Print Management | Lexmark Cloud Services
${TABNAME}      Print Queue
${chrome_job}   Google


*** Keywords ***
Open My Browser
    login_job
    open browser    ${URL}  ${BROWSER}
    Maximize Browser Window
    wait until page contains    E-mail

#Provide Email address
    input text  ${txt_username}    ${USER}

#Click Next
    click button    ${btn_next}
    wait until page contains    Password

#Provide Password
    input text      ${txt_password}    ${PASSWORD}

#Click Login
    click button    ${btn_login}

#Check Login successful
    Wait Until Element Is Visible   ${lnk_cpm}

#Click CPM
    Click Element   ${lnk_cpm}
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services

#Verify Print queue is displayed
    Wait until Element Is Visible   ${name_printqueue}
    element should contain  ${name_printqueue}   Print Queue
    Click Element   ${name_printqueue}
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    #sleep_call
    Wait until Element Is Visible   ${name_printqueue}

#Check job and copies value
    #sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    #sleep_call_1
    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
    #element should be disabled      ${btn_delete}
    click element     ${chk_deleteall}
    sleep_call_1
    click element   ${dummy_click}
    sleep_call_1
    element should be enabled      ${btn_delete}
    sleep_call_1
    click button    ${btn_delete}
    sleep_call_2
    sleep_call_1
    click button    ${btn_yes}
    sleep_call_2
    element should not be visible   ${txt_table}
    element text should be      ${txt_nodocument}     No data available


Open My Browser for NUP
    #login_job
    open browser    ${URL}  ${BROWSER}
    Maximize Browser Window
    wait until page contains    E-mail

#Provide Email address
    input text  ${txt_username}    ${USER}

#Click Next
    click button    ${btn_next}
    wait until page contains    Password

#Provide Password
    input text      ${txt_password}    ${PASSWORD}

#Click Login
    click button    ${btn_login}

#Check Login successful
    Wait Until Element Is Visible   ${lnk_cpm}

#Click CPM
    Click Element   ${lnk_cpm}
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services

Chrome Extensions Nup Job verification
    [Arguments]        ${NUP}
    chrome_nup  ${NUP}
    sleep_call
    ${joblist}=     run keyword and return status   element text should be      ${txt_nodocument}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    #sleep_call
    Wait until Element Is Visible   ${jobstatus}
    #sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_duplex}       Off
    element text should be      ${job_nup}      ${NUP}
    #sleep_call_1

#Print Job
#Call the Print Device Automation Python script for releasing the jobs
    ${print_job_status} =   printer_automation  ${chrome_job}
    log     {print_job_status}

    sleep_call
    sleep_call

    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    sleep_call
    click element   link-navJobHistory
    #reload page
    sleep_call
    sleep_call
    #page should contain
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName

    element text should be      ${print_job_name}     ${chrome_job}
    sleep_call

    Click Element   link-navPrintQueue

#
#    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
#    element should be disabled      ${btn_delete}
#    click element     ${chk_deleteall}
#    sleep_call_1
#    click element   ${dummy_click}
#    #sleep_call_1
#    #element should be enabled      ${btn_delete}
#    sleep_call_1
#    click button    ${btn_delete}
#    sleep_call_2
#    #sleep_call_1
#    click button    ${btn_yes}
#    sleep_call_2
#    element should not be visible   ${txt_table}
#    element text should be      ${txt_nodocument}     No data available

Reset and log out
    chrome_nup_reset
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
##################################################################################################