*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.eu.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_nonadmin}            automateuser@test.onelxk.co
#${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0
${file_path}                    C:\\Users\\neogis\\Downloads\\Input\\Hello.txt
${file_name}                    Hello.txt
${enable_true}                  true
${enable_false}                 false
${copy_value_enable}            2
${copy_value_disable}           1
${IP}
${PIN}

*** Keywords ***
Open Browser To Login Page using Admin
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
    wait until element is visible   ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    wait until page contains element    ${org_policy}
    click element       ${org_policy}
    wait until page contains element       ${page_header}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}

Check default state of client download
    element attribute value should be       ${chk_clientdownload}       aria-checked    true

Uncheck Enable Client Download
    unselect checkbox       ${chk_clientdownload}
    click element       ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view        ${chk_clientdownload}

Check new state of client download
    element attribute value should be       ${chk_clientdownload}       aria-checked    false

Open Print queue for another user
    click element   ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${username_nonadmin}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}

Open Browser To Login Page using non admin
    ${lnk_cpm_nonadmin} =   Catenate    SEPARATOR=   ${URL}   cpm
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    go to   ${lnk_cpm_nonadmin}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services

Open Browser To Login Page using non admin disable
    Open Print queue for another user
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    sleep_call_2
    element text should be      ${header_quota_preview}     Quota remaining: Printing disabled
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    sleep_call_1
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

Open Browser To Login Page using non admin no color
    Open Print queue for another user
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    sleep_call_2
    element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (no color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    sleep_call_1
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER


Open Browser To Login Page using non admin normal
    Open Print queue for another user
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${header_quota_preview}
    sleep_call_2
    element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    sleep_call_1
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER

Check client download tab is visible for non admin
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${tab_clientdownload}
    click element       ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${header_clientdownload}
    element should not be visible     ${lnk_customwin}
    element should not be visible     ${lnk_custommac}

Check client download tab is not visible for non admin
    page should not contain element         ${tab_clientdownload}

Reset Client Download
    select checkbox       ${chk_clientdownload}
    click element       ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view    ${chk_clientdownload}

####################################################################################################
    ################DELEGATES###########################
Check default state of delegates
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view        ${chk_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_delegates}
    element attribute value should be       ${chk_delegates}       aria-checked    false

Check delegate tab is not visible
    set selenium timeout    20
    sleep_call_2
    Wait Until Keyword Succeeds     30 sec  5 sec   page should not contain element     ${lbl_delegate}
    page should not contain element     ${lbl_delegate}

Enable Delegate
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_delegates}
    select checkbox    ${chk_delegates}
    click element       ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view        ${chk_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_delegates}
    element attribute value should be       ${chk_delegates}       aria-checked    true

Check delegate tab is visible
    set selenium timeout    20
    sleep_call_2
    page should contain element     ${lbl_delegate}
    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     30 sec  5 sec   page should contain element   ${header_delegate}
    #wait until page contains element        ${header_delegate}

Reset Delegate feature
    unselect checkbox    ${chk_delegates}
    click element       ${btn_save}

####################################################################################################
    ################EMAIL###########################
Check default state of email
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view        ${chk_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_email}
    element attribute value should be       ${chk_email}       aria-checked    false

Check email header is not visible
    click element       ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should not contain element     ${header_email}

Enable Email
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_email}
    select checkbox    ${chk_email}
    sleep_call_2
    select checkbox     ${chk_guestprint}
    click element       ${btn_save}
    element attribute value should be       ${chk_email}       aria-checked    true
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view        ${chk_clientdownload}

Check email header is present
    click element       ${name_printqueue}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${header_email}
    page should contain element     ${header_email}
    ${email_text}=   check_email_header_text    ${URL}
    page should contain           ${email_text}

Reset Email feature
    unselect checkbox    ${chk_email}
    click element       ${btn_save}


