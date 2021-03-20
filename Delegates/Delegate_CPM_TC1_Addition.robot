*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_Delegate_Resources.robot
Library     DataDriver  ../TestData/Delegate_ValidDuplicate.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Multiple Delegates
Suite Teardown     Log out

*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${EMAIL USER}                   user_pallabi@test.onelxk.co


*** Test Cases ***
Delegate addition using ${EMAIL USER}


*** Keywords ***
Multiple Delegates
    [Arguments]     ${EMAIL USER}
    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}

###################################################################