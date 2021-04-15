*** Settings ***
Library  SeleniumLibrary
Library     ../Library/XMLParser.py


*** Variables ***
${ENV}

*** Test Cases ***
Deletion of TMP folder
    ${delete_tmp} =   delete_folder  ${ENV}
    ${delete_tmp_ws} =   delete_ws_folder  ${ENV}
####################################################################