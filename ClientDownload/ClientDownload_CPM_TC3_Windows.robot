*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/Win_Default_Package.xlsx
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/XMLParser.py
Variables    ../PageObjects/Locators.py
#Suite Setup     Open Browser To Login Page
Test Template   Download Default Packages for Windows
Suite Teardown     Log out

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Edge
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234

*** Test Cases ***
Verify Default Client Download packge for Windows ${NAME}


*** Keywords ***
#Open Browser To Login Page
Download Default Packages for Windows
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

#Download Default Packages for Windows
    [Arguments]        ${NAME}     ${LINK}      ${PACKAGE NAME}

    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType

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


