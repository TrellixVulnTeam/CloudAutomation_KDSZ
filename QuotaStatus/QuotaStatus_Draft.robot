*** Settings ***
Library  SeleniumLibrary
Library     ../Delegates/CloudLogin.py
Library     ../QuotaStatus/CreateDelete.py
Resource     ../Resources/CPM_OrgPolicy_QuotaStatus.robot


*** Variables ***

*** Test Cases ***
Open CPM portal as Admin
    Open Browser To Login Page using Admin
    Open Organisational Policy Page
    Select Personal
    Open Quota Definition Page
    Create Custom Quota
    #Create user
    Set Quota Assignment for Personal
    Check Status Table for normal
    Check Status Table for warning
    Check Status Table for exceeded
    #Delete User
    Delete Quota
    Reset to Cost center
    Log out



###################################################################