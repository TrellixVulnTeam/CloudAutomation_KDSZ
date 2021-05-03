*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_LoginPage_resources.robot

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${username_blank}
${username_invalid}             sravantesh@lexmark.com
${password_blank}
${password_invalid}             Password@12345

*** Test Cases ***
Blank User Name verification
    Open CPM Portal and Blank user name login verification        ${username_blank}
Invalid User Name verification
    Open CPM Portal and Invalid user name login verification      ${username_invalid}
Blank Password verification
    Open CPM Portal and Blank password verification      ${USER}     ${password_blank}
Invalid Password verification
    Open CPM Portal and Invalid password verification      ${USER}     ${password_invalid}
Correct Login verification
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Logout from portal
    Logout

###################################################################