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

Check Delegate feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Reset Client Download
    Check default state of delegates
    Check delegate tab is not visible
    Enable Delegate
    Check delegate tab is visible
    Open Organisational Policy Page
    Reset Delegate feature

Check Email feature
    Check default state of email
    Check email header is not visible
    Open Organisational Policy Page
    Enable Email
    Check email header is present
    Open Organisational Policy Page
    Reset Email feature

Check Quota feature
    check default state of quota
    Enable Quota
    Check Quota feature controls
    Reset Quota
###################################################################