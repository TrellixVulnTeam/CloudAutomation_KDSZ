*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
${URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                     sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${username_nonadmin}            cpmautomation@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0
${total}
${color}

*** Keywords ***

Open Browser To Login Page using admin
#Call python
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
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
    go to   ${lnk_cpm}
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
    sleep_call_2

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

Log out
    set selenium timeout    20
    scroll element into view        singlechk
    sleep_call_2
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers