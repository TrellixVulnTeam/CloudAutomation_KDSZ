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
Force Tags      Organisation Policy


*** Variables ***
#${URL}                    https://dev.eu.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${IP}                           10.195.6.123
#${PIN}                          1234


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


Check Email feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of email
    Check email header is not visible
    Open Organisational Policy Page
    Enable Email
    Check email header is present
    Log out quota

Check Quota feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of quota
    Enable Quota
    Check Quota feature controls
    Log out quota

Check Print and Keep feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of print and keep
    Submit a job
    Check print and keep in printer in enable state
    Open Organisational Policy Page
    Uncheck Print and Keep
    Check print and keep in printer in disable state
    Delete job
    Open Organisational Policy Page
    Check print and keep
    Log out

Check Changing number of copy feature
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Check default state of change copy
    Change number of copies
    Submit a job
    Check copies value in enable state
    Check latebind copy in printer in enable state
    Open Organisational Policy Page
    Uncheck Late Bind copy
    Check copies value for previous job
    Check latebind binding for previous job in op panel
    Delete Job
    Submit a job
    Check copies value in disable state
    Check latebind copy in printer in disable state
    Delete job
    Open Organisational Policy Page
    Check latebind copy
    Reset Copies
    Open Organisational Policy Page
    Log out
###################################################################