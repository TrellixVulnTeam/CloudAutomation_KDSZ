*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/MAC_Default_Package.xlsx
Library     ../ChromeExtension/CloudLogin.py
Library     ../Email/Printerautomation.py
Library     ../ClientDownload/XMLParser.py
#Suite Setup     Open Browser To Login Page
Test Template   Download MAC Default Packages
Suite Teardown     Log out

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${CPM_URL}                      https://qa.us.iss.lexmark.com/cpm

*** Test Cases ***
Verify Default Client Download packge for MAC ${NAME}


*** Keywords ***
#Open Browser To Login Page
Download MAC Default Packages
    Open Browser    ${URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    sleep_call
#Dashboard Should Open
#Change security preferences to allow EXE downloads
    go to   chrome://settings/security
    sleep_call_2

#Navigate to Standard Security Policy
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB

    sleep_call_2
    Press Keys    None      ARROW_UP
    sleep_call_2

#OPen Dashboard
   go to   ${URL}

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-10"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call


#Check Client Download Tab opens and check Text
    Wait until Element Is Visible   id:link-navClientDownload
    Click Element   id:link-navClientDownload
    Wait until Element Is Visible   xpath://*[@id="clientDownloadPageHeader"]/div[1]/h2
    sleep_call

#Download MAC Default Packages
    [Arguments]        ${NAME}     ${LINK}      ${PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait until page contains element    ${LINK}
    click element   ${LINK}

#Click Download button
    sleep_call_2
    click button    ${download_btn}
    sleep_call_2
    sleep_call
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    sleep_call_2
    ${download_flag}=   download_wait   ${PACKAGE NAME}
    log     ${download_flag}
    sleep_call
    sleep_call
    delete_file     ${PACKAGE NAME}

Log out
    sleep_call
    close all browsers

###################################################################################################################


