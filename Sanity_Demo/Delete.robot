*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/Master.robot


*** Variables ***
${ENV}

*** Test Cases ***
Deletion of TMP folder
    ${delete_tmp} =   delete_folder  ${ENV}
    ${delete_tmp_ws} =   delete_ws_folder  ${ENV}
####################################################################