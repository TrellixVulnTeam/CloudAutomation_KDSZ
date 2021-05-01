*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_nonadmin}            simpleuser@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.

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
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${admin_dropdown}
    click element       ${admin_dropdown}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element   ${lbl_quotadefinition}
    click element       ${lbl_quotadefinition}

Create Custom quota monthly
    [Arguments]        ${quota_name}     ${quota_interval}      ${quota_total}      ${quota_color}  ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}
    set selenium timeout    20
    Set Global Variable   ${quota_color_value}
    Set Global Variable   ${quota_color}

    Set Global Variable   ${quota_name}
    Set Global Variable   ${quota_interval_value}
    Set Global Variable   ${quota_total_value}

    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_quota}

    click element    ${btn_create_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_quotaname}
    clear element text  ${txt_quotaname}
    input text      ${txt_quotaname}        ${quota_name}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${lst_quotalimit}
    click element   ${lst_quotalimit}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${quota_interval}
    click element   ${quota_interval}
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
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${quota_color}
    click element   ${quota_color}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element    ${radio_customcolor}
    ${custom_color}=     run keyword and return status   element attribute value should be       ${radio_customcolor}    aria-checked    true
    run keyword if  ${custom_color}   Set Custom Color
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_def}
    click button    ${btn_create_def}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_namme}      ${quota_name}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_interval}      ${quota_interval_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_total}      ${quota_total_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_color}      ${quota_color_value}

    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_delete_def}
    click button    ${btn_delete_def}


Set Disable Print
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_create_def}
    click button    ${btn_create_def}

    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_namme}      ${quota_name}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_interval}      ${quota_interval_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_total}      ${quota_total_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element text should be      ${lst_new_quota_color}      ${quota_color_value}


    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_quota_select_all}
    wait until page contains element     ${btn_quota_select_all}
    click element       ${btn_quota_select_all}
    click element   ${undefined}
    click button    ${btn_delete_quota}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${btn_delete_def}
    click button    ${btn_delete_def}


Set Custom Color
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_color_value}
    click element   ${txt_color_value}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_color_value}
    press keys      ${txt_color_value}      \DELETE
    input text      ${txt_color_value}      ${quota_color_value}

Set Custom Total
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible    ${txt_total_value}
    click element   ${txt_total_value}
    press keys      ${txt_total_value}      \DELETE
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