Check default state of quota
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    scroll element into view        ${chk_quota}
    element attribute value should be       ${chk_quota}        aria-checked    false
    element should be disabled      ${radio_costcenter}
    element should be disabled      ${radio_dept}
    element should be disabled      ${radio_personal}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    element should not be visible   lbl_quotadefinition
    element should not be visible   lbl_quotaassignment
    element should not be visible   lbl_quotastatus

Check default state of print and keep
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    element attribute value should be       ${chk_printandkeep}        aria-checked    true

Check default state of change copy
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_latebindcopy}
    element attribute value should be       ${chk_latebindcopy}        aria-checked    true

Submit a job
    Click Element   link-navPrintQueue
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton
    Click Element   id:printQueueUploadButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      xpath://*[@id="printQueueUploadModalModalHeader"]
    choose file     id:multiFileSelectUpload    ${file_path}
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

Delete Job
    Click Element   link-navPrintQueue
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton
    click element     ${chk_deleteall}
    click element   footer-3
    click button    ${btn_delete}
    Wait Until Keyword Succeeds   60 sec    5 sec     element should be visible     ${lbl_delete}
    click button    ${btn_delegate_delete_ok}
    Wait Until Keyword Succeeds   60 sec    5 sec     page should contain   No data available

Change number of copies
    Click Element   link-navPrintQueue
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton
    click button    ${btn_defaultprintsettings}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_copies}
    click element   //*[@id="copies_increment"]
    sleep_call_1
    click button    ${btn_saveprintsettings}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton

Reset Copies
    Click Element   link-navPrintQueue
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton
    click button    ${btn_defaultprintsettings}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_copies}
    click element   //*[@id="copies_decrement"]
    sleep_call_1
    click button    ${btn_saveprintsettings}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton

Check copies value in enable state
    click element   document_link_0
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_copies}
    textfield should contain    //*[@id="copies_input"]  2
    element should be enabled   ${txt_copies}
    Click Element   link-navPrintQueue

Check copies value for previous job
    Click Element   link-navPrintQueue
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      id:printQueueUploadButton
    click element   document_link_0
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_copies}
    textfield should contain    //*[@id="copies_input"]  2
    element should be disabled   ${txt_copies}
    Click Element   link-navPrintQueue

Check copies value in disable state
    click element   document_link_0
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_copies}
    textfield should contain    //*[@id="copies_input"]  1
    element should be disabled   ${txt_copies}
    Click Element   link-navPrintQueue

Check print and keep in printer in enable state
    ${print_job_status} =   printer_automation_printkeep  ${IP}   ${PIN}  ${file_name}  ${enable_true}
    log     {print_job_status}

Check print and keep in printer in disable state
    ${print_job_status} =   printer_automation_printkeep  ${IP}   ${PIN}  ${file_name}  ${enable_false}
    log     {print_job_status}

Check latebind copy in printer in enable state
    ${print_job_status} =   printer_automation_latebindcopy  ${IP}   ${PIN}  ${file_name}  ${enable_true}     ${copy_value_enable}
    log     {print_job_status}

Check latebind copy in printer in disable state
    ${print_job_status} =   printer_automation_latebindcopy  ${IP}   ${PIN}  ${file_name}  ${enable_false}     ${copy_value_disable}
    log     {print_job_status}

Check latebind binding for previous job in op panel
    ${print_job_status} =   printer_automation_latebindcopy  ${IP}   ${PIN}  ${file_name}  ${enable_false}     ${copy_value_enable}
    log     {print_job_status}

Uncheck Print and Keep
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    click element       ${chk_printandkeep}
    click button        ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    element attribute value should be       ${chk_printandkeep}        aria-checked    false
    sleep_call_2

Check print and keep
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    click element       ${chk_printandkeep}
    click button        ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    element attribute value should be       ${chk_printandkeep}        aria-checked    true
    sleep_call_2

Uncheck Late Bind copy
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    click element       ${chk_latebindcopy}
    click button        ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    element attribute value should be       ${chk_latebindcopy}        aria-checked    false
    sleep_call_2

