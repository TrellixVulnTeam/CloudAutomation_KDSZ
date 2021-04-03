*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_OrgPolicy_Resources_CostCenter.robot


*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Test Cases ***
Check Enable Client Download Feature
    Open Browser To Login Page using Admin
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Check default state of client download
    sleep_call_2
    Log out
    sleep_call_2
    Open Browser To Login Page using non admin
    sleep_call_2
    Check client download tab is visible for non admin
    sleep_call_2
    Log Out Non admin
    sleep_call_2
    Open Browser To Login Page using Admin
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Uncheck Enable Client Download
    sleep_call_2
    Check new state of client download
    sleep_call_2
    Log out
    sleep_call_2
    Open Browser To Login Page using non admin
    sleep_call_2
    Check client download tab is not visible for non admin
    sleep_call_2
    Log Out Non admin
    sleep_call_2

Check Delegate feature
    sleep_call_2
    Open Browser To Login Page using Admin
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Reset Client Download
    sleep_call_2
    Check default state of delegates
    sleep_call_2
    Check delegate tab is not visible
    sleep_call_2
    Enable Delegate
    sleep_call_2
    Check delegate tab is visible
    sleep_call_2
    #Open Organisational Policy Page
    #sleep_call_2
    #Reset Delegate feature
    sleep_call_2
    Log out
    sleep_call_2


Check Email feature
    sleep_call_2
    Open Browser To Login Page using Admin
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Check default state of email
    sleep_call_2
    Check email header is not visible
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Enable Email
    sleep_call_2
    Check email header is present
    sleep_call_2
    #Open Organisational Policy Page
    #sleep_call_2
    #Reset Email feature
    sleep_call_2
    Log out
    sleep_call_2

Check Quota feature
    sleep_call_2
    Open Browser To Login Page using Admin
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    check default state of quota
    sleep_call_2
    Enable Quota
    sleep_call_2
    Check Quota feature controls
    sleep_call_2
    Reset Quota
    sleep_call_2
    Log out
    sleep_call_2
###################################################################