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

*** Keywords ***


Open CPM Portal and Blank user name login verification

    [Arguments]    ${username_blank}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_blank}
    sleep_call_2
    Click Button    ${btn_next}
    sleep_call_2
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Invalid user name login verification
    [Arguments]    ${username_invalid}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_invalid}
    sleep_call_2
    Click Button    ${btn_next}
    sleep_call_2
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Blank password verification
    [Arguments]    ${username}      ${password_blank}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    Click Button    ${btn_next}
    sleep_call_1
    Input Text    ${txt_password}   ${password_blank}
    Click Button    ${btn_login}
    sleep_call_1
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

Open CPM Portal and Invalid password verification
    [Arguments]    ${username}      ${password_invalid}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    Click Button    ${btn_next}
    sleep_call_1
    Input Text    ${txt_password}   ${password_invalid}
    sleep_call_1
    Click Button    ${btn_login}
    sleep_call_1
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

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

    #element should be enabled   ${btn_delegate_delete_cancel}
    #element should be enabled   ${btn_delegate_delete_ok}
    #element should be focused   ${btn_delegate_delete_cancel}

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
    Wait Until Element Is Visible   ${lnk_cpm}
    sleep_call_2
    Click Element   ${lnk_cpm}
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
    Open Quota Status Page
    wait until page contains             User Quota Status
    reload page
    sleep_call_2
    reload page
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
    Open Quota Status Page
    wait until page contains             User Quota Status
    reload page
    sleep_call_2
    reload page
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
    Open Quota Status Page
    wait until page contains             User Quota Status
    reload page
    sleep_call_2
    reload page
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
    run keyword     Check Table Values

    run keyword     Open Quota Definition Page
    element should contain      ${dept_assignment_count}      1
    sleep_call_2