*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py

*** Variables ***
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
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
${SAAS_PACKAGE NAME}                 LPMCCloudUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.197.pkg
${HYBRIDNAME}                         Hybrid Print Management
${HYBRIDLINK}                         macPackageType-listbox-item-serverless
${HYBRID_PACKAGE NAME}                 LPMCServerlessUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.188.pkg
${WINSAASNAME}                      Cloud Print Management
${WINSAASLINK}                      windowsPackageType-listbox-item-default
${WINSAAS_PACKAGE NAME}             LPMC_CloudUS_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${WINHYBRIDNAME}                      Hybrid Print Management
${WINHYBRIDLINK}                      windowsPackageType-listbox-item-serverless
${WINHYBRID_PACKAGE NAME}             LPMC_ServerlessUS_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${notification}                         True
${DELETE CLIENT FOLDER}                 True
${unused_client_value_delete_span}      10
${hybrid_unprinted_jobs_value}          20
${latebind}                             True
${hybrid_printed_jobs_value}            120
${saas}                                 True

*** Keywords ***

Open CPM portal and Login Verification
    [Arguments]    ${username}      ${password}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Title Should Be     ${PORTAL TITLE}
    Element Text Should Be      ${txt_lgnyear}     ${loginyear}
    element should be enabled   ${txt_username}
    element should be visible   ${txt_username}
    element should not be visible   ${txt_password}
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    element should be enabled   ${btn_next}
    element should be visible   ${btn_next}
    element attribute value should be   ${btn_next}     value   ${next}
    Click Button    ${btn_next}
    element should be enabled   ${txt_password}
    element should be visible   ${txt_password}
    Input Text    ${txt_password}   ${password}
    sleep_call_1
    element should be enabled   ${btn_login}
    element should be visible   ${btn_login}
    element attribute value should be   ${btn_login}     value   ${login}
    Click Button    ${btn_login}
    sleep_call

Dashboard Should Open
    set selenium timeout    20
    wait until page contains    Cloud Services Home
    Title Should Be     Dashboard | Lexmark Cloud Services
    sleep_call


Check Adding Valid and Duplicate Delegates
   [Arguments]        ${EMAIL USER}
    set selenium timeout    20
    Wait until Element Is Visible   ${lbl_delegate}
    page should contain     No data available
    Wait until Element Is Visible   ${lbl_delegate}
    Click Element   ${lbl_delegate}
    Wait until Element Is Visible   ${txt_delegate}
    sleep_call_2

    element should be enabled   ${btn_delegate_add}
    element should be visible   ${btn_delegate_add}
    element should be disabled  ${btn_delegate_remove}

    click element   ${btn_delegate_add}
    sleep_call_2
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    wait until element is visible   ${lst_delegate}
    element should be visible   ${lst_delegate}
    #sleep_call_2
    wait until element contains  ${lst_delegate}       ${EMAIL USER}
    #element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    sleep_call_2
    element should be enabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_add}
    sleep_call_2

    element text should be      ${lst_table_entry}      ${EMAIL USER}

    click element   ${btn_delegate_add}
    sleep_call_2
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    sleep_call_2
    element should be visible   ${lst_delegate}
    element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    sleep_call_2
    element should be disabled   ${dlg_btn_delegate_add}
    page should contain      Delegate already exists
    click button    ${dlg_btn_delegate_cancel}

    element should be disabled      ${btn_delegate_remove}
    ${dummy_click}      set variable        delegatesBreadcrumb
    sleep_call_2
    wait until page contains element    ${chk_delegate_delete}
    click element     ${chk_delegate_delete}
    sleep_call_2
    click element   ${dummy_click}
    element should be enabled      ${btn_delegate_remove}
    wait until page contains element    ${btn_delegate_remove}
    click button    ${btn_delegate_remove}
    sleep_call_2

    element text should be      ${lbl_delete_delegate}     Remove Delegates


    click button    ${btn_delegate_delete_ok}
    sleep_call_2

    element should not be visible   ${lst_table_entry}
    sleep_call

    click element       ${name_printqueue}


Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call
    set selenium timeout    20
    #Wait Until Element Is Visible   ${lnk_cpm}
    #Click Element   ${lnk_cpm}
    go to       ${lnk_cpm}

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
    sleep_call

    reload page
    sleep_call_2
    reload page
    sleep_call
    click element   ${name_printqueue}

    element text should be      ${email_job1_description}      Test Mail
    element text should be      ${email_job2_description}      Test Mail

    element should contain      ${email_job1}        Test Mail.html
    element should contain      ${email_job2}        ${FILENAME}

    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        E-Mail
    element should be visible   ${email_icon_job2}
    element attribute value should be      //*[@id="documents-row-1-client"]/lpm-source-renderer/div     title        E-Mail

    reload page
    sleep_call
    reload page
    sleep_call

    element text should be      ${email_job1_status}        Ready
    element text should be      ${email_job2_status}        Ready

