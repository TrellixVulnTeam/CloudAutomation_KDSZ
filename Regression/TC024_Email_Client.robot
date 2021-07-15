*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_Email_Resources.robot
Library     DataDriver  ../TestData/Email.xlsx
Suite Setup     Open Browser To Login Page
Test Template   Email submission
Suite Teardown     Log out
Force Tags      Email Client


*** Test Cases ***
Email submission with different file using ${FILENAME}

*** Keyword ***
Email submission
    [Arguments]         ${IP}   ${PIN}  ${FILENAME}
    Email submission with  ${IP}   ${PIN}  ${FILENAME}


###################################################################