*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
#Resource     ../Resources/CPM_LoginPage_resources.robot
Resource     ../Resources/Master.robot


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_blank}
${username_invalid}             sravantesh@lexmark.com
${password_blank}
${password_invalid}             Password@12345
${EMAIL USER}                   user_pallabi@test.onelxk.co
${FILENAME}                     Attachment.txt

*** Test Cases ***
Correct Login verification
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Logout from portal
    Logout
Delegate addition using ${EMAIL USER}
    [Arguments]     ${EMAIL USER}
    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}
Mobile Job Submission
    Open Browser To Login Page
    Mobile submission
    Log out
Email submission with different file using ${FILENAME}
    [Arguments]         ${FILENAME}
    Email submission with  ${FILENAME}

###################################################################