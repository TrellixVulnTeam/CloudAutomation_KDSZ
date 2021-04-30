*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py


*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Keywords ***
Open Browser To Login Page
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

Check Adding Valid and Duplicate Delegates
   [Arguments]        ${EMAIL USER}
    set selenium timeout    20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lbl_delegate}
    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${txt_delegate}
    page should contain     No data available

    element should be enabled   ${btn_delegate_add}
    element should be visible   ${btn_delegate_add}
    element should be disabled  ${btn_delegate_remove}

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${dlg_btn_delegate_add}
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lst_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should contain     ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element text should be      ${lst_table_entry}      ${EMAIL USER}

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${dlg_btn_delegate_add}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible   ${lst_delegate}
    element should contain      ${lst_delegate}       ${EMAIL USER}
    Press Keys    ${lst_delegate}    ENTER
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be disabled     ${dlg_btn_delegate_add}
    page should contain      Delegate already exists
    click button    ${dlg_btn_delegate_cancel}

    element should be disabled      ${btn_delegate_remove}
    ${dummy_click}      set variable        delegatesBreadcrumb
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${chk_delegate_delete}
    click element     ${chk_delegate_delete}
    click element   ${dummy_click}
    element should be enabled      ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element     ${btn_delegate_remove}
    click button    ${btn_delegate_remove}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be enabled     ${btn_discard_ok}

    click button    ${btn_delegate_delete_ok}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible     ${lst_table_entry}

Check Adding Invalid Delegates
   [Arguments]        ${EMAIL USER}
    set selenium timeout     20
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${lbl_delegate}
    click element   ${lbl_delegate}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${txt_delegate}
    page should contain     No data available

    click element   ${btn_delegate_add}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${dlg_btn_delegate_add}
    element should be disabled  ${dlg_btn_delegate_add}
    element should be enabled   ${dlg_btn_delegate_cancel}
    click element   ${txt_delegate_email}
    input text      ${txt_delegate_input}    ${EMAIL USER}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should not be visible   ${lst_delegate}
    element should be disabled   ${dlg_btn_delegate_add}
    click button    ${dlg_btn_delegate_cancel}

Log out
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers
###################################################################################################################


