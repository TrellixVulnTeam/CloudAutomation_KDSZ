*** Settings ***
Library  SeleniumLibrary
Library     ../ChromeExtension/ChromeExtension.py
Library     ../ChromeExtension/CloudLogin.py
Resource     ../Resources/CPM_ClientDownload_Resources.robot
Library     DataDriver  ../TestData/custom_download_win.xlsx

Library     ../ClientDownload/XMLParser.py
Test Template   Custom Package tests
Library     ../Email/Printerautomation.py

*** Test Cases ***
Custom package download for Scenario ${SNO}

*** Keyword ***
Custom Package tests
    [Arguments]     ${SNO}  ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
    Create Custom Package    ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}

#####################################################################################################################################################################################################################