#Call the Print Device Automation Python script for releasing the first job
    ${print_job_status} =   printer_automation  ${FILENAME}
    log     {print_job_status}
    sleep_call

#Check Print Job History table
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    reload page
    Wait until Element Is Visible   ${name_printqueue}
    wait until page does not contain element    ${FILENAME}
    sleep_call_2
    reload page
    sleep_call
    reload page
    sleep_call
    #wait until page contains    Print Job History
    sleep_call_2
    click element   link-navJobHistory
    ${print_job_name1}   set variable    dataGridMyPrintJobsId-row-0-jobName
    wait until element contains     ${print_job_name1}     ${FILENAME}

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
    Wait until Element Is Visible   ${name_printqueue}
    wait until page does not contain element    Test Mail.html
    sleep_call_2
    click element   link-navJobHistory
    wait until page contains    Print Job History
    reload page
    wait until page contains    Print Job History
    ${print_job_name}   set variable    dataGridMyPrintJobsId-row-0-jobName
    sleep_call_2
    wait until element contains     ${print_job_name}     ${FILENAME2}

    element text should be      ${print_job_name}     Test Mail.html
    sleep_call_2

    Click Element   link-navPrintQueue

Mobile submission
    #[Arguments]        ${FILENAME}
    set selenium timeout    20
    ${mobile_status}=   mobile_submit
    reload page
    sleep_call
    reload page
    sleep_call
    wait until page contains element    ${email_job1_description}
    element text should be      ${email_job1_description}      A test document to upload
    element should contain      ${tbl_printqueue}        mobile.doc
    element should be visible   ${email_icon_job1}
    element attribute value should be      //*[@id="documents-row-0-client"]/lpm-source-renderer/div     title        Mobile
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
    click element       ${name_printqueue}

Open Browser To Login Page using admin
#Call python
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    #Wait Until Element Is Visible   ${lnk_cpm}
    #Click Element   ${lnk_cpm}
    go to       ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call

Open Organisational Policy Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${org_policy}
    sleep_call_2
    click element       ${org_policy}
    wait until page contains element       ${page_header}
    sleep_call_2

Select Personal
    set selenium timeout    20
    click element     ${radio_personal}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Open Quota Definition Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotadefinition}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Open Quota Status Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quota_status}
    sleep_call_2
    click element       ${lbl_quota_status}
    sleep_call_2

Create Quota different for month
    sleep_call
    set selenium timeout    20
    wait until page contains element  ${btn_create_quota}
    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota_Total50_Color50
    click element   ${lst_quotalimit}
    sleep_call_1
    click element   ${quota_interval}
    sleep_call_2
    click element     ${month}
    sleep_call_1
    click element   ${txt_quotaname}
    click button        ${btn_monthly}
    sleep_call_2
    click element   ${lst_total_quota}
    sleep_call_1
    click element   ${quota_total}
    sleep_call_1
    wait until page contains element    ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      50
    sleep_call_2
    click element   ${quota_color}
    sleep_call_2
    wait until page contains element    ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      50
    click button    ${btn_vary_ok}
    wait until page contains element        ${btn_create_def}
    click button    ${btn_create_def}
    sleep_call

