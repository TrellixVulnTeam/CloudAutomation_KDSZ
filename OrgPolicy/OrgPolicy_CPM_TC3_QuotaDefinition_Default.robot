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

Check Default Quota
    Open Browser To Login Page using Admin
    sleep_call_2
    Open organisational policy page
    sleep_call_2
    Enable Quota
    sleep_call_2
    Open Quota Definition Page
    sleep_call_2
    Check default quota definition
    sleep_call_2
    Log out
    sleep_call_2



###################################################################