Check latebind copy
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    click element       ${chk_latebindcopy}
    click button        ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    element attribute value should be       ${chk_latebindcopy}        aria-checked    true
    sleep_call_2

Enable Quota
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_quota}
    select checkbox     ${chk_quota}
    click element       ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_email}
    scroll element into view     ${chk_email}

Check Quota feature controls
    set selenium timeout    20
    element attribute value should be       ${chk_quota}        aria-checked    true
    element should be enabled      ${radio_costcenter}
    element attribute value should be       ${radio_costcenter}     aria-checked    true
    element attribute value should be       ${radio_dept}     aria-checked    false
    element attribute value should be       ${radio_personal}     aria-checked    false
    element should be enabled      ${radio_dept}
    element should be enabled      ${radio_personal}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotadefinition}
    element should be visible   ${lbl_quotadefinition}
    element should be visible   ${lbl_quotaassignment}
    element should be visible   ${lbl_quotastatus}

Reset Quota
    unselect checkbox   ${chk_quota}
    click element       ${btn_save}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view    ${chk_clientdownload}

Log Out Non admin
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    sleep_call_2
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers

Log out
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}
    scroll element into view    ${chk_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnk_username}
    click element   ${lnk_username}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnl_logout}
    click element   ${lnl_logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers

Log out quota
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnk_username}
    click element   ${lnk_username}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnl_logout}
    click element   ${lnl_logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers
###################################################################################################################

Select Cost Center or Personal
    set selenium timeout    20
    select checkbox     ${chk_costcenter}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}

Reset to Cost Center or Personal and uncheck quota
    click element     ${chk_costcenter}
    #unselect checkbox       ${chk_quota}
    click element       ${btn_save}

Open Quota Assignment Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain   Quota Assignments

Check whether cost center and personal tab is displayed
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${tab_costcenter}
    element attribute value should be       ${tab_costcenter}       title       Cost Center
    #element should be enabled       ${tab_personal}
    element attribute value should be       ${tab_personal}       title       Personal

Select Department or Personal
    set selenium timeout    20
    click element     ${radio_dept}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}

Select Personal
    set selenium timeout    20
    click element     ${radio_personal}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}


Check whether department and personal tab is displayed
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    ${tab_costcenter}
    element should be visible       ${tab_costcenter}
    element attribute value should be       ${tab_costcenter}       title       Department
    element should be enabled       ${tab_personal}
    element attribute value should be       ${tab_personal}       title       Personal

Check whether no tab is displayed
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible    ${tab_costcenter}
    element should not be visible       ${tab_costcenter}
    element should not be visible       ${tab_personal}

Open Quota Definition Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_create_quota}

Check default quota definition
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${icon_definition}
    click element   ${icon_definition}

    page should contain     Quota interval
    page should contain     Total Quota (Color + B&W)
    page should contain     Color printing limit
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be     ${quota_interval_value}  Monthly
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be     ${total_quota_value}     Unlimited
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be     ${bw_quota_value}        Unlimited

    click button       ${btn_default}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${quota_limit}
    element text should be      ${quota_limit}        Same limits for each month
    element text should be      ${total_quota}        Allow unlimited printing
    element attribute value should be       ${radio_unlimited}     aria-checked        true
    click button        ${btn_cancel_changes}

Open Browser and Quota Page
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
    wait until element is visible   ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}


Create Custom quota monthly
    [Arguments]        ${quota_name}     ${quota_interval}      ${quota_total}      ${quota_color}  ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}
    set selenium timeout    20
    Set Global Variable   ${quota_color_value}
    Set Global Variable   ${quota_color}

    Set Global Variable   ${quota_name}
    Set Global Variable   ${quota_interval_value}
    Set Global Variable   ${quota_total_value}

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_create_quota}

    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${quota_interval}
    click element   ${quota_interval}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${quota_total}
    click element   ${quota_total}
    ${is_disable}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Disable all printing
    ${is_custom}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Set custom quota
    run keyword if  ${is_disable}      Set Disable Print
    ...     ELSE IF    ${is_custom}      Set Custom Total
    ...     ELSE    Set Color Controls


