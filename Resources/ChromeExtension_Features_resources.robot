*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      headlessChrome
${USER}                     sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${TABNAME}                     Print Queue
${correct}                      Correct Number of Page Types listed
${COPIES}                       4
${chrome_job}                   Google

*** Keyword ***

Login to chrome extension
    login_job

Navigate to CPM
    Open Browser    ${LOGIN URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window

#Input Username
    Input Text    ${txt_username}    ${USER}

#Click Next button
    Click Button    ${btn_next}

#Input Password
    Input Text    ${txt_password}    ${PASSWORD}

#Click Login Button
    Click Button    ${btn_login}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call

#Verify Print queue is displayed
    Wait until Element Is Visible   ${name_printqueue}
    element should contain  ${name_printqueue}   ${TABNAME}
    Click Element   ${name_printqueue}

Set Print Job Parameters
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    Wait until Element Is Visible   ${name_printqueue}

#Check job and copies value

Chrome Extension Login Job Verification
    sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension


Print Job
#Call the Print Device Automation Python script for releasing the jobs
    sleep_call
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

Submit Chrome Copy Job and check whether it is displayed
    chrome_copies
#Check job and copies value
    sleep_call
    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    #sleep_call
    Wait until Element Is Visible   ${name_printqueue}

Chrome Extension Copies verification

    #sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_copies}       ${COPIES}
    element text should be      ${job_duplex}       Off

Submit Chrome Color Job and check whether it is displayed
    chrome_color
#Check job and copies value
    sleep_call
    sleep_Call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}

Chrome Extension Color verification
    #sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_colormode}       Color
    element text should be      ${job_duplex}       Off

Submit Chrome Mono Job and check whether it is displayed
    chrome_mono
    sleep_call
    sleep_Call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}

Chrome Extension Mono verification
    #sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_colormode}       Black and white
    element text should be      ${job_duplex}       Off

Delete Submitted Jobs
    #Switch Window       Print Management | Lexmark Cloud Services
    #sleep_call_1


    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
    #element should be disabled      ${btn_delete}
    click element     ${chk_deleteall}
    sleep_call_1
    click element   ${dummy_click}
    sleep_call_1
    #element should be enabled      ${btn_delete}
    sleep_call_1
    click button    ${btn_delete}
    sleep_call_2

    sleep_call_1

    click button    ${btn_yes}
    sleep_call_2

    element should not be visible   ${txt_table}
    element text should be      ${txt_nojob}     No data available

Submit Chrome Duplex Short Edge Job and check whether it is displayed
    chrome_short
    sleep_Call
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    sleep_call_2
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    
Chrome Extension Duplex Short Edge verification
    sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_duplex}       On (short edge)

Submit Chrome Duplex Long Edge Job and check whether it is displayed
    chrome_long
    sleep_call
    sleep_Call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}

Chrome Extension Duplex Long Edge verification
    sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_duplex}       On (long edge)

Submit Chrome Simplex Job and check whether it is displayed
    chrome_simplex
    sleep_call
    sleep_Call_2
    ${joblist}=     run keyword and return status   element text should be      ${txt_nojob}     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  ${jobstatus}  Processing
    run keyword if  ${pagestatus}   reload page
    sleep_call
    Wait until Element Is Visible   ${name_printqueue}
    
Chrome Extension Simplex verification
    sleep_call_2
    element text should be      ${jobstatus}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Chrome Print Extension
    element text should be      ${job_duplex}       Off

Log Out Close Browsers
    sleep_call_2
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers

###################################################################