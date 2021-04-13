*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Resource     ../Resources/CPM_OrgPolicy_Resources_PersonalQuota.robot


*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Test Cases ***

Check Error validations for Quota
    Open Browser To Login Page using Admin
    #Open organisational policy page
    #Enable Quota
    Open Quota Definition Page
    Create a quota
    Set Total Value as 0
    Set Total Value as -1
    Set Total Value as alphabet
    Set Total Value as Decimal
    Set Total Value as Characters
    Set Color Value as 0
    Set Color Value as -1
    Set Color Value as alphabet
    Set Color Value as Characters
    Set Color Value as Decimal
    Set Total Value less than Color Value


    Log out



###################################################################