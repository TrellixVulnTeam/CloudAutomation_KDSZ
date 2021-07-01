*** Settings ***
Library  SeleniumLibrary
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Library     ../Library/ChromeWebDriver.py
Resource     ../Resources/CPM_OrgPolicy_Resources_CostCenter.robot
Variables    ../PageObjects/Locators.py


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
    Log out quota


#Check Email feature
#    Open Browser To Login Page using Admin
#    Open Organisational Policy Page
#    Check default state of email
#    Check email header is not visible
#    Open Organisational Policy Page
#    Enable Email
#    Check email header is present
#    Log out quota

Check Quota feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of quota
    Enable Quota
    Check Quota feature controls
    Log out quota
###################################################################