*** Settings ***
Library  SeleniumLibrary
#Library     DataDriver  ../TestData/FileUpload_Data.xlsx
Library     CloudLogin.py
#Suite Setup     Open Browser To Login Page
#Test Template   Change Default Settings
#Suite Teardown     Verify deletion of jobs

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co
${BROWSER}                      headlessChrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${tab1name}                     Print Queue
${tab2name}                     Delegates
${tab3name}                     Print Job History
${tab4name}                     Download Print Management Client
${next}                         Next
${login}                        Log In
${id}
${job_name_actual}              defect_trend.jpg
${job_status_actual}            Ready
${job_color_actual}             Black and white
${job_duplex_actual}            On (long edge)
${job_nup_actual}               3
${job_copies_actual}            15
${default_title_actual}         Set Default Print Settings
${delete_dlg_title_actual}      Delete Print Jobs


*** Test Cases ***
LoginTest
    Open Browser To Login Page
    Maximise Browser
    Check Copyright in Login
    Check Username field is enabled and displayed
    Input Username      ${username}
    Verify Next Button is enabled and verify value
    Click Next button
    Check Password field is enabled and displayed
    Input Password      ${password}
    Verify Login Button is enabled and verify value
    Click Login Button
    Dashboard Should Open
    Logout

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}

Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

Check Copyright in Login
    Element Text Should Be      xpath:/html/body/div/div[2]/section/div[2]/div/p     ${loginyear}

Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    element should be enabled   ${username_text}
    element should be visible   ${username_text}
    ${password_text}    set variable    id:user_password
    element should not be visible   ${password_text}

Input Username
    [Arguments]    ${username}
    Input Text    id:user_email    ${username}

Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next
    element should be enabled   ${nextbtn}
    element should be visible   ${nextbtn}
    element attribute value should be   ${nextbtn}     value   ${next}

Click Next button
    Click Button    btn-email-next

Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password
    element should be enabled   ${password_text}
    element should be visible   ${password_text}

Input Password
    [Arguments]    ${password}
    Input Text    id:user_password    ${password}

Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login
    element should be enabled   ${loginbtn}
    element should be visible   ${loginbtn}
    element attribute value should be   ${loginbtn}     value   ${login}

Click Login Button
    Click Button    btn-email-login

Dashboard Should Open
    Title Should Be     Dashboard | Lexmark Cloud Services
    sleep_call

Logout
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers