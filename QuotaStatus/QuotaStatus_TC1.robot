*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Library     ../QuotaStatus/Print_Quota.py
Library     ../Library/CreateDelete.py
Resource     ../Resources/CPM_OrgPolocy_Resources_QuotaStatus.robot
#Library     DataDriver  ../TestData/Custom_Quota_Status.xlsx
#Suite Setup     Open Browser and Quota Page
#Test Template   Check Custom quota vary
#Suite Teardown     Log out


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      headlessChrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${NORMALBROWSER}                Chrome
#${username_blank}
#${username_invalid}             sravantesh@lexmark.com
#${password_blank}
#${password_invalid}             Password@12345
#${EMAIL USER}                   user_pallabi@test.onelxk.co
#${FILENAME}                     Attachment.txt
${username_nonadmin}            cpmautomation@test.onelxk.co

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
    Logoutadmin


*** Keywords ***

###################################################################