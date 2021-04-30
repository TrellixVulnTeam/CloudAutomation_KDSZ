*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_OrgPolicy_Resources_PersonalQuota.robot
Library     DataDriver  ../TestData/Custom_Quota_Vary.xlsx
Suite Setup     Open Browser and Quota Page
Test Template   Check Custom quota vary
Suite Teardown     Log out quota
Variables    ../PageObjects/Locators.py


*** Variables ***

*** Test Cases ***
Personal Quota Assignment : ${quota_name}


*** Keywords ***
Check Custom quota vary
    [Arguments]     ${quota_name}     ${quota_interval}   ${month}    ${quota_total}      ${quota_color}     ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}
    Create Custom quota vary      ${quota_name}     ${quota_interval}  ${month}    ${quota_total}      ${quota_color}        ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}

###################################################################