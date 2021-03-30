*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/ChromeExtension.py
Library     ../Delegates/CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_OrgPolicy_Resources.robot
Library     DataDriver  ../TestData/Custom_Quota_Vary.xlsx
Suite Setup     Open Browser and Quota Page
Test Template   Check Custom quota vary
Suite Teardown     Log out


*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Test Cases ***
Custom Quota Vary : ${quota_name}


*** Keywords ***
Check Custom quota vary
    [Arguments]     ${quota_name}     ${quota_interval}   ${month}    ${quota_total}      ${quota_color}     ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}
    Create Custom quota vary      ${quota_name}     ${quota_interval}  ${month}    ${quota_total}      ${quota_color}        ${quota_interval_value}      ${quota_total_value}      ${quota_color_value}    ${monthly_total_id} 	${monthly_total_value}  	${monthly_color_id}	    ${monthly_color_value}


#Create Custom Quota
#    Open Browser To Login Page using Admin
#    #Open organisational policy page
#    #Enable Quota
#    Open Quota Definition Page
#    Create Custom quota


###################################################################