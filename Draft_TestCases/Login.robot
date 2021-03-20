*** Settings ***
Library     SeleniumLibrary
Library     CloudLogin.py
Resource    ../Resources/LoginCPM.robot

*** Variables ***
${BROWSER}      Chrome
${URL}          https://qa.us.iss.lexmark.com
${USER}         sravantesh.neogi@lexmark.com
${PASSWORD}     Password@1234
${TITLE}        Print Management | Lexmark Cloud Services
${TABNAME}      Print Queue


*** Test Cases ***
Login Verification
    Open My Browser     ${URL}  ${BROWSER}
    Provide Email address   ${USER}
    Click Next
    Provide Password    ${PASSWORD}
    Click Login

Login Successful
    Check Login successful
CPM page Opens correct;y
    Click CPM   ${TITLE}
    Verify Print queue is displayed     ${TABNAME}