Create Custom Quota
    sleep_call
    set selenium timeout    20
    wait until page contains element  ${btn_create_quota}
    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota Status_Total10_Color10
    click element   ${lst_quotalimit}
    sleep_call_1
    click element   ${quota_interval}
    sleep_call_2
    click element     ${month}
    sleep_call_1
    click element   ${txt_quotaname}
    click button        ${btn_monthly}
    sleep_call_2
    click element   ${lst_total_quota}
    sleep_call_1
    click element   ${quota_total}
    sleep_call_1
    wait until page contains element    ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      10
    sleep_call_2
    click element   ${quota_color}
    sleep_call_2
    wait until page contains element    ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      10
    click button    ${btn_vary_ok}
    wait until page contains element        ${btn_create_def}
    click button    ${btn_create_def}
    sleep_call

#Create user
    ${user}=   create_user
    log     ${user}


Set Quota Assignment for Personal
    set selenium timeout    20
    sleep_call
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotaassignment}

    wait until page contains element    ${btn_assignquota}
    sleep_call_2
    click button    ${btn_assignquota}
    sleep_call_2
    click element   ${txt_email}
    sleep_call_2
    input text      ${txt_email_input}   ${username_nonadmin}
    sleep_call_2
    #element should be visible   ${lst_email}
    Press Keys    ${lst_email}    ENTER
    sleep_call_2
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    sleep_call_2
    wait until element is enabled   ${btn_vary_ok}
    sleep_call_2
    click button    ${btn_vary_ok}
    sleep_call
    wait until element is visible   ${tbl_email_quota}
    element text should be      ${tbl_personal_name}    ${username_nonadmin}


Check Status Table for normal
    set selenium timeout    25
    ${total}    ${color}=   quota_green
    reload page
    sleep_call_2
    reload page
    Open Quota Status Page
    wait until page contains             User Quota Status

    wait until page contains element    ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-valid text-primary
    sleep_call_2
    click element   ${name_printqueue}
    wait until element is visible   ${btn_upload}
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    sleep_call
    wait until element is visible   ${header_quota_preview}
    element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    sleep_call_2

Check Status Table for warning
    set selenium timeout    25
    ${total}    ${color}=   quota_yellow
    reload page
    sleep_call_2
    reload page
    Open Quota Status Page
    wait until page contains             User Quota Status

    wait until page contains element    ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-warning text-warning
    sleep_call_2
    click element   ${name_printqueue}
    wait until element is visible   ${btn_upload}
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    sleep_call
    wait until element is visible   ${header_quota_preview}
    element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    sleep_call_2

Check Status Table for exceeded
    set selenium timeout    25
    ${total}    ${color}=   quota_red
    reload page
    sleep_call_2
    reload page
    Open Quota Status Page
    wait until page contains             User Quota Status

    wait until page contains element    ${lbl_quotausername}
    element should contain      ${lbl_quotausername}       ${username_nonadmin}
    element should contain      ${lbl_totalquotaremaining}    ${total}
    element should contain      ${lbl_colorquotaremaining}     ${color}
    element attribute value should be      ${icon_condition}     class   glyphicon icon-notify_alert text-danger
    sleep_call_2
    click element   ${name_printqueue}
    wait until element is visible   ${btn_upload}
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    wait until element is visible   ${header_quota_preview}
    sleep_call
    element text should be      ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    sleep_call_2
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
    sleep_call_2

Delete Quota
    ${deleted}=   delete_user
    run keyword     Open Quota Definition Page
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    sleep_call_2
    click button    ${btn_delete_def}
    sleep_call

Reset to Cost center
    run keyword     Open Organisational Policy Page
    wait until element is visible       ${btn_save}
    click element       ${radio_costcenter}
    sleep_call_2
    click button        ${btn_save}

Logoutadmin
    set selenium timeout    20
    scroll element into view        singlechk
    sleep_call_2
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers

Exit
    set selenium timeout    20
    sleep_call_2
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers

Check Table Values
    set selenium timeout    20
    sleep_call_2
    element text should be      ${monthly_total_id}   50
    element text should be      ${monthly_color_id}   50
    click button    ${btn_summary_close}
    wait until page contains element        ${tbl_cc_quota_name}
    element text should be      ${tbl_cc_quota_name}    ${quota_name}

    sleep_call_1

