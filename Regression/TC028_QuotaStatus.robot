*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
#Library     ../Library/Print_Quota.py
#Library     ../Library/CreateDelete.py
Resource     ../Resources/CPM_OrgPolicy_QuotaStatus.robot
#Library     DataDriver  ../TestData/Custom_Quota_Status.xlsx
#Suite Setup     Open Browser and Quota Page
#Test Template   Check Custom quota vary
#Suite Teardown     Log out
Force Tags      Quota Status


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${IP}                           10.195.6.123
#${PIN}                          1234
#${username_nonadmin}            cpmautomation@test.onelxk.co

*** Test Cases ***
Verify User Quota Status by personal assignment
    Open Browser To Login Page using admin
    Open Organisational Policy Page
    Select Personal
    Open Quota Definition Page
    Create Custom Quota
    Set Quota Assignment for Personal
Verify user status for normal reduction
    Check Status Table for normal
Verify user status for warning reduction
    Check Status Table for warning
Verify user status for exceeded reduction
    Check Status Table for exceeded
    Delete Quota
    Reset to Cost center
Log out from portal
    Log out


*** Keywords ***

###################################################################