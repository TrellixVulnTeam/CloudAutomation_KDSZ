*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Library     ../QuotaStatus/Print_Quota.py
Resource     ../Resources/CPM_OrgPolicy_Resources_QuotaStatus.robot
Library     DataDriver  ../TestData/Custom_Quota_Status.xlsx
Suite Setup     Open Browser and Quota Page
Test Template   Check Custom quota vary
Suite Teardown     Log out


*** Variables ***

*** Test Cases ***
Quota Status Check for all conditions


*** Keywords ***
Check Custom quota vary
    [Arguments]     ${quota_name}     ${quota_interval}   ${month}    ${quota_total}      ${quota_color}     ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}
    Create Custom quota vary      ${quota_name}     ${quota_interval}  ${month}    ${quota_total}      ${quota_color}        ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}

###################################################################