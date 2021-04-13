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
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${username}                     sravantesh.neogi@lexmark.com
#${password}                     Password@1234
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


*** Test Cases ***
Verify portal upload using ${FILE NAME}


*** Keywords ***
Open Browser To Login Page
    set selenium timeout    20
    Open Browser    ${LOGIN URL}    ${BROWSER}

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
    Input Text    id:user_email    ${username}

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
    Input Text    id:user_password    ${password}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login
    element should be enabled   ${loginbtn}
    element should be visible   ${loginbtn}
    element attribute value should be   ${loginbtn}     value   ${login}

#Click Login Button
    Click Button    btn-email-login

#Dashboard Should Open
    Title Should Be     Dashboard | Lexmark Cloud Services

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div

    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call



Change Default Settings
    [Arguments]        ${IP}   ${PIN}  ${FILE PATH}     ${FILE NAME}       ${DUPLEX VALUE}     ${DUPLEX STRING}       ${NUP VALUE}         ${NUP STRING}       ${COPIES VALUE}        ${COLOR VALUE}       ${COLOR STRING}
    set selenium timeout    20
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

#    click button    ${default_settings_btn}
#    sleep_call
#    ${default_title}            set variable    printSettingsBreadcrumb
#    ${copies_text}              set variable    copies_input
#    ${nup_listbox}              set variable    nup_Inputlistbox
#    ${duplex_input}             set variable    duplex
#    ${duplex_value}             set variable    ${DUPLEX VALUE}
#    ${nup_input}                set variable    nup
#    ${nup_value}                set variable    ${NUP VALUE}
#    ${bw_radio}                 set variable    ${COLOR VALUE}
#    ${save_btn}                 set variable    saveChangesButton
    ${file_path}                set variable    ${FILE PATH}
    ${file_name_actual}         set variable    ${FILE NAME}


#    sleep_call
#
#    element attribute value should be   ${default_title}    aria-label   ${default_title_actual}
#    press keys   ${copies_text}  \DELETE
#    press keys   ${copies_text}  \DELETE
#    press keys   ${copies_text}  \DELETE
#    sleep_call_2
#    input text  ${copies_text}  ${COPIES VALUE}
#
#    click element   ${duplex_input}
#    wait until page contains element    ${duplex_value}
#    click element   ${duplex_value}
#
#    click element   ${nup_input}
#    wait until page contains element    ${nup_value}
#    click element   ${nup_value}
#
#    click element   ${COLOR VALUE}
#
#    click button    ${save_btn}
#    sleep_call

#Verify File upload Button Feature
   # sleep_call
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    Wait until Element Is Visible   id:printQueueUploadButton
    element should be enabled   id:printQueueUploadButton
    element should be disabled  id:printQueueDeleteButton

#Verify Portal upload
    Click Element   id:printQueueUploadButton

    sleep_call
    Wait until Element Is Visible   xpath://*[@id="printQueueUploadModalModalHeader"]
    choose file     id:multiFileSelectUpload    ${file_path}
    ${progress_bar}     set variable    //*[@id="_bar"]/progressbar/bar
    ${progress_value}   set variable    //*[@id="_Content"]/div
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${progress_value}
    Wait Until Element Contains     ${progress_value}    100%   timeout=15

    ${progress_value_actual}     Set Variable    xpath://*[@id="_bar"]/progressbar/bar

    element attribute value should be   ${progress_value_actual}    aria-valuenow   100
    ${done_btn}     set variable    printQueueUploadModalDoneButton
    click button    ${done_btn}
    reload page
    sleep_call
    ${job_status}   set variable    documents-row-0-documentStatus
    Wait Until Keyword Succeeds    40 sec    5 sec    element text should be      ${job_status}        Ready
