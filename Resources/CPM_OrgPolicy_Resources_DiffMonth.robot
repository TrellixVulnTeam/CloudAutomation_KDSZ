*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
${URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                     sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${username_nonadmin}            simpleuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0

*** Keywords ***
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

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_quota}

    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_quotalimit}
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_interval}
    click element   ${quota_interval}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${month}
    click element     ${month}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    click element   ${txt_quotaname}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_monthly}
    click button        ${btn_monthly}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_total}
    click element   ${quota_total}

    ${is_disable}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Disable all printing
    ${is_custom}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Set custom quota
    run keyword if  ${is_disable}      Set Disable Print
    ...     ELSE IF    ${is_custom}      Set Custom Total
    ...     ELSE    Set Color Controls


Set Color Controls
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${quota_color}
    click element   ${quota_color}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${radio_customcolor}
    ${custom_color}=     run keyword and return status   element attribute value should be       ${radio_customcolor}    aria-checked    true
    run keyword if  ${custom_color}   Set Custom Color
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${btn_create_def}
    click button    ${btn_create_def}

    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${job_name}
    click element   ${job_name}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${monthly_total_id}   ${monthly_total_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${monthly_color_id}   ${monthly_color_value}
    Wait Until Keyword Succeeds    35 sec    5 sec   page should contain element    ${btn_cancel_monthly}
    click button    ${btn_cancel_monthly}

   # run keyword     Set Quota Assignment for Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec   page should contain element    ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec   page should contain element    ${btn_delete_def}
    click button    ${btn_delete_def}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Set Disable Print
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${btn_vary_ok}
    click button    ${btn_vary_ok}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${btn_create_def}
    click button    ${btn_create_def}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${job_name}
    click element   ${job_name}
    Wait Until Keyword Succeeds    35 sec    5 sec   element text should be      ${monthly_total_id}   ${monthly_total_value}
    Wait Until Keyword Succeeds    35 sec    5 sec   element text should be      ${monthly_color_id}   ${monthly_color_value}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${btn_cancel_monthly}
    click button    ${btn_cancel_monthly}


   # run keyword     Set Quota Assignment for Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec   page should contain element    ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec   page should contain element    ${btn_delete_def}
    click button    ${btn_delete_def}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${admin_dropdown}
    sleep_call_2
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible    ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Set Custom Color
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_color_value}
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    sleep_call_2
    input text      ${txt_color_value}      ${quota_color_value}

Set Custom Total
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    sleep_call_2
    input text      ${txt_total_value}      ${quota_total_value}
    run keyword     Set Color Controls

Log out quota
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnk_username}
    click element   ${lnk_username}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnl_logout}
    click element   ${lnl_logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


#Set Quota Assignment for Cost Center
#    set selenium timeout    20
#    wait until element is visible   ${admin_dropdown}
#    click element       ${admin_dropdown}
#    wait until page contains element    ${org_policy}
#    sleep_call_2
#    click element       ${org_policy}
#    wait until page contains element       ${page_header}
#    sleep_call_2
#    click element   ${chk_costcenter}
#    click button    ${btn_save}
#    sleep_call_2
#    wait until element is visible   ${admin_dropdown}
#    click element       ${admin_dropdown}
#    sleep_call_2
#    click element       ${lbl_quotaassignment}
#    sleep_call
#    sleep_call
#    #Assign Quota by Cost Center
#    click button    ${btn_assignquota}
#    sleep_call_1
#
#    click element   ${txt_costcentername}
#    input text      ${txt_costcentername_input}       ${costcenter}
#    sleep_call_2
#    element should be visible   ${lst_costcentername}
#    Press Keys    ${lst_costcentername}    ENTER
#    click element   ${txt_quota_def}
#    press keys      ${lst_quota_def}    ARROW_DOWN
#    Press Keys    ${lst_quota_def}    ENTER
#    sleep_call_1
#    #select from list by value       ${lst_quota_def}        ${quota_name}
#    wait until element is enabled   ${btn_vary_ok}
#    sleep_call_2
#    click button    ${btn_vary_ok}
#    sleep_call
#    wait until element is visible   ${tbl_costcenter_quota}
#    element text should be      ${tbl_costcenter_quota_name}    ${quota_name}
#
#    sleep_call_1
#    element text should be      ${costcenter_name}      ${costcenter}
#    click element       ${quota_name_link}
#    sleep_call_1
#
#    run keyword     Check the table values
#
#    element text should be      ${costcenter_assignment_count}      1
#    sleep_call_2
#
#Check Quota Assignment is removed
#    set selenium timeout    20
#    sleep_call_1
#    click element       ${admin_dropdown}
#    sleep_call_2
#    click element       ${lbl_quotaassignment}
#    page should contain    ${noquotaassignment}
#    click element       ${admin_dropdown}
#    sleep_call_2
#    click element       ${lbl_quotadefinition}
#    sleep_call_2
#
#Check Header Text
#    ${iscolordisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}
#    Run Keyword If  ${iscolordisable}  element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (no color printing)
#
#    ...     ELSE    run keyword        element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)
#
#############################################################################################################
#Set Quota Assignment for Personal
#    set selenium timeout    20
#    wait until element is visible   ${admin_dropdown}
#    click element       ${admin_dropdown}
#    sleep_call_2
#    click element       ${lbl_quotaassignment}
#    sleep_call
#    click element   ${tab_personal}
#    click button    ${btn_assignquota}
#    sleep_call_2
#    click element   ${txt_email}
#    input text      ${txt_email_input}   ${USER}
#    sleep_call_2
#    #element should be visible   ${lst_email}
#    Press Keys    ${lst_email}    ENTER
#    sleep_call_2
#    click element   ${txt_quota_def}
#    press keys      ${lst_quota_def}    ARROW_DOWN
#    Press Keys    ${lst_quota_def}    ENTER
#    sleep_call_2
#    wait until element is enabled   ${btn_vary_ok}
#    sleep_call_2
#    click button    ${btn_vary_ok}
#    sleep_call
#    wait until element is visible   ${tbl_email_quota}
#    element text should be      ${tbl_personal_name}    ${USER}
#
#    sleep_call
#    #wait until element is visible   ${tbl_email_quota_name}
#    element text should be      ${tbl_email_quota_name}    ${quota_name}
#
#    click element       ${email_quota_link}
#    sleep_call_1
#    run keyword     Check the table values
#    #element text should be      ${personal_assignment_count}      1
#    #sleep_call_2
#
###########################################################################################
#Check the table values
#    set selenium timeout    20
#    element text should be      ${monthly_total_id}   ${monthly_total_value}
#    element text should be      ${monthly_color_id}   ${monthly_color_value}
#
#    click button    ${btn_summary_close}
#    sleep_call_1
#
#    click element   ${name_printqueue}
#    sleep_call_2
#
#    ${isdisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${monthly_total_value}    ${totaldisable}
#    #${iscolorcustom}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}
#
#
#    Run Keyword If     ${isdisable}    element text should be      ${header_quota_preview}     Quota remaining: Printing disabled
#    ...     ELSE    run keyword     Check Header Text
#
#
#    click element       ${admin_dropdown}
#    sleep_call_2
#    click element       ${lbl_quotadefinition}
#    sleep_call



