*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${DOWNLOADBROWSER}              Edge
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${next}                         Next
${login}                        Log In
${PORTAL TITLE}                 Lexmark Log In
${invalid_password_text}        Invalid password.
${invalid_user_text}            Invalid Username or Email.
${mobile_job}                   mobile.doc
${quota_name}                   Quota_Total50_Color50
${costcenter}                   stl
${dept}                         rnd
${FILENAME2}                    Test Mail.html
${FILENAME}                     Attachment.txt
${SAASNAME}                         Cloud Print Management
${SAASLINK}                         macPackageType-listbox-item-default
${SAAS_PACKAGE NAME}                 LPMCCloudEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.182.pkg
${HYBRIDNAME}                         Hybrid Print Management
${HYBRIDLINK}                         macPackageType-listbox-item-serverless
${HYBRID_PACKAGE NAME}                 LPMCServerlessEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.183.pkg
${WINSAASNAME}                      Cloud Print Management
${WINSAASLINK}                      windowsPackageType-listbox-item-default
${WINSAAS_PACKAGE NAME}             LPMC_CloudEU_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${WINHYBRIDNAME}                      Hybrid Print Management
${WINHYBRIDLINK}                      windowsPackageType-listbox-item-serverless
${WINHYBRID_PACKAGE NAME}             LPMC_ServerlessEU_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${notification}                         True
${DELETE CLIENT FOLDER}                 True
${unused_client_value_delete_span}      10
${hybrid_unprinted_jobs_value}          20
${latebind}                             True
${hybrid_printed_jobs_value}            120
${saas}                                 True
${FILEPATH}                             C:\\Users\\neogis\\D Drive\\FREEDOM\\Python\\STL_Automation\\Attachments\\Attachment.txt
${WEBFILENAME}                          Attachment.txt
#${IP}
#${PIN}
#${NORMALBROWSER}
#${NONADMIN}                             cpmautomation@test.onelxk.co

*** Keywords ***


Open CPM portal and Login Verification
    [Arguments]    ${username}      ${password}
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain   E-mail
    Maximize Browser Window
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be     ${PORTAL TITLE}
    Element Text Should Be      ${txt_lgnyear}     ${loginyear}
    element should be enabled   ${txt_username}
    element should be visible   ${txt_username}
    element should not be visible   ${txt_password}
    Input Text    ${txt_username}   ${username}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled     ${btn_next}
    element should be enabled   ${btn_next}
    element should be visible   ${btn_next}
    #element attribute value should be   ${btn_next}     value   ${next}
    element should contain      ${btn_next}     Next
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${txt_password}
    element should be enabled   ${txt_password}
    element should be visible   ${txt_password}
    Input Text    ${txt_password}   ${password}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled       ${btn_login}
    element should be enabled   ${btn_login}
    element should be visible   ${btn_login}
    element attribute value should be   ${btn_login}     value   ${login}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home

Dashboard Should Open
    set selenium timeout    20
    Title Should Be     Dashboard | Lexmark Cloud Services

Validate CPM page opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services

Check Adding Valid and Duplicate Delegates
    [Arguments]        ${EMAIL USER}
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
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible     ${spin_delegate}
    click element     ${chk_delegate_delete}
    click element   ${dummy_click}
    element should be enabled      ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${btn_delegate_remove}
    click button    ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled     ${btn_discard_ok}

    click button    ${btn_delegate_delete_ok}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible     ${lst_table_entry}


Open Browser To Login Page
    [Arguments]    ${username}      ${password}
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Open Browser    ${lnk_cpm}    ${BROWSER}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain   E-mail
    Maximize Browser Window
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be     ${PORTAL TITLE}
    Element Text Should Be      ${txt_lgnyear}     ${loginyear}
    element should be enabled   ${txt_username}
    element should be visible   ${txt_username}
    element should not be visible   ${txt_password}
    Input Text    ${txt_username}   ${username}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled     ${btn_next}
    element should be enabled   ${btn_next}
    element should be visible   ${btn_next}
    #element attribute value should be   ${btn_next}     value   ${next}
    element should contain      ${btn_next}     Next
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${txt_password}
    element should be enabled   ${txt_password}
    element should be visible   ${txt_password}
    Input Text    ${txt_password}   ${password}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled       ${btn_login}
    element should be enabled   ${btn_login}
    element should be visible   ${btn_login}
    element attribute value should be   ${btn_login}     value   ${login}
    Click Button    ${btn_login}
    #Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home

