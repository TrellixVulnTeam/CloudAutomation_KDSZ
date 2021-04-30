*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
${URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                     sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${username_nonadmin}            automateuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   rnd
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0

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
    click element       ${admin_dropdown}
    wait until page contains element    ${org_policy}
    click element       ${org_policy}
    wait until page contains element       ${page_header}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox   ${chk_clientdownload}

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


Open Browser To Login Page using non admin disable
    Open Print queue for another user
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_upload}
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
    element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
    sleep_call_1
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER


####################################################################################################

Log out
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnk_username}
    click element   ${lnk_username}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lnl_logout}
    click element   ${lnl_logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers
###################################################################################################################

Open Quota Assignment Page
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lbl_quotaassignment}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}

Select Department or Personal
    set selenium timeout    20
    click element     ${radio_dept}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_save}
    click element       ${btn_save}


Open Quota Definition Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

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
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_create_def}
    click button    ${btn_create_def}

    run keyword     Set Quota Assignment for Department
    run keyword     Check Quota Assignment is removed


Delete Quota
    set selenium timeout    25
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_delete_def}
    click button    ${btn_delete_def}

Reset Quota choice
    set selenium timeout    20
    wait until page contains element    ${chk_costcenter}
    click element     ${chk_costcenter}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${btn_save}
    click element       ${btn_save}

Set Disable Print
    set selenium timeout    20
    click button    ${btn_vary_ok}
    click button    ${btn_create_def}

    run keyword     Set Quota Assignment for Department
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

Set Quota Assignment for Department
    run keyword     Open Organisational Policy Page
    run keyword     Select Department or Personal
    run keyword     Open Quota Assignment Page
    set selenium timeout    20
    wait until page contains element    ${btn_assignquota}
    click button    ${btn_assignquota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_costcentername}
    click element   ${txt_costcentername}
    input text      ${txt_costcentername_input}       ${costcenter}
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

    element should contain      ${costcenter_name}      ${costcenter}
    click element       ${quota_name_link}

    run keyword     Check the table values
    #run keyword     Open Browser To Login Page using Admin
    run keyword     Open Quota Definition Page
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${dept_assignment_count}
    element should contain      ${dept_assignment_count}      1
    run keyword     Open Organisational Policy Page
    run keyword     Reset Quota choice
    run keyword     Open Quota Definition Page
    run keyword     Delete Quota


Check Quota Assignment is removed
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lbl_quotaassignment}
    click element       ${lbl_quotaassignment}
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain    ${noquotaassignment}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Check Header Text
    set selenium timeout    20
    ${iscolordisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}

    Run Keyword If  ${iscolordisable}  Open Browser To Login Page using non admin no color
    ...     ELSE    run keyword     Open Browser To Login Page using non admin normal


Check the table values
    set selenium timeout    20
    element text should be      ${monthly_total_id}   ${monthly_total_value}
    element text should be      ${monthly_color_id}   ${monthly_color_value}

    click button    ${btn_summary_close}
    sleep_call_1

    click element   ${name_printqueue}
    sleep_call_2

    ${isdisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${monthly_total_value}    ${totaldisable}
    #${iscolorcustom}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}


    Run Keyword If     ${isdisable}   Open Browser To Login Page using non admin disable
    ...     ELSE    run keyword     Check Header Text
########################################################################################################################


