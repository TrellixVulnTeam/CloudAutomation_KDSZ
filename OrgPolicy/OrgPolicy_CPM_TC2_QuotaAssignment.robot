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

Check Quota Assignments
    Open Browser To Login Page using Admin
    sleep_call_2
    Open organisational policy page
    sleep_call_2
    Enable Quota
    sleep_call_2
    Open Quota Assignment Page
    sleep_call_2
    Check whether cost center and personal tab is displayed
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Select Department or Personal
    sleep_call_2
    Open Quota Assignment Page
    sleep_call_2
    Check whether department and personal tab is displayed
    sleep_call_2
    Open Organisational Policy Page
    sleep_call_2
    Select Personal
    sleep_call_2
    Open Quota Assignment Page
    sleep_call_2
    Check whether no tab is displayed
    sleep_call_2

Reset Quota Assignment
    Open Organisational Policy Page
    sleep_call_2
    Reset to Cost Center or Personal and uncheck quota
    sleep_call_2
    Log out
    sleep_call_2

###################################################################