Create Monthly Quota
    sleep_call
    set selenium timeout    20
    wait until page contains element  ${btn_create_quota}
    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota_Total50_Color50
    click element   ${lst_quotalimit}
    sleep_call_1
    click element   ${quota_interval_1}
    sleep_call_2
    click element   ${lst_total_quota}
    sleep_call_1
    click element   ${quota_total}
    sleep_call_1
    wait until page contains element    ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      50
    sleep_call_2
    click element   ${quota_color}
    sleep_call_2
    wait until page contains element    ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      50
    #click button    ${btn_vary_ok}
    wait until page contains element        ${btn_create_def}
    click button    ${btn_create_def}
    sleep_call

Select Cost Center or Personal First
    set selenium timeout    20
    click element    ${chk_costcenter}
    #wait until page contains element        ${btn_confirmchange}
    #click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Select Cost Center or Personal
    set selenium timeout    20
    click element     ${chk_costcenter}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Open Quota Assignment Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotaassignment}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    sleep_call_2

Set Quota Assignment for Cost Center
    set selenium timeout    25
    sleep_call
    wait until page contains element   ${btn_assignquota}
    click button    ${btn_assignquota}
    sleep_call_1

    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${costcenter}
    sleep_call_2
    element should be visible   ${lst_costcentername}
    Press Keys    ${lst_costcentername}    ENTER
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    sleep_call_1
    #select from list by value       ${lst_quota_def}        ${quota_name}
    wait until element is enabled   ${btn_vary_ok}
    sleep_call_2
    click button    ${btn_vary_ok}
    sleep_call
    wait until element is visible   ${tbl_costcenter_quota}
    element text should be      ${tbl_costcenter_quota_name}    ${quota_name}
    sleep_call_1
    element text should be      ${costcenter_name}      ${costcenter}
    click element       ${quota_name_link}
    run keyword     Check Table Values
    sleep_call_1
    run keyword     Open Quota Definition Page
    element text should be      ${costcenter_assignment_count}      1
    sleep_call_2

Select Department or Personal
    set selenium timeout    20
    click element     ${radio_dept}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Set Quota Assignment for Department
    sleep_call
    set selenium timeout    20
    wait until page contains element    ${btn_assignquota}
    click button    ${btn_assignquota}
    sleep_call_1

    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${dept}
    sleep_call_2
    element should be visible   ${lst_costcentername}
    Press Keys    ${lst_costcentername}    ENTER
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    sleep_call_1
    wait until element is enabled   ${btn_vary_ok}
    sleep_call_2
    click button    ${btn_vary_ok}
    sleep_call
    #wait until element is visible   ${tbl_costcenter_quota}
    wait until element is visible   ${tbl_costcenter_quota_name}
    sleep_call_2
    #element text should be      ${tbl_costcenter_quota_name}    ${quota_name}
    element should contain      ${tbl_costcenter_quota_name}    ${quota_name}

    sleep_call_1
    element should contain      ${costcenter_name}      ${dept}
    click element       ${quota_name_link}
    sleep_call_1
    run keyword     Check Dialog Values

    run keyword     Open Quota Definition Page
    element should contain      ${dept_assignment_count}      1
    sleep_call_2


Check Dialog Values
    wait until element is visible       ${btn_summary_close}
    page should contain         Same limits for each month
    page should contain         Total quota (color + black-and-white): 50
    page should contain         Color printing limit: 50
    click button    ${btn_summary_close}
    wait until page contains element        ${tbl_cc_quota_name}
    element text should be      ${tbl_cc_quota_name}    ${quota_name}
    sleep_call_1