Web upload with
    [Arguments]        ${IP}   ${PIN}  ${FILE NAME}
    set selenium timeout    20
    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton

    ${file_path}                set variable    ${FILEPATH}
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

    element text should be      ${job_status}    Ready
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

Email submission with
    [Arguments]        ${IP}   ${PIN}  ${FILENAME}
    set selenium timeout    20
    ${email_status}=   send_email_singleattachment_all      ${URL}  ${FILENAME}
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

#Now call printer simulation for second job
    ${print_job_status} =   printer_automation    ${IP}   ${PIN}  ${FILENAME2}
    log     {print_job_status}

#Check Print Job History table
    click element   link-navJobHistory
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    Wait Until Keyword Succeeds    40 sec    5 sec    element should contain      ${print_job_name}        ${FILENAME2}
    element text should be      ${print_job_name}     ${FILENAME2}

    Click Element   link-navPrintQueue

Mobile submission
    [Arguments]        ${IP}   ${PIN}
    set selenium timeout    20
    ${mobile_status}=   mobile_submit_all   ${USER}     ${PASSWORD}     ${URL}
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

Open Browser To Login Page using admin
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

Open Organisational Policy Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${org_policy}
    click element       ${org_policy}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${page_header}

Select Personal
    set selenium timeout    20
    click element     ${radio_personal}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}


Open Quota Definition Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Open Quota Status Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quota_status}
    click element       ${lbl_quota_status}

Create Quota different for month
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_quota}
    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota_Total50_Color50
    click element   ${lst_quotalimit}
    click element   ${quota_interval}
    click element     ${month}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    click element   ${txt_quotaname}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${btn_monthly}
    click button        ${btn_monthly}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${quota_total}
    click element   ${quota_total}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      50
    click element   ${quota_color}

    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      50
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${btn_create_def}
    click button    ${btn_create_def}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   createDefinitionButton

Create Custom Quota
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_quota}
    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota Status_Total10_Color10
    click element   ${lst_quotalimit}
    click element   ${quota_interval}
    click element     ${month}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    click element   ${txt_quotaname}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${btn_monthly}
    click button        ${btn_monthly}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${quota_total}
    click element   ${quota_total}
    sleep_call_1
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      10
    click element   ${quota_color}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      10
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${btn_create_def}
    click button    ${btn_create_def}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   createDefinitionButton

#Create user
    ${user}=   create_user_all  ${USER}     ${PASSWORD}     ${URL}      ${NONADMIN}
    log     ${user}


Set Quota Assignment for Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_assignquota}
    click button    ${btn_assignquota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_email}
    click element   ${txt_email}
    input text      ${txt_email_input}   ${username_nonadmin}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lst_email}
    click element   userAssignmentModalHeader
    sleep_call_2
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    sleep_call_2
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled   ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${tbl_email_quota}
    element text should be      ${tbl_personal_name}    ${username_nonadmin}


Check Status Table for normal
    #[Arguments]     ${USER}     ${PASSWORD}     ${URL}
    set selenium timeout    25
    ${total}    ${color}=   quota_green_all    ${USER}     ${PASSWORD}     ${URL}
    Open Quota Status Page
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain   User Quota Status
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-valid text-primary
    click element   ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

Check Status Table for warning
    #[Arguments]     ${USER}     ${PASSWORD}     ${URL}
    set selenium timeout    25
    ${total}    ${color}=   quota_yellow_all    ${USER}     ${PASSWORD}     ${URL}
    Open Quota Status Page
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain   User Quota Status
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-warning text-warning
    click element   ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

Check Status Table for exceeded
    #[Arguments]     ${USER}     ${PASSWORD}     ${URL}
    set selenium timeout    25
    ${total}    ${color}=   quota_red_all    ${USER}     ${PASSWORD}     ${URL}
    Open Quota Status Page
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain   User Quota Status
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-notify_alert text-danger
    click element   ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

Delete Quota
    #[Arguments]     ${USER}     ${PASSWORD}     ${URL}    ${NONADMIN}
    #${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    #${deleted}=   delete_user_all     ${USER}     ${PASSWORD}     ${URL}    ${NONADMIN}
    run keyword     Open Quota Definition Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_delete_def}
    click button    ${btn_delete_def}


