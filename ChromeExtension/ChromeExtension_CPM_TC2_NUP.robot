*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
Library     DataDriver  ../TestData/Nup.xlsx
Resource    ../Resources/ChromeExtension_NUP_resource.robot
Suite Setup     Open My Browser for NUP
Test Template   Nup value testing
Suite Teardown     Reset and log out

*** Test Cases ***
Nup value testing using ${NUP}


*** Keyword ***
Nup value testing
    [Arguments]     ${NUP}
    Chrome Extensions Nup Job verification      ${NUP}
    #Print Job
###################################################################