Create Custom quota vary
    [Arguments]        ${quota_name}     ${quota_interval}     ${month}      ${quota_total}      ${quota_color}  ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}     ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}

    set selenium timeout    20
    Set Global Variable   ${quota_color_value}
    Set Global Variable   ${quota_color}

    Set Global Variable   ${quota_name}
    Set Global Variable   ${quota_interval_value}
    Set Global Variable   ${quota_total_value}
    Set Global Variable   ${month}

    Set Global Variable   ${monthly_total_id}
    Set Global Variable   ${monthly_total_value}
    Set Global Variable   ${monthly_color_id}
    Set Global Variable   ${monthly_color_value}

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_create_quota}

    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_interval}
    click element   ${quota_interval}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible       ${month}
    click element     ${month}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_quotaname}
    click element   ${txt_quotaname}
    click button        ${btn_monthly}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${quota_total}
    click element   ${quota_total}
    ${is_disable}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Disable all printing
    ${is_custom}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Set custom quota
    run keyword if  ${is_disable}      Set Disable Print
    ...     ELSE IF    ${is_custom}      Set Custom Total
    ...     ELSE    Set Color Controls


Set Color Controls
    set selenium timeout    20
    click element   ${quota_color}
    ${custom_color}=     run keyword and return status   element attribute value should be       ${radio_customcolor}    aria-checked    true
    run keyword if  ${custom_color}   Set Custom Color

    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${btn_create_def}
    click button    ${btn_create_def}

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    createDefinitionButton
    run keyword     Set Quota Assignment for Cost Center
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${btn_delete_def}
    click button    ${btn_delete_def}
    run keyword     Check Quota Assignment is removed

Set Disable Print
    set selenium timeout    20
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_create_def}
    click button    ${btn_create_def}

    run keyword     Set Quota Assignment for Cost Center
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_delete_def}
    click button    ${btn_delete_def}

    run keyword     Check Quota Assignment is removed

Set Custom Color
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      ${quota_color_value}

Set Custom Total
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      ${quota_total_value}
    run keyword     Set Color Controls


Set Quota Assignment for Cost Center
    set selenium timeout    25
    sleep_call_2
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${admin_dropdown}
    sleep_call_2
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
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${btn_assignquota}
    click button    ${btn_assignquota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_costcentername}
    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${costcenter}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_costcentername}
    Press Keys    ${lst_costcentername}    ENTER
    click element   ${txt_quota_def}
    press keys      ${lst_quota_def}    ARROW_DOWN
    Press Keys    ${lst_quota_def}    ENTER
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${tbl_costcenter_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be    ${tbl_costcenter_quota_name}    ${quota_name}

    element text should be      ${costcenter_name}      ${costcenter}
    click element       ${quota_name_link}

    run keyword     Check the table values

    #run keyword     Open Browser To Login Page using Admin
    run keyword     Open Organisational Policy Page
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${costcenter_assignment_count}
    element text should be      ${costcenter_assignment_count}      1

Set cost center
    click element   ${chk_costcenter}
    click button    ${btn_save}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be enabled    ${btn_save}

Check Quota Assignment is removed
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain    ${noquotaassignment}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Check Header Text
    set selenium timeout    20
    ${iscolordisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}

    Run Keyword If  ${iscolordisable}  Open Browser To Login Page using non admin no color
    ...     ELSE    run keyword     Open Browser To Login Page using non admin normal

##########################################################################################
Check the table values
    set selenium timeout    20
    element text should be      ${monthly_total_id}   ${monthly_total_value}
    element text should be      ${monthly_color_id}   ${monthly_color_value}

    click button    ${btn_summary_close}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${name_printqueue}
    click element   ${name_printqueue}

    ${isdisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${monthly_total_value}    ${totaldisable}
    #${iscolorcustom}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}


    Run Keyword If     ${isdisable}   Open Browser To Login Page using non admin disable
    ...     ELSE    run keyword     Check Header Text




########################################################################################################################