Delete Quota without user
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    #${deleted}=   delete_user_all     ${USER}     ${PASSWORD}     ${URL}    ${NONADMIN}
    run keyword     Open Quota Definition Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_delete_def}
    click button    ${btn_delete_def}


Reset to Cost center
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    run keyword     Open Organisational Policy Page
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    scroll element into view    ${radio_costcenter}
    click element       ${radio_costcenter}
    click button        ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain     General


Logoutadmin
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    scroll element into view        useCostCenterOption_radio_input
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers

Exit
    set selenium timeout    20
    sleep_call_2
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers

Check Table Values
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    sleep_call_2
    element text should be      ${monthly_total_id}   50
    element text should be      ${monthly_color_id}   50
    click button    ${btn_summary_close}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${tbl_cc_quota_name}
    element text should be      ${tbl_cc_quota_name}    ${quota_name}


Create Monthly Quota
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_quota}
    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota_Total50_Color50
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_interval_1}
    click element   ${quota_interval_1}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_total}
    click element   ${quota_total}

    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element  ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      50
    click element   ${quota_color}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      50
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element  ${btn_create_def}
    click button    ${btn_create_def}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   createDefinitionButton


Select Cost Center or Personal First
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain     General
    ${is_enable}=     run keyword and return status   element attribute value should be   useCostCenterOption_radio_input   aria-checked   true
    run keyword if  ${is_enable}      Set cost center



Select Cost Center or Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain     General
    scroll element into view    ${chk_costcenter}
    click element     ${chk_costcenter}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}

Open Quota Assignment Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain   Quota Assignments

Set cost center
    #scroll element into view    ${chk_costcenter}
    click element   ${chk_costcenter}
    click button      ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain       General

Set Quota Assignment for Cost Center
    set selenium timeout    25

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${org_policy}
    click element       ${org_policy}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element   ${chk_costcenter}
    scroll element into view    ${chk_costcenter}
    ${is_enable}=     run keyword and return status   element attribute value should be   useCostCenterOption_radio_input   aria-checked   true
    run keyword if  ${is_enable}      Set cost center
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}
    #Assign Quota by Cost Center
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${btn_assignquota}
    click button    ${btn_assignquota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_costcentername}
    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${costcenter}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_costcentername}
    click element   ${header_costcenter}
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled   ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${tbl_costcenter_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be    ${tbl_costcenter_quota_name}    ${quota_name}

    element text should be      ${costcenter_name}      ${costcenter}
    click element       ${quota_name_link}

    element text should be      ${monthly_total_id}   50
    element text should be      ${monthly_color_id}   50

    click button    ${btn_summary_close}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${name_printqueue}

    #run keyword     Open Browser To Login Page using Admin
    run keyword     Open Organisational Policy Page
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${costcenter_assignment_count}
    element text should be      ${costcenter_assignment_count}      1

Select Department or Personal
    set selenium timeout    20
    scroll element into view    ${radio_dept}
    click element     ${radio_dept}
    sleep_call_1
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain button   ${btn_confirmchange}
    click button       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click button       ${btn_save}
    scroll element into view    ${chk_clientdownload}

Set Quota Assignment for Department
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${btn_assignquota}
    click button    ${btn_assignquota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_costcentername}
    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${dept}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_costcentername}
    element should be visible   ${lst_costcentername}
    Press Keys    ${lst_costcentername}    ENTER
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled     ${btn_vary_ok}
    click button    ${btn_vary_ok}

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${tbl_costcenter_quota_name}
    element should contain      ${tbl_costcenter_quota_name}    ${quota_name}

    element should contain      ${costcenter_name}      ${dept}
    click element       ${quota_name_link}

    run keyword     Check Dialog Values
    run keyword     Open Quota Definition Page
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${dept_assignment_count}
    element should contain      ${dept_assignment_count}      1


Check Dialog Values
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_summary_close}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain        Same limits for each month
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain         Total quota (color + black-and-white): 50
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain         Color printing limit: 50
    click button    ${btn_summary_close}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element       ${tbl_cc_quota_name}
    element text should be      ${tbl_cc_quota_name}    ${quota_name}

