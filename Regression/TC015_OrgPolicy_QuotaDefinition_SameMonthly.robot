*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_OrgPolicy_Resources_SameMonthly.robot
Library     DataDriver  ../TestData/Custom_Quota.xlsx
Suite Setup     Open Browser and Quota Page
Test Template   Check Custom quota monthly
Suite Teardown     Log out quota
Force Tags      Quota


*** Variables ***



*** Test Cases ***
Custom Quota Monthly : ${quota_name}


*** Keywords ***
Check Custom quota monthly
    [Arguments]     ${quota_name}     ${quota_interval}      ${quota_total}      ${quota_color}     ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}
    Create Custom quota monthly      ${quota_name}     ${quota_interval}      ${quota_total}      ${quota_color}        ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}



###################################################################