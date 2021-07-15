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
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Open Quota Status Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quota_status}
    click element       ${lbl_quota_status}

Create Custom Quota
    set selenium timeout    20
    wait until page contains element  ${btn_create_quota}
    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        Quota Status_Total10_Color10
    click element   ${lst_quotalimit}
    click element   ${quota_interval}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${month}
    click element     ${month}
    click element   ${txt_quotaname}
    click button        ${btn_monthly}
    click element   ${lst_total_quota}
    click element   ${quota_total}
    wait until page contains element    ${txt_total_value}
    click element   ${txt_total_value}
    sleep_call_2
    press keys      ${txt_total_value}      \DELETE
    sleep_call_2
    input text      ${txt_total_value}      10
    sleep_call_2
    click element   ${radio_customcolor}
    sleep_call_2
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    ${txt_color_value}
    click element   ${txt_color_value}
    sleep_call_2
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      10
    sleep_call_2
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element       ${btn_create_def}
    click button    ${btn_create_def}

#Create user
    ${user}=   create_user_all  ${USER}     ${PASSWORD}     ${URL}      ${username_nonadmin}
    log     ${user}

Set Quota Assignment for Personal
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
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
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be     ${header_quota_preview}     Quota remaining: ${total} total quota (${color} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER


Check Status Table for warning
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
    ${deleted}=   delete_user_all   ${USER}     ${PASSWORD}     ${URL}  ${username_nonadmin}
    run keyword     Open Quota Definition Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_delete_def}
    click button    ${btn_delete_def}


Reset to Cost center
    run keyword     Open Organisational Policy Page
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${radio_costcenter}
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