Download MAC Default Packages for SAAS

    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password
    Input Text    id:user_email    ${USER}
    ${nextbtn}  set variable    btn-email-next
    Click Button    btn-email-next
    ${password_text}    set variable    id:user_password
    Input Text    id:user_password    ${PASSWORD}
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${tab_clientdownload}
    #Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     createCustomPackageWindows

#Download MAC Default Packages
    [Arguments]   ${URL}     ${MACSAASNAME}     ${MACSAASLINK}      ${MACSAAS_PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${MACSAASLINK}
    click element   ${MACSAASLINK}

#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_mac_saas   ${URL}
    log     ${download_flag}
    #${delete_flag}=   delete_file_package   ${MACSAAS_PACKAGE NAME}     ${URL}
    close browser

Download MAC Default Packages for Hybrid
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password
    Input Text    id:user_email    ${USER}
    ${nextbtn}  set variable    btn-email-next
    Click Button    btn-email-next
    ${password_text}    set variable    id:user_password
    Input Text    id:user_password    ${PASSWORD}
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${tab_clientdownload}
    #Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     createCustomPackageWindows

#Download MAC Default Packages
    [Arguments]   ${URL}     ${MACHYBRIDNAME}     ${MACHYBRIDLINK}      ${MACHYBRID_PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${MACHYBRIDLINK}
    click element   ${MACHYBRIDLINK}

#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_mac_serverless   ${URL}
    log     ${download_flag}
    #delete_file_package     ${MACHYBRID_PACKAGE NAME}     ${URL}
    close browser

Download Default Packages for Windows for SAAS
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password
    Input Text    id:user_email    ${USER}
    ${nextbtn}  set variable    btn-email-next
    Click Button    btn-email-next
    ${password_text}    set variable    id:user_password
    Input Text    id:user_password    ${PASSWORD}
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${tab_clientdownload}
    #Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     createCustomPackageWindows

#Download Default Packages for Windows
    [Arguments]   ${URL}     ${WINSAASNAME}     ${WINSAASLINK}      ${WINSAAS_PACKAGE NAME}

    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType

    click element   ${download_list}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${WINSAASLINK}
    click element   ${WINSAASLINK}

#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}

    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element  ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_win_saas     ${URL}
    log     ${download_flag}
    #delete_file_package     ${WINSAAS_PACKAGE NAME}     ${URL}
    close browser

Download Default Packages for Windows for Hybrid
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password
    Input Text    id:user_email    ${USER}
    ${nextbtn}  set variable    btn-email-next
    Click Button    btn-email-next
    ${password_text}    set variable    id:user_password
    Input Text    id:user_password    ${PASSWORD}
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${tab_clientdownload}
    #Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     createCustomPackageWindows

#Download Default Packages for Windows
    [Arguments]   ${URL}     ${WINHYBRIDNAME}     ${WINHYBRIDLINK}      ${WINHYBRID_PACKAGE NAME}

    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType

    click element   ${download_list}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${WINHYBRIDLINK}
    click element   ${WINHYBRIDLINK}

#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}

    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_win_hybrid    ${URL}
    log     ${download_flag}
    #delete_file_package     ${WINHYBRID_PACKAGE NAME}     ${URL}
    close browser

Create Custom Package for Windows
    [Arguments]   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
    Set Global Variable      ${unused_client_value_delete_span}
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${title_clientdownload}
    click element    ${lnk_custompackage}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${lbl_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_status}
#Setting the value for notifications
    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_status}
    log     ${notification}
    log     ${isCheck}

    ${notification}     convert to string   ${notification}
    ${isCheck}     convert to string   ${isCheck}

    ${result}=  run keyword and return status   Should Be Equal As Strings      ${notification}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_status}
    ...     ELSE        unselect checkbox       ${chk_status}

    ${navigation}   run keyword and return status   checkbox should be selected     ${chk_status}

