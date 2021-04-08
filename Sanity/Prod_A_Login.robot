*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_LoginPage_resources.robot

*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_blank}
${username_invalid}             sravantesh@lexmark.com
${password_blank}
${password_invalid}             Password@12345

*** Test Cases ***
Correct Login verification
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Logout from portal
    Logout

###################################################################