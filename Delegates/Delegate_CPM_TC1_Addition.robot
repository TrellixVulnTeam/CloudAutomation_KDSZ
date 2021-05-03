*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_Delegate_Resources.robot
Library     DataDriver  ../TestData/Delegate_ValidDuplicate.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Multiple Delegates
Suite Teardown     Log out

*** Variables ***
${EMAIL USER}                   user_pallabi@test.onelxk.co


*** Test Cases ***
Delegate addition using ${EMAIL USER}


*** Keywords ***
Multiple Delegates
    [Arguments]     ${EMAIL USER}
    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}

###################################################################