#    Wait until Element Is Visible   xpath://*[@id="printQueueUploadModalModalHeader"]
#    Click Element   xpath://*[@id="multiFileSelectUploadDragDrop"]/div[1]/cui-button/span/button
#
#    file_name   ${file_path}
#    sleep_call
#
#
##Verify progress dialog and other parameters
#    ${progress_bar}     set variable    //*[@id="_bar"]/progressbar/bar
#    ${progress_value}   set variable    //*[@id="_Content"]/div
#
##Click Done button when upload is complete
#    ${progress_value_actual}     Set Variable    xpath://*[@id="_bar"]/progressbar/bar
#    ${percentage_progress}=      get element attribute   ${progress_value_actual}    aria-valuenow
#
#    FOR    ${percentage_progress}    IN RANGE    999999
#       ${percentage_progress}=      get element attribute   ${progress_value_actual}    aria-valuenow
#       Exit For Loop If    ${percentage_progress} == 100
#    END
#
#    sleep_call
#    element attribute value should be   ${progress_value_actual}    aria-valuenow   100
#
#    ${file_name}    set variable    //*[@id="table-row-0"]/th
#    ${file_size}    set variable    //*[@id="table-row-0"]/td[1]
#    ${progress_bar}     set variable    //*[@id="_bar"]/progressbar/bar
#    ${progress_value}   set variable    //*[@id="_Content"]/div
#    ${cancel_btn}       set variable    //*[@id="fileUploadModalCancelRemainingButton"]/span/button
#    ${done_btn}     set variable    printQueueUploadModalDoneButton
#
#    element should be visible   ${file_name}
#    element should be visible   ${file_size}
#    element should be visible   ${progress_bar}
#    element should be visible   ${progress_value}
#    element should not be visible       ${cancel_btn}
#    element should be visible   ${done_btn}
#    element should be enabled   ${done_btn}
#    click button    ${done_btn}
#    sleep_call
#
##Check Job Paramters
#    reload page
#    reload page
#    reload page
#    sleep_call
    ${job_name}     set variable    document_link_0
    ${job_status}   set variable    documents-row-0-documentStatus
#    ${job_copies}   set variable    documents-row-0-printOptions.copies.value
#    ${job_color}    set variable    documents-row-0-printOptions.color.value
#    ${job_duplex}   set variable    documents-row-0-printOptions.duplex.value
#    ${job_nup}      set variable    documents-row-0-printOptions.nUp.value

    element text should be      ${job_name}      ${file_name_actual}

    element text should be      ${job_status}    ${job_status_actual}
#    element text should be      ${job_color}     ${COLOR STRING}
#    element text should be      ${job_duplex}    ${DUPLEX STRING}
#    element text should be      ${job_nup}       ${NUP STRING}
#    element text should be      ${job_copies}    ${COPIES VALUE}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Web

    sleep_call

#Call the Print Device Automation Python script for releasing the jobs
    ${print_job_status} =   printer_automation  ${IP}   ${PIN}  ${file_name_actual}
    log     {print_job_status}
    reload page
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    #Wait until Element Is Visible   ${name_printqueue}
    sleep_call_2
    #wait until page contains    Print Job History
    click element   link-navJobHistory
    Wait Until Keyword Succeeds    40 sec    5 sec    element should be visible      dataGridMyPrintJobsId-row-0-jobName
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        ${file_name_actual}
    #wait until element contains     ${print_job_name}     ${FILENAME}

    element text should be      ${print_job_name}     ${file_name_actual}
    sleep_call_2
    Click Element   link-navPrintQueue




#Check Print Job History table
#    Switch Window       Print Management | Lexmark Cloud Services
#    Title Should Be     Print Management | Lexmark Cloud Services
#    reload page
#    sleep_call
#    click element   link-navJobHistory
#    #reload page
#    sleep_call
#    sleep_call
#    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
#    element text should be      ${print_job_name}     ${file_name_actual}
#    sleep_call_2
#    Click Element   link-navPrintQueue



#Verify deletion of jobs
#    sleep_call
#    ${delete_chkbox}    set variable    documents-select-all
#    ${delete_btn}   set variable    printQueueDeleteButton
#    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
#    element should be disabled      ${delete_btn}
#    click element     ${delete_chkbox}
#    sleep_call_2
#    click element   ${dummy_click}
#    element should be enabled      ${delete_btn}
#    click button    ${delete_btn}
#    sleep_call_2
#
#    ${cancel_job_btn}   set variable    confirmation-modal_cancelButton
#    ${yes_job_btn}      set variable    confirmation-modal_okButton
#    ${delete_title}     set variable    confirmation-modal_modalHeader
#    ${table_entry}      set variable    //*[@id="document_link_0"]
#
#    element text should be      ${delete_title}     ${delete_dlg_title_actual}
#
#    element should be enabled   ${cancel_job_btn}
#    element should be enabled   ${yes_job_btn}
#    element should be focused   ${cancel_job_btn}
#
#    click button    ${yes_job_btn}
#    sleep_call_2
#
#    element should not be visible   ${table_entry}

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


