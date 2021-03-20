*** Settings ***
Library  SeleniumLibrary
Library     ../ChromeExtension/ChromeExtension.py
Library     ../ChromeExtension/CloudLogin.py
Library     ../Email/send_email.py
Library     Printerautomation.py
Resource     ../Resources/CPM_Email_Resources.robot
Library     DataDriver  ../TestData/Email.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Email submission
Suite Teardown     Log out


*** Test Cases ***
Email submission with different file using ${FILENAME}

*** Keyword ***
Email submission
    [Arguments]         ${FILENAME}
    Email submission with  ${FILENAME}


###################################################################