#######################################################################################
#Setting value for Delete Unused Client folder
    ${isCheck} =    Run Keyword And Return Status    checkbox should not be selected   ${chk_deletefolder}

    ${DELETE CLIENT FOLDER}     convert to string   ${DELETE CLIENT FOLDER}
    ${isCheck}     convert to string   ${isCheck}

    ${result}=  run keyword and return status   Should Be Equal As Strings      ${DELETE CLIENT FOLDER}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_deletefolder}
    ...     ELSE    unselect checkbox       ${chk_deletefolder}
    ${delete_folder_flag}=   run keyword and return status   checkbox should be selected   ${chk_deletefolder}

    run keyword if  ${delete_folder_flag}   Set Unused Client Folder values
    ${unused_client_value}    get value   ${txt_noprint_span}

########################################################################################

#Validate SAAS is enabled
    checkbox should be selected     ${chk_saas}
#Enable hybrid
    select checkbox     ${chk_hybrid}
    scroll element into view        ${btn_create}

#Get user input values for Hybrid Unprinted job
#######################################################################3
    ${hybrid_unprinted_jobs_value_temp}    get value   ${txt_unprinted_jobs}
    ${count}    get length  ${hybrid_unprinted_jobs_value_temp}

    FOR    ${index}    IN RANGE    ${count}
        press keys      ${txt_unprinted_jobs}       DELETE
    END

    input text    ${txt_unprinted_jobs}    ${hybrid_unprinted_jobs_value}

    ${hybrid_unprinted_jobs_value}    get value   ${txt_unprinted_jobs}

#Get user input values for Hybrid printed job
#########################################################################
    ${hybrid_printed_jobs_value_temp}    get value   ${txt_printed_jobs}
    ${count}    get length  ${hybrid_printed_jobs_value_temp}

    FOR    ${index}    IN RANGE    ${count}
        press keys      ${txt_printed_jobs}       DELETE
    END

    input text    ${txt_printed_jobs}    ${hybrid_printed_jobs_value}
    ${hybrid_printed_jobs_value}    get value   ${txt_printed_jobs}

###############################################################

#Validate late Binding is enabled
#Setting value for Late Binding
    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_latebinding}

    ${latebind}     convert to string   ${latebind}
    ${isCheck}     convert to string   ${isCheck}
    ${result}=  run keyword and return status   Should Be Equal As Strings      ${latebind}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_latebinding}
    ...         ELSE    unselect checkbox       ${chk_latebinding}

    ${latebind}     run keyword and return status   checkbox should be selected     ${chk_latebinding}

###############################################################
#Check the default queue name as selected by user
#Check default state which is SAAS. If user provides true, keep as it is. If false, select Hybrid

    ${isCheck} =    Run Keyword And Return Status    element attribute value should be      ${rad_saas}     aria-checked        true

    ${saas}     convert to string   ${saas}
    ${isCheck}     convert to string   ${isCheck}
    ${result}=  run keyword and return status   Should Be Equal As Strings      ${saas}     ${isCheck}
    run keyword if      ${result}       click element     ${rad_saas}
    ...         ELSE    click element       ${rad_hybrid}

    ${saas}     run keyword and return status       element attribute value should be       ${rad_saas}     aria-checked        true

####################################################################
#Create Pacakge
    click button        ${btn_create}

#Wait till package is ready
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${dlg_download}
    Wait Until Keyword Succeeds     40 sec  5 sec   element should be enabled     ${btn_download}
    element text should be      ${lbl_complete}     Your custom package is ready for downloading.

#Click Download
    click button        ${btn_download}
    #logout and close browsers
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In

    ${download_flag}=   download_wait   customPackage.zip

    ${validation_flag}=  check_values     ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}

    close all browsers


Set Unused Client Folder values

    ${unused_client_value_delete_span_temp}    get value   ${txt_noprint_span}

#Set user input values
    ${count}    get length  ${unused_client_value_delete_span_temp}

    FOR    ${index}    IN RANGE    ${count}
        #Press Key    ${txt_noprint_span}    \\8
        press keys      ${txt_noprint_span}       DELETE
    END

    input text    ${txt_noprint_span}    ${unused_client_value_delete_span}
    ${unused_client_value_delete_span}      get text    ${txt_noprint_span}





























































