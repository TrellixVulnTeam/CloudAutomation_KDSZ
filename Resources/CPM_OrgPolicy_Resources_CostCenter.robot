*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Firefox
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_nonadmin}            testuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0

*** Keywords ***
Open Browser To Login Page using Admin
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
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${org_policy}
    sleep_call_2
    click element       ${org_policy}
    wait until page contains element       ${page_header}
    sleep_call_2

Check default state of client download
    element attribute value should be       ${chk_clientdownload}       aria-checked    true

Uncheck Enable Client Download
    unselect checkbox       ${chk_clientdownload}
    click element       ${btn_save}
    sleep_call

Check new state of client download
    element attribute value should be       ${chk_clientdownload}       aria-checked    false


Open Browser To Login Page using non admin
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

####################################################################################################
    ################CLIENT DOWNLOAD###########################
Check Client Download
    select checkbox       ${chk_clientdownload}
    click element       ${btn_save}
    sleep_call

Check client download tab is visible for non admin
    page should contain element         ${tab_clientdownload}
    click element       ${tab_clientdownload}
    sleep_call_2
    wait until page contains element        ${header_clientdownload}
    element should not be visible     ${lnk_customwin}
    element should not be visible     ${lnk_custommac}

Check client download tab is not visible for non admin
    page should not contain element         ${tab_clientdownload}

Reset Client Download
    select checkbox       ${chk_clientdownload}
    click element       ${btn_save}
    sleep_call

####################################################################################################
    ################DELEGATES###########################
Check default state of delegates
    element attribute value should be       ${chk_delegates}       aria-checked    false

Check delegate tab is not visible
    page should not contain element     ${lbl_delegate}

Enable Delegate
    select checkbox    ${chk_delegates}
    click element       ${btn_save}
    sleep_call
    element attribute value should be       ${chk_delegates}       aria-checked    true



Check delegate tab is visible
    page should contain element     ${lbl_delegate}
    click element   ${lbl_delegate}
    wait until page contains element        ${header_delegate}

Reset Delegate feature
    unselect checkbox    ${chk_delegates}
    click element       ${btn_save}
    sleep_call

####################################################################################################
    ################EMAIL###########################
Check default state of email
    element attribute value should be       ${chk_email}       aria-checked    false

Check email header is not visible
    click element       ${name_printqueue}
    sleep_call
    page should not contain element     ${header_email}

Enable Email
    select checkbox    ${chk_email}
    click element       ${btn_save}
    element attribute value should be       ${chk_email}       aria-checked    true
    sleep_call

Check email header is present
    click element       ${name_printqueue}
    sleep_call
    page should contain element     ${header_email}
    page should contain           ${email_text}

Reset Email feature
    unselect checkbox    ${chk_email}
    click element       ${btn_save}
    sleep_call

####################################################################################################
    ################QUOTA###########################
Check default state of quota
    element attribute value should be       ${chk_quota}        aria-checked    false
    element should be disabled      ${radio_costcenter}
    element should be disabled      ${radio_dept}
    element should be disabled      ${radio_personal}
    sleep_call_2
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    element should not be visible   lbl_quotadefinition
    element should not be visible   lbl_quotaassignment
    element should not be visible   lbl_quotastatus

Enable Quota
    select checkbox     ${chk_quota}
    click element       ${btn_save}
    sleep_call

Check Quota feature controls
    element attribute value should be       ${chk_quota}        aria-checked    true
    element should be enabled      ${radio_costcenter}
    element attribute value should be       ${radio_costcenter}     aria-checked    true
    element attribute value should be       ${radio_dept}     aria-checked    false
    element attribute value should be       ${radio_personal}     aria-checked    false
    element should be enabled      ${radio_dept}
    element should be enabled      ${radio_personal}
    sleep_call_2
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    sleep_call
    element should be visible   ${lbl_quotadefinition}
    element should be visible   ${lbl_quotaassignment}
    element should be visible   ${lbl_quotastatus}

Reset Quota
    unselect checkbox   ${chk_quota}
    click element       ${btn_save}
    sleep_call

Log Out Non admin
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers

Log out
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers
###################################################################################################################

Select Cost Center or Personal
    select checkbox     ${chk_costcenter}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Reset to Cost Center or Personal and uncheck quota
    click element     ${chk_costcenter}
    sleep_call_2
    unselect checkbox       ${chk_quota}
    click element       ${btn_save}
    sleep_call

Open Quota Assignment Page
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotaassignment}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    sleep_call_2

