*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${file_path}                    C:\\Users\\neogis\\Downloads\\Input\\Hello.txt
#${file_name_actual}             Hello.txt
#${PIN_DELEGATE}                 2222
#${IP}                           10.195.6.123



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

Check Adding Valid and Duplicate Delegates
   [Arguments]        ${EMAIL USER}     ${FILE PATH}     ${FILE NAME}
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_delegate}
    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_delegate}
    page should contain     No data available

    element should be enabled   ${btn_delegate_add}
    element should be visible   ${btn_delegate_add}
    element should be disabled  ${btn_delegate_remove}

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${dlg_btn_delegate_add}
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lst_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should contain     ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be      ${lst_table_entry}      ${EMAIL USER}

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${dlg_btn_delegate_add}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lst_delegate}
    element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be disabled     ${dlg_btn_delegate_add}
    page should contain      Delegate already exists
    click button    ${dlg_btn_delegate_cancel}

    element should be disabled      ${btn_delegate_remove}
    ${dummy_click}      set variable        delegatesBreadcrumb
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${chk_delegate_delete}

    #Check delgate printing by submitting job through logged in user#
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     link-navPrintQueue
    Click Element   id:link-navPrintQueue
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     printQueueUploadButton
    element should be enabled   id:printQueueUploadButton
    element should be disabled  id:printQueueDeleteButton
    Click Element   id:printQueueUploadButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      xpath://*[@id="printQueueUploadModalModalHeader"]
    choose file     id:multiFileSelectUpload    ${FILE PATH}
    ${progress_bar}     set variable    //*[@id="_bar"]/progressbar/bar
    ${progress_value}   set variable    //*[@id="_Content"]/div
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${progress_value}
    #Wait Until keyword     ${progress_value}    100%   timeout=30
    Wait Until Keyword Succeeds   60 sec    5 sec     element should contain      ${progress_value}    100%

    ${progress_value_actual}     Set Variable    xpath://*[@id="_bar"]/progressbar/bar

    element attribute value should be   ${progress_value_actual}    aria-valuenow   100
    ${done_btn}     set variable    printQueueUploadModalDoneButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${done_btn}
    click button    ${done_btn}
    ${job_status}   set variable    documents-row-0-documentStatus
    Wait Until Keyword Succeeds    60 sec    10 sec    element text should be      ${job_status}        Ready

    #Call printer automation to print this document for delegated user
    ${print_job_status} =   printer_automation_delegate  ${USER}   ${IP}    ${PINDELEGATE}  ${FILE NAME}
    log     {print_job_status}

    click element   link-navJobHistory
    Wait Until Keyword Succeeds    40 sec    5 sec    element should be visible      dataGridMyPrintJobsId-row-0-jobName
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    ${print_release_user_name}   set variable    dataGridMyPrintJobsId-row-0-executorEmail

    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        ${FILE NAME}

    element text should be      ${print_job_name}     ${FILE NAME}
    element text should be      ${print_release_user_name}     ${EMAIL USER}
    Click Element   link-navPrintQueue

    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${chk_delegate_delete}
    click element     ${chk_delegate_delete}
    click element   ${dummy_click}
    element should be enabled      ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${btn_delegate_remove}
    click button    ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled     ${btn_discard_ok}

    click button    ${btn_delegate_delete_ok}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible     ${lst_table_entry}

Check Adding Invalid Delegates
   [Arguments]        ${EMAIL USER}
    set selenium timeout     20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${lbl_delegate}
    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${txt_delegate}
    page should contain     No data available

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${dlg_btn_delegate_add}
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible   ${lst_delegate}
    element should be disabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_cancel}

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