Download MAC Default Packages for SAAS
    ${lnk_cpm} =   Catenate    SEPARATOR=/   ${URL}   cpm

    Open Browser    ${URL}    ${NORMALBROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    sleep_call

    run keyword     Change Security Settings
#OPen Dashboard
   go to   ${URL}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call


#Check Client Download Tab opens and check Text
    Wait until Element Is Visible   id:link-navClientDownload
    Click Element   id:link-navClientDownload
    Wait until Element Is Visible   xpath://*[@id="clientDownloadPageHeader"]/div[1]/h2
    sleep_call

#Download MAC Default Packages
    [Arguments]        ${MACSAASNAME}     ${MACSAASLINK}      ${MACSAAS_PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait until page contains element    ${MACSAASLINK}
    click element   ${MACSAASLINK}

#Click Download button
    sleep_call_2
    click button    ${download_btn}
    sleep_call_2
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    sleep_call_2
    ${download_flag}=   download_wait   ${MACSAAS_PACKAGE NAME}
    log     ${download_flag}
    sleep_call
    sleep_call
    delete_file     ${MACSAAS_PACKAGE NAME}
    sleep_call
    close browser

Download MAC Default Packages for Hybrid
    Open Browser    ${URL}    ${NORMALBROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    sleep_call
    run keyword     Change Security Settings

#OPen Dashboard
   go to   ${URL}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call


#Check Client Download Tab opens and check Text
    Wait until Element Is Visible   id:link-navClientDownload
    Click Element   id:link-navClientDownload
    Wait until Element Is Visible   xpath://*[@id="clientDownloadPageHeader"]/div[1]/h2
    sleep_call

#Download MAC Default Packages
    [Arguments]        ${MACHYBRIDNAME}     ${MACHYBRIDLINK}      ${MACHYBRID_PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait until page contains element    ${MACHYBRIDLINK}
    click element   ${MACHYBRIDLINK}

#Click Download button
    sleep_call_2
    click button    ${download_btn}
    sleep_call_2
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    sleep_call_2
    ${download_flag}=   download_wait   ${MACHYBRID_PACKAGE NAME}
    log     ${download_flag}
    sleep_call
    delete_file     ${MACHYBRID_PACKAGE NAME}
    sleep_call
    close browser


Download Default Packages for Windows for SAAS
    Open Browser    ${URL}    ${NORMALBROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    sleep_call
#Dashboard Should Open
    run keyword     Change Security Settings


#OPen Dashboard
   go to   ${URL}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call


#Check Client Download Tab opens and check Text
    Wait until Element Is Visible   id:link-navClientDownload
    Click Element   id:link-navClientDownload
    Wait until Element Is Visible   xpath://*[@id="clientDownloadPageHeader"]/div[1]/h2
    sleep_call

#Download Default Packages for Windows
    [Arguments]        ${WINSAASNAME}     ${WINSAASLINK}      ${WINSAAS_PACKAGE NAME}

    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType

    click element   ${download_list}
    wait until page contains element    ${WINSAASLINK}
    click element   ${WINSAASLINK}

#Click Download button
    sleep_call_2
    click button    ${download_btn}
    sleep_call_2
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    sleep_call_2
    ${download_flag}=   download_wait   ${WINSAAS_PACKAGE NAME}
    log     ${download_flag}
    sleep_call
    sleep_call
    delete_file     ${WINSAAS_PACKAGE NAME}
    sleep_call_2
    close browser


Download Default Packages for Windows for Hybrid
    Open Browser    ${URL}    ${NORMALBROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    sleep_call
#Dashboard Should Open
    run keyword     Change Security Settings


#OPen Dashboard
   go to   ${URL}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call


#Check Client Download Tab opens and check Text
    Wait until Element Is Visible   id:link-navClientDownload
    Click Element   id:link-navClientDownload
    Wait until Element Is Visible   xpath://*[@id="clientDownloadPageHeader"]/div[1]/h2
    sleep_call

#Download Default Packages for Windows
    [Arguments]        ${WINSHYBRIDAME}     ${WINHYBRIDLINK}      ${WINHYBRID_PACKAGE NAME}

    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType

    click element   ${download_list}
    wait until page contains element    ${WINHYBRIDLINK}
    click element   ${WINHYBRIDLINK}

#Click Download button
    sleep_call_2
    click button    ${download_btn}
    sleep_call_2
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    sleep_call_2
    ${download_flag}=   download_wait   ${WINHYBRID_PACKAGE NAME}
    log     ${download_flag}
    sleep_call
    sleep_call
    delete_file     ${WINHYBRID_PACKAGE NAME}
    sleep_call_2
    close browser

Create Custom Package for Windows

    [Arguments]   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
    Set Global Variable      ${unused_client_value_delete_span}
    Open Browser    ${URL}    ${NORMALBROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call

#Update Secuirty policy
    run keyword     Change Security Settings

    go to   ${URL}

    sleep_call
    #Wait Until Element Is Visible   ${lnk_cpm}
    #Click Element   ${lnk_cpm}
    go to       ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    sleep_call
    wait until element is visible   ${title_clientdownload}
    sleep_call_2

    log     ${notification}
    #go to   ${CPM URL}
    sleep_call
    #sleep_call
    click element    ${lnk_custompackage}
    sleep_call_2
    wait until element is visible   ${lbl_clientdownload}
    sleep_call_2

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
    sleep_call_2
    scroll element into view        ${btn_create}
    sleep_call_2

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
    sleep_call_2
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
    sleep_call_2

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
    sleep_call
    wait until element is visible   ${dlg_download}

    wait until element is enabled       ${btn_download}
    element text should be      ${lbl_complete}     Your custom package is ready for downloading.

    sleep_call_2

#Click Download
    click button        ${btn_download}
    #logout and close browsers
    sleep_call
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}

    ${download_flag}=   download_wait   customPackage.zip
    sleep_call

    ${validation_flag}=  check_values     ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}

    sleep_call
    close browser

Set Unused Client Folder values

    ${unused_client_value_delete_span_temp}    get value   ${txt_noprint_span}
    sleep_call_2

#Set user input values
    ${count}    get length  ${unused_client_value_delete_span_temp}

    FOR    ${index}    IN RANGE    ${count}
        #Press Key    ${txt_noprint_span}    \\8
        press keys      ${txt_noprint_span}       DELETE
    END

    input text    ${txt_noprint_span}    ${unused_client_value_delete_span}
    ${unused_client_value_delete_span}      get text    ${txt_noprint_span}

Check default state
    click element    ${lnk_custompackage}
    sleep_call_2
    wait until element is visible   ${lbl_clientdownload}
    sleep_call_2
#Validating default state for notifications
    checkbox should be selected     ${chk_status}
    #element should be disabled      ${btn_create}
#Validating default state for unused client folder
    checkbox should not be selected     ${chk_deletefolder}
#Enable unused client folder
    select checkbox     ${chk_deletefolder}
    sleep_call_2

#Validate SAAS is enabled
    checkbox should be selected     ${chk_saas}
#Enable hybrid
    checkbox should not be selected     ${chk_hybrid}

    element should be disabled     ${btn_delete_printed_increment}
    element should be disabled      ${btn_delete_printed_decrement}

    select checkbox     ${chk_hybrid}
    sleep_call_2
    element should be enabled     ${btn_delete_unprinted_increment}
    element should be enabled      ${btn_delete_unprinted_decrement}

    scroll element into view        ${btn_cancel}
#Check default values
    element attribute value should be       ${txt_unprinted_jobs}    value    48
    element attribute value should be       ${txt_printed_jobs}    value    48
    sleep_call_1

#Validate late Binding is enabled
    checkbox should be selected     ${chk_latebinding}

#Validate default driver datastream

    element attribute value should be     ${radio_PCLXL}        aria-checked    true
    element attribute value should be     ${radio_PCL5}        aria-checked    false
    element attribute value should be     ${radio_PS}        aria-checked    false
    element attribute value should be     ${radio_Exclude}        aria-checked    false

#Check button state
    element should be enabled       ${btn_cancel}
    element should be enabled      ${btn_create}
#Check default driver
    element attribute value should be     ${rad_saas}      aria-checked    true
    element attribute value should be     ${rad_hybrid}    aria-checked    false
    element attribute value should be    ${rad_exclude}     aria-checked    false

Change Security Settings
    #Change security preferences to allow EXE downloads
    go to   chrome://settings/security
    sleep_call_2

#Navigate to Standard Security Policy
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    sleep_call_2
    Press Keys    None      ARROW_UP
    sleep_call_2