#    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
#    [Arguments]   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
#    Set Global Variable      ${unused_client_value_delete_span}
#
#    Open Browser    ${URL}    ${NORMALBROWSER}
#    Maximize Browser Window
#    Input Text    ${txt_username}    ${USER}
#    Click Button    ${btn_next}
#    Input Text    ${txt_password}    ${PASSWORD}
#    Click Button    ${btn_login}
#    sleep_call
#
##Update Secuirty policy
#    #run keyword     Change Security Settings
#
#    go to   ${URL}
#
#    sleep_call
#    #Wait Until Element Is Visible   ${lnk_cpm}
#    #Click Element   ${lnk_cpm}
#    go to       ${lnk_cpm}
#    sleep_call_2
#    Switch Window       Print Management | Lexmark Cloud Services
#    sleep_call
#    Wait until Element Is Visible   ${tab_clientdownload}
#    Click Element   ${tab_clientdownload}
#    sleep_call
#    wait until element is visible   ${title_clientdownload}
#    sleep_call_2
#
#    log     ${notification}
#    #go to   ${CPM URL}
#    sleep_call
#    #sleep_call
#    click element    ${lnk_custompackage}
#    sleep_call_2
#    wait until element is visible   ${lbl_clientdownload}
#    sleep_call_2
#
##Setting the value for notifications
#    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_status}
#    log     ${notification}
#    log     ${isCheck}
#
#    ${notification}     convert to string   ${notification}
#    ${isCheck}     convert to string   ${isCheck}
#
#    ${result}=  run keyword and return status   Should Be Equal As Strings      ${notification}     ${isCheck}
#    run keyword if      ${result}       select checkbox     ${chk_status}
#    ...     ELSE        unselect checkbox       ${chk_status}
#
#    ${navigation}   run keyword and return status   checkbox should be selected     ${chk_status}
#
########################################################################################
##Setting value for Delete Unused Client folder
#    ${isCheck} =    Run Keyword And Return Status    checkbox should not be selected   ${chk_deletefolder}
#
#    ${DELETE CLIENT FOLDER}     convert to string   ${DELETE CLIENT FOLDER}
#    ${isCheck}     convert to string   ${isCheck}
#
#    ${result}=  run keyword and return status   Should Be Equal As Strings      ${DELETE CLIENT FOLDER}     ${isCheck}
#    run keyword if      ${result}       select checkbox     ${chk_deletefolder}
#    ...     ELSE    unselect checkbox       ${chk_deletefolder}
#    ${delete_folder_flag}=   run keyword and return status   checkbox should be selected   ${chk_deletefolder}
#
#    run keyword if  ${delete_folder_flag}   Set Unused Client Folder values
#    ${unused_client_value}    get value   ${txt_noprint_span}
#
#########################################################################################
#
##Validate SAAS is enabled
#    checkbox should be selected     ${chk_saas}
##Enable hybrid
#    select checkbox     ${chk_hybrid}
#    sleep_call_2
#    scroll element into view        ${btn_create}
#    sleep_call_2
#
##Get user input values for Hybrid Unprinted job
########################################################################3
#    ${hybrid_unprinted_jobs_value_temp}    get value   ${txt_unprinted_jobs}
#    ${count}    get length  ${hybrid_unprinted_jobs_value_temp}
#
#    FOR    ${index}    IN RANGE    ${count}
#        press keys      ${txt_unprinted_jobs}       DELETE
#    END
#
#    input text    ${txt_unprinted_jobs}    ${hybrid_unprinted_jobs_value}
#
#    ${hybrid_unprinted_jobs_value}    get value   ${txt_unprinted_jobs}
#
##Get user input values for Hybrid printed job
##########################################################################
#    ${hybrid_printed_jobs_value_temp}    get value   ${txt_printed_jobs}
#    ${count}    get length  ${hybrid_printed_jobs_value_temp}
#
#    FOR    ${index}    IN RANGE    ${count}
#        press keys      ${txt_printed_jobs}       DELETE
#    END
#
#    input text    ${txt_printed_jobs}    ${hybrid_printed_jobs_value}
#    ${hybrid_printed_jobs_value}    get value   ${txt_printed_jobs}
#
################################################################
#
##Validate late Binding is enabled
#    sleep_call_2
##Setting value for Late Binding
#    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_latebinding}
#
#    ${latebind}     convert to string   ${latebind}
#    ${isCheck}     convert to string   ${isCheck}
#    ${result}=  run keyword and return status   Should Be Equal As Strings      ${latebind}     ${isCheck}
#    run keyword if      ${result}       select checkbox     ${chk_latebinding}
#    ...         ELSE    unselect checkbox       ${chk_latebinding}
#
#    ${latebind}     run keyword and return status   checkbox should be selected     ${chk_latebinding}
#
################################################################
##Check the default queue name as selected by user
##Check default state which is SAAS. If user provides true, keep as it is. If false, select Hybrid
#    sleep_call_2
#
#    ${isCheck} =    Run Keyword And Return Status    element attribute value should be      ${rad_saas}     aria-checked        true
#
#    ${saas}     convert to string   ${saas}
#    ${isCheck}     convert to string   ${isCheck}
#    ${result}=  run keyword and return status   Should Be Equal As Strings      ${saas}     ${isCheck}
#    run keyword if      ${result}       click element     ${rad_saas}
#    ...         ELSE    click element       ${rad_hybrid}
#
#    ${saas}     run keyword and return status       element attribute value should be       ${rad_saas}     aria-checked        true
#
#####################################################################
##Create Pacakge
#    click button        ${btn_create}
#
##Wait till package is ready
#    sleep_call
#    wait until element is visible   ${dlg_download}
#
#    wait until element is enabled       ${btn_download}
#    element text should be      ${lbl_complete}     Your custom package is ready for downloading.
#
#    sleep_call_2
#
##Click Download
#    click button        ${btn_download}
#    #logout and close browsers
#    sleep_call
#    click element   ${lnk_username}
#    wait until page contains element    ${lnl_logout}
#    sleep_call_2
#    click element   ${lnl_logout}
#
#    ${download_flag}=   download_wait   customPackage.zip
#    sleep_call
#
#    ${validation_flag}=  check_values     ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
#
#    sleep_call
#    close browser
#
#Set Unused Client Folder values
#    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
#    ${unused_client_value_delete_span_temp}    get value   ${txt_noprint_span}
#    sleep_call_2
#
##Set user input values
#    ${count}    get length  ${unused_client_value_delete_span_temp}
#
#    FOR    ${index}    IN RANGE    ${count}
#        #Press Key    ${txt_noprint_span}    \\8
#        press keys      ${txt_noprint_span}       DELETE
#    END
#
#    input text    ${txt_noprint_span}    ${unused_client_value_delete_span}
#    ${unused_client_value_delete_span}      get text    ${txt_noprint_span}
#
#Check default state
#    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
#    click element    ${lnk_custompackage}
#    sleep_call_2
#    wait until element is visible   ${lbl_clientdownload}
#    sleep_call_2
##Validating default state for notifications
#    checkbox should be selected     ${chk_status}
#    #element should be disabled      ${btn_create}
##Validating default state for unused client folder
#    checkbox should not be selected     ${chk_deletefolder}
##Enable unused client folder
#    select checkbox     ${chk_deletefolder}
#    sleep_call_2
#
##Validate SAAS is enabled
#    checkbox should be selected     ${chk_saas}
##Enable hybrid
#    checkbox should not be selected     ${chk_hybrid}
#
#    element should be disabled     ${btn_delete_printed_increment}
#    element should be disabled      ${btn_delete_printed_decrement}
#
#    select checkbox     ${chk_hybrid}
#    sleep_call_2
#    element should be enabled     ${btn_delete_unprinted_increment}
#    element should be enabled      ${btn_delete_unprinted_decrement}
#
#    scroll element into view        ${btn_cancel}
##Check default values
#    element attribute value should be       ${txt_unprinted_jobs}    value    48
#    element attribute value should be       ${txt_printed_jobs}    value    48
#    sleep_call_1
#
##Validate late Binding is enabled
#    checkbox should be selected     ${chk_latebinding}
#
##Validate default driver datastream
#
#    element attribute value should be     ${radio_PCLXL}        aria-checked    true
#    element attribute value should be     ${radio_PCL5}        aria-checked    false
#    element attribute value should be     ${radio_PS}        aria-checked    false
#    element attribute value should be     ${radio_Exclude}        aria-checked    false
#
##Check button state
#    element should be enabled       ${btn_cancel}
#    element should be enabled      ${btn_create}
##Check default driver
#    element attribute value should be     ${rad_saas}      aria-checked    true
#    element attribute value should be     ${rad_hybrid}    aria-checked    false
#    element attribute value should be    ${rad_exclude}     aria-checked    false

