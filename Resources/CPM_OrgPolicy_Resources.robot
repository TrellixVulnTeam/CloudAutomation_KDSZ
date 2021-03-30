*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${username_nonadmin}            simpleuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.

*** Keywords ***
Open Browser To Login Page using Admin
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
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
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username_nonadmin}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
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