Check whether cost center and personal tab is displayed
    element should be visible       ${tab_costcenter}
    element attribute value should be       ${tab_costcenter}       title       Cost Center
    element should be enabled       ${tab_personal}
    element attribute value should be       ${tab_personal}       title       Personal

Select Department or Personal
    click element     ${radio_dept}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call

Select Personal
    click element     ${radio_personal}
    wait until page contains element        ${btn_confirmchange}
    click element       ${btn_confirmchange}
    sleep_call_2
    click element       ${btn_save}
    sleep_call


Check whether department and personal tab is displayed
    element should be visible       ${tab_costcenter}
    element attribute value should be       ${tab_costcenter}       title       Department
    element should be enabled       ${tab_personal}
    element attribute value should be       ${tab_personal}       title       Personal

Check whether no tab is displayed
    element should not be visible       ${tab_costcenter}
    element should not be visible       ${tab_personal}

Open Quota Definition Page
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${lbl_quotadefinition}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Check default quota definition
    click element   ${icon_definition}
    sleep_call
    page should contain     Quota interval
    page should contain     Total Quota (Color + B&W)
    page should contain     Color printing limit
    element text should be      ${quota_interval_value}       Monthly
    element text should be      ${total_quota_value}       Unlimited
    element text should be      ${bw_quota_value}       Unlimited
    sleep_call_2
    click button       ${btn_default}
    sleep_call_2
    element text should be      ${quota_limit}        Same limits for each month
    element text should be      ${total_quota}        Allow unlimited printing
    element attribute value should be       ${radio_unlimited}     aria-checked        true
    click button        ${btn_cancel_changes}

Open Browser and Quota Page
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


Create Custom quota monthly
    sleep_call
    [Arguments]        ${quota_name}     ${quota_interval}      ${quota_total}      ${quota_color}  ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}
    Set Global Variable   ${quota_color_value}
    Set Global Variable   ${quota_color}

    Set Global Variable   ${quota_name}
    Set Global Variable   ${quota_interval_value}
    Set Global Variable   ${quota_total_value}


    sleep_call
    sleep_call
    click element    ${btn_create_quota}
    sleep_call_2
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
    click element   ${lst_quotalimit}
    sleep_call_1
    click element   ${quota_interval}
    sleep_call_1
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


Create Custom quota vary
    sleep_call
    [Arguments]        ${quota_name}     ${quota_interval}     ${month}      ${quota_total}      ${quota_color}  ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}     ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}

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

    sleep_call
    sleep_call
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

    run keyword     Set Quota Assignment for Cost Center
    sleep_call
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    sleep_call_2
    click button    ${btn_delete_def}
    sleep_call
    run keyword     Check Quota Assignment is removed

Set Disable Print
    click button    ${btn_vary_ok}
    sleep_call_1
    click button    ${btn_create_def}
    sleep_call
    sleep_call

    run keyword     Set Quota Assignment for Cost Center
    sleep_call
    set selenium timeout    20
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    sleep_call_2
    click button    ${btn_delete_def}
    sleep_call

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
    set selenium timeout    20
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    wait until page contains element    ${org_policy}
    sleep_call_2
    click element       ${org_policy}
    wait until page contains element       ${page_header}
    sleep_call_2
    click element   ${chk_costcenter}
    click button    ${btn_save}
    sleep_call_2
    wait until element is visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    sleep_call
    sleep_call
    #Assign Quota by Cost Center
    set selenium timeout    20
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
    sleep_call_1

    run keyword     Check the table values

    element text should be      ${costcenter_assignment_count}      1
    sleep_call_2

Check Quota Assignment is removed
    sleep_call_1
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotaassignment}
    sleep_call_2
    set selenium timeout    20
    wait until page contains element    ${noquotaassignment}
    page should contain    ${noquotaassignment}
    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call_2

Check Header Text
    ${iscolordisable}=    Run Keyword And Return Status    Should Be Equal As Strings    ${quota_color_value}    ${totaldisable}
    Run Keyword If  ${iscolordisable}  element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (no color printing)

    ...     ELSE    run keyword        element text should be      ${header_quota_preview}     Quota remaining: ${monthly_total_value} total quota (${monthly_color_value} for color printing)

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


    Run Keyword If     ${isdisable}    element text should be      ${header_quota_preview}     Quota remaining: Printing disabled
    ...     ELSE    run keyword     Check Header Text


    click element       ${admin_dropdown}
    sleep_call_2
    click element       ${lbl_quotadefinition}
    sleep_call
########################################################################################################################


