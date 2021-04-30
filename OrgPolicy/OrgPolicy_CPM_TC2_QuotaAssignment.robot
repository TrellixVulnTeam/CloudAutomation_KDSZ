*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_OrgPolicy_Resources_CostCenter.robot
Variables    ../PageObjects/Locators.py



*** Variables ***
#${LOGIN URL}                    https://qa.us.iss.lexmark.com
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234


*** Test Cases ***

Check Quota Assignments
    Open Browser To Login Page using Admin
    Open Quota Assignment Page
    Check whether cost center and personal tab is displayed
    Open Organisational Policy Page
    Select Department or Personal
    Open Quota Assignment Page
    Check whether department and personal tab is displayed
    Open Organisational Policy Page
    Select Personal
    Open Quota Assignment Page
    Check whether no tab is displayed

Reset Quota Assignment
    Open Organisational Policy Page
    Reset to Cost Center or Personal and uncheck quota
    Log out

###################################################################