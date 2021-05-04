*** Settings ***
Library  SeleniumLibrary
#Library     DataDriver  ../TestData/Win_Default_Package.xlsx
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/XMLParser.py
Variables    ../PageObjects/Locators.py
#Suite Setup     Open Browser To Login Page
#Test Template   Download Default Packages for Windows
#Suite Teardown     Log out

*** Variables ***
#${URL}                    https://dev.eu.cloud.onelxk.co/
#${DOWNLOADBROWSER}                      Edge
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234

*** Test Cases ***
Download Default Packages for Windows SAAS
    Open Browser To Login Page
    Download Default Windows SAAS Package
Download Default Packages for Windows Hybrid
    Open Browser To Login Page
    Download Default Windows Hybrid Package


*** Keywords ***
Open Browser To Login Page
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



Download Default Windows SAAS Package
    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType
    click element   ${download_list}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    windowsPackageType-listbox-item-default
    sleep_call_1
    click element   windowsPackageType-listbox-item-default


    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}

    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_win_saas   ${URL}
    log     ${download_flag}
    #delete_file     ${PACKAGE NAME}
    close browser

Download Default Windows Hybrid Package
    ${download_btn}     set variable    win_download_btn
    ${download_list}    set variable    windowsPackageType
    click element   ${download_list}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain element    windowsPackageType-listbox-item-serverless
    sleep_call_1
    click element   windowsPackageType-listbox-item-serverless


#Click Download button
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${download_btn}
    click button    ${download_btn}

    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    click element   ${logout}

#PageObjects Python script to confirm correct file has been downloaded
    ${download_flag}=   download_wait_win_hybrid   ${URL}
    log     ${download_flag}
    #delete_file     ${PACKAGE NAME}
    #close browser


###################################################################################################################


