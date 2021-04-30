*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py

*** Variables ***
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${next}                         Next
${login}                        Log In
${PORTAL TITLE}                 Lexmark Log In
${invalid_password_text}        Invalid password.
${invalid_user_text}            Invalid Username or Email.


*** Keywords ***


Open CPM Portal and Blank user name login verification

    [Arguments]    ${username_blank}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_blank}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_next}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element     ${lbl_errormessage}
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Invalid user name login verification
    [Arguments]    ${username_invalid}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_invalid}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_next}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element      ${lbl_errormessage}
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Blank password verification
    [Arguments]    ${username}      ${password_blank}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_next}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_password}
    Input Text    ${txt_password}   ${password_blank}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element      ${lbl_errormessage}
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

Open CPM Portal and Invalid password verification
    [Arguments]    ${username}      ${password_invalid}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_next}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_password}
    Input Text    ${txt_password}   ${password_invalid}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_login}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain element      ${lbl_errormessage}
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

Open CPM portal and Login Verification
    [Arguments]    ${username}      ${password}
    set selenium timeout    20
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Title Should Be     ${PORTAL TITLE}
    Element Text Should Be      ${txt_lgnyear}     ${loginyear}
    element should be enabled   ${txt_username}
    element should be visible   ${txt_username}
    element should not be visible   ${txt_password}
    Input Text    ${txt_username}   ${username}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_next}
    element should be enabled   ${btn_next}
    element should be visible   ${btn_next}
    element attribute value should be   ${btn_next}     value   ${next}
    Click Button    ${btn_next}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${txt_password}
    element should be enabled   ${txt_password}
    element should be visible   ${txt_password}
    Input Text    ${txt_password}   ${password}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${btn_login}
    element should be enabled   ${btn_login}
    element should be visible   ${btn_login}
    element attribute value should be   ${btn_login}     value   ${login}
    Click Button    ${btn_login}


Dashboard Should Open
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    Title Should Be     Dashboard | Lexmark Cloud Services

Logout
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers