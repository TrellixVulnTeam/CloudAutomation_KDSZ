*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_Delegate_Resources.robot
Library     DataDriver  ../TestData/Delegate_Invalid.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Invalid Delegates
Suite Teardown     Log out


*** Test Cases ***
Delegate addition with ${TYPE} : ${EMAIL USER}


*** Keywords ***
Invalid Delegates
    [Arguments]     ${EMAIL USER}
    Check Adding Invalid Delegates      ${EMAIL USER}

###################################################################