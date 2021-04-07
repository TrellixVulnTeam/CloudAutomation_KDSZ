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
#Blank User Name verification
#    Open CPM Portal and Blank user name login verification        ${username_blank}
#Invalid User Name verification
#    Open CPM Portal and Invalid user name login verification      ${username_invalid}
#Blank Password verification
#    Open CPM Portal and Blank password verification      ${USER}     ${password_blank}
#Invalid Password verification
#    Open CPM Portal and Invalid password verification      ${USER}     ${password_invalid}
Correct Login verification
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Logout from portal
    Logout

###################################################################