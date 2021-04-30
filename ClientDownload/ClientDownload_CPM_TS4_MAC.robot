*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/MAC_Default_Package.xlsx
Library     ../ChromeExtension/CloudLogin.py
Library     ../Email/Printerautomation.py
Library     ../ClientDownload/XMLParser.py
Variables    ../PageObjects/Locators.py
#Suite Setup     Open Browser To Login Page
Test Template   Download MAC Default Packages
Suite Teardown     Log out

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Edge
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${CPM_URL}                      https://qa.us.iss.lexmark.com/cpm

*** Test Cases ***
Verify Default Client Download packge for MAC ${NAME}


*** Keywords ***
#Open Browser To Login Page
Download MAC Default Packages
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password
    Input Text    id:user_email    ${USER}
    ${nextbtn}  set variable    btn-email-next
    Click Button    btn-email-next
    ${password_text}    set variable    id:user_password
    Input Text    id:user_password    ${PASSWORD}
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${tab_clientdownload}
    #Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     createCustomPackageWindows

#Download MAC Default Packages
    [Arguments]        ${NAME}     ${LINK}      ${PACKAGE NAME}

    ${download_btn}     set variable    mac_download_btn
    ${download_list}    set variable    macPackageType

    click element   ${download_list}
    wait until page contains element    ${LINK}
    click element   ${LINK}

#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait   ${PACKAGE NAME}
    log     ${download_flag}
    delete_file     ${PACKAGE NAME}

Log out
    close all browsers

###################################################################################################################


