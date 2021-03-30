*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_OrgPolicy_Resources.robot


*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${EMAIL USER}                   user_pallabi@test.onelxk.co


*** Test Cases ***
Check Enable Client Download Feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of client download
    Log out
    Open Browser To Login Page using non admin
    Check client download tab is visible for non admin
    Log Out Non admin
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Uncheck Enable Client Download
    Check new state of client download
    Log out
    Open Browser To Login Page using non admin
    Check client download tab is not visible for non admin
    Log Out Non admin

Check Login
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check Client Download


###################################################################