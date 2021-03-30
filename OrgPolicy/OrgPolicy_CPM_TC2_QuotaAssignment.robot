*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_OrgPolicy_Resources_Vary.robot


*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Test Cases ***

Check Quota Assignments
    Open Browser To Login Page using Admin
    Open organisational policy page
    Enable Quota
    Open Quota Assignment Page
    Check whether cost center and personal tab is displayed
    Open Organisational Policy Page
    Select Department or Personal
    Open Quota Assignment Page
    Check whether department and personal tab is displayed
    Open Organisational Policy Page
    Select Personal
    Open Quota Assignment Page
    Check whether no tab is displayed

Reset Quota Assignment
    Open Organisational Policy Page
    Reset to Cost Center or Personal and uncheck quota
    Log out

###################################################################