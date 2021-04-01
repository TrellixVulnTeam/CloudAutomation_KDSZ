*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py

*** Variables ***
${URL}                          https://dev.us.cloud.onelxk.co/
${BROWSER}                      headlessChrome
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
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_blank}
    sleep_call_2
    Click Button    ${btn_next}
    sleep_call_2
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Invalid user name login verification
    [Arguments]    ${username_invalid}
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username_invalid}
    sleep_call_2
    Click Button    ${btn_next}
    sleep_call_2
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_user_text}
    close browser

Open CPM Portal and Blank password verification
    [Arguments]    ${username}      ${password_blank}
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    Click Button    ${btn_next}
    sleep_call_1
    Input Text    ${txt_password}   ${password_blank}
    Click Button    ${btn_login}
    sleep_call_1
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

Open CPM Portal and Invalid password verification
    [Arguments]    ${username}      ${password_invalid}
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    Click Button    ${btn_next}
    sleep_call_1
    Input Text    ${txt_password}   ${password_invalid}
    sleep_call_1
    Click Button    ${btn_login}
    sleep_call_1
    page should contain element     ${lbl_errormessage}
    element text should be      ${lbl_errormessage}      ${invalid_password_text}
    close browser

Open CPM portal and Login Verification
    [Arguments]    ${username}      ${password}
    Open Browser    ${URL}    ${BROWSER}
    wait until page contains    E-mail
    Maximize Browser Window
    Title Should Be     ${PORTAL TITLE}
    Element Text Should Be      ${txt_lgnyear}     ${loginyear}
    element should be enabled   ${txt_username}
    element should be visible   ${txt_username}
    element should not be visible   ${txt_password}
    Input Text    ${txt_username}   ${username}
    sleep_call_1
    element should be enabled   ${btn_next}
    element should be visible   ${btn_next}
    element attribute value should be   ${btn_next}     value   ${next}
    Click Button    ${btn_next}
    element should be enabled   ${txt_password}
    element should be visible   ${txt_password}
    Input Text    ${txt_password}   ${password}
    sleep_call_1
    element should be enabled   ${btn_login}
    element should be visible   ${btn_login}
    element attribute value should be   ${btn_login}     value   ${login}
    Click Button    ${btn_login}
    sleep_call

Dashboard Should Open
    wait until page contains    Cloud Services Home
    Title Should Be     Dashboard | Lexmark Cloud Services
    sleep_call

Logout
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers