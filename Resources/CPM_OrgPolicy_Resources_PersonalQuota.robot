*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_nonadmin}            automateuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0
${totalvalue}                   15
${colorvalue}                   20
${NULL}
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
    element text should be      ${header_quota_preview}     Quota remaining: Printing disabled
    click element   ${queue_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_search}
    click element   ${txt_search}
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
    input text      ${txt_search}     ${USER}
    sleep_call_2
    Press Keys    ${txt_search}    ENTER
####################################################################################################
###################################################################################################################

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

Select Personal
    set selenium timeout    20
    click element     ${radio_personal}
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

Open Quota Definition Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    createDefinitionButton

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

Reset Quota choice
    set selenium timeout    20
    wait until page contains element    ${chk_costcenter}
    click element     ${chk_costcenter}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Delete Quota
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible   ${btn_delete_def}
    click button    ${btn_delete_def}


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

    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${btn_create_quota}

    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}

    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${quota_interval}
    click element   ${quota_interval}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${month}
    click element     ${month}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${txt_quotaname}
    click element   ${txt_quotaname}
    click button        ${btn_monthly}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible       ${quota_total}
    click element   ${quota_total}

    #element attribute value should be   ${quota_total}   title   Disable all printing
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
    run keyword     Set Quota Assignment for Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    ${btn_quota_select_all}
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

    run keyword     Set Quota Assignment for Personal
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible    ${btn_quota_select_all}
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

Set Quota Assignment for Personal

    set selenium timeout    20
    run keyword     Open Organisational Policy Page
    run keyword     Select Personal
    run keyword     Open Quota Assignment Page
    sleep_call
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    #sleep_call
    #click element   ${tab_personal}
    #sleep_call
    set selenium timeout    25
    wait until page contains element    ${btn_assignquota}
    click button    ${btn_assignquota}
    sleep_call_2
    click element   ${txt_email}
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

    sleep_call
    #wait until element is visible   ${tbl_email_quota_name}
    element text should be      ${tbl_email_quota_name}    ${quota_name}

    click element       ${email_quota_link}
    sleep_call_1
    run keyword     Check the table values

    #run keyword     Open Browser To Login Page using Admin
    run keyword     Open Quota Definition Page
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${personal_assignment_count}
    element text should be      ${personal_assignment_count}      1
    sleep_call_2
    run keyword     Open Organisational Policy Page
    run keyword     Reset Quota choice
    run keyword     Open Quota Definition Page
    #run keyword     Delete Quota


##########################################################################################
Check Header Text Non Admin
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
    ...     ELSE    run keyword     Check Header Text Non Admin


Create a quota
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_create_quota}
    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ErrorQuota
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      definitionLimitsSelectControl-listbox-item-1
    click element   definitionLimitsSelectControl-listbox-item-1
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${lst_total_quota}
    click element   ${lst_total_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      definitionTotalSelectControl-listbox-item-3
    click element   definitionTotalSelectControl-listbox-item-3
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element      customRadioOption_radio_input
    click element   customRadioOption_radio_input

Set Total Value as 0
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      0
    click element   totalQuotaLabel
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible       monoQuotaLabelExceedsRange
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      1
    Wait Until Keyword Succeeds    35 sec    5 sec   element should be visible      totalQuotaLabel
    click element   totalQuotaLabel


Set Total Value as alphabet
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      a
    textfield value should be         ${txt_total_value}    ${EMPTY}
    click element   totalQuotaLabel

Set Total Value as Decimal
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      .1
    click element   totalQuotaLabel
    textfield value should be       ${txt_total_value}      1
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      1
    click element   totalQuotaLabel

Set Total Value as Characters
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      $
    textfield value should be         ${txt_total_value}    ${EMPTY}
    click element   totalQuotaLabel

Set Total Value as -1
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      -1
    click element   totalQuotaLabel
    element should be visible       monoQuotaLabelExceedsRange
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      1
    click element   totalQuotaLabel

Set Color Value as 0
    set selenium timeout    20
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      0
    click element   totalQuotaLabel
    element should be visible       colorQuotaLabelExceedsRange
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      1
    click element   totalQuotaLabel

Set Color Value as -1
    set selenium timeout    20
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      -1
    click element   totalQuotaLabel
    element should be visible       colorQuotaLabelExceedsRange
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      1
    click element   totalQuotaLabel

Set Color Value as alphabet
    set selenium timeout    20
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      a
    textfield value should be         ${txt_color_value}    ${EMPTY}
    click element   totalQuotaLabel

Set Color Value as Decimal
    set selenium timeout    20
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      .1
    textfield value should be       ${txt_total_value}      1
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      1
    click element   totalQuotaLabel

Set Color Value as Characters
    set selenium timeout    20
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      $
    textfield value should be         ${txt_color_value}    ${EMPTY}
    click element   totalQuotaLabel

Set Total Value less than Color Value
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      ${totalvalue}
    click element   totalQuotaLabel
    element text should be      colorQuotaLabelDescription      Color printing limit range: 1 - ${totalvalue}.
    click element   ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      ${colorvalue}
    click element   totalQuotaLabel
    textfield value should be       ${txt_color_value}      ${totalvalue}

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
########################################################################################################################


