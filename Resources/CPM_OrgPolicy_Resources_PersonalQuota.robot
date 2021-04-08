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
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
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

Open Browser To Login Page using non admin
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm_nonadmin}
    sleep_call_2
    Click Element   ${lnk_cpm_nonadmin}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call

Open Browser To Login Page using non admin disable
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm_quotauser}
    sleep_call_2
    Click Element   ${lnk_cpm_quotauser}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    element text should be      ${header_quota_preview}     Quota remaining: Printing disabled
    close all browsers

Open Browser To Login Page using non admin no color
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm_quotauser}
    sleep_call_2
    Click Element   ${lnk_cpm_quotauser}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (no color printing)
    close all browsers

Open Browser To Login Page using non admin normal
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm_quotauser}
    sleep_call_2
    Click Element   ${lnk_cpm_quotauser}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)
    close all browsers
####################################################################################################
    ################QUOTA###########################


Log out
    set selenium timeout    20
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################


Select Personal
    set selenium timeout    20
    click element     ${radio_personal}
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

Open Quota Definition Page
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotadefinition}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Open Browser and Quota Page
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotadefinition}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Reset Quota choice
    set selenium timeout    20
    wait until page contains element    ${chk_costcenter}
    click element     ${chk_costcenter}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Delete Quota
    sleep_call
    set selenium timeout    25
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    sleep_call_2
    click button    ${btn_delete_def}
    sleep_call


Create Custom quota vary
    sleep_call
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

    wait until page contains element  ${btn_create_quota}

    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
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
    #element attribute value should be   ${quota_total}   title   Disable all printing
    ${is_disable}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Disable all printing
    ${is_custom}=     run keyword and return status   element attribute value should be   ${quota_total}   title   Set custom quota
    run keyword if  ${is_disable}      Set Disable Print
    ...     ELSE IF    ${is_custom}      Set Custom Total
    ...     ELSE    Set Color Controls


Set Color Controls
    set selenium timeout    20
    sleep_call_2
    click element   ${quota_color}
    sleep_call_2
    ${custom_color}=     run keyword and return status   element attribute value should be       ${radio_customcolor}    aria-checked    true
    run keyword if  ${custom_color}   Set Custom Color

    click button    ${btn_vary_ok}
    sleep_call_1
    click button    ${btn_create_def}
    sleep_call
    sleep_call

    run keyword     Set Quota Assignment for Personal
    run keyword     Delete Quota
    run keyword     Check Quota Assignment is removed
    run keyword     Open Organisational Policy Page
    run keyword     Reset Quota choice
    run keyword     Open Quota Definition Page

Set Disable Print
    set selenium timeout    20
    click button    ${btn_vary_ok}
    sleep_call_1
    click button    ${btn_create_def}
    sleep_call
    sleep_call

    run keyword     Set Quota Assignment for Personal
    run keyword     Delete Quota
    run keyword     Check Quota Assignment is removed
    run keyword     Open Organisational Policy Page
    run keyword     Reset Quota choice
    run keyword     Open Quota Definition Page

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
    set selenium timeout    20
    sleep_call_1
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    sleep_call_2
    page should contain    ${noquotaassignment}
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Check Header Text
    set selenium timeout    20
    ${iscolordisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}
    Run Keyword If  ${iscolordisable}  element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (no color printing)

    ...     ELSE    run keyword        element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)

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

    run keyword     Open Browser To Login Page using Admin
    run keyword     Open Organisational Policy Page
    run keyword     Open Quota Definition Page


    element text should be      ${personal_assignment_count}      1
    sleep_call_2

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
    sleep_call_1

    click element   ${name_printqueue}
    sleep_call_2

    ${isdisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${monthly_total_value}    ${totaldisable}
    #${iscolorcustom}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}


    Run Keyword If     ${isdisable}   Open Browser To Login Page using non admin disable
    ...     ELSE    run keyword     Check Header Text Non Admin


Create a quota
    set selenium timeout    20
    sleep_call
    sleep_call
    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ErrorQuota
    click element   ${lst_quotalimit}
    sleep_call_1
    click element   definitionLimitsSelectControl-listbox-item-1
    sleep_call_1
    click element   ${lst_total_quota}
    sleep_call_1
    click element   definitionTotalSelectControl-listbox-item-3
    sleep_call_1
    click element   customRadioOption_radio_input

Set Total Value as 0
    set selenium timeout    20
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      0
    click element   totalQuotaLabel
    element should be visible       monoQuotaLabelExceedsRange
    press keys      ${txt_total_value}      \DELETE
    input text      ${txt_total_value}      1
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
    sleep_call_1
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
    sleep_call_2
    textfield value should be       ${txt_color_value}      ${totalvalue}
########################################################################################################################


