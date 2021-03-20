*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/ChromeExtension_Features_resources.robot

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                     sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${TABNAME}                     Print Queue
${correct}                      Correct Number of Page Types listed
${COPIES}                       4

*** Test Cases ***
Chrome extension Verification
    Login to chrome extension
    Navigate to CPM
    Set Print Job Parameters

    Chrome Extension Login Job Verification
    Print Job
    #Delete Submitted Jobs

    Submit Chrome Copy Job and check whether it is displayed
    Chrome Extension Copies verification
    Print Job
    #Delete Submitted Jobs

    Submit Chrome Mono Job and check whether it is displayed
    Chrome Extension Mono verification
    Print Job
    #Delete Submitted Jobs         sravantesh.neogi@lexmark.com

    Submit Chrome Color Job and check whether it is displayed
    Chrome Extension Color verification
    #Delete Submitted Jobs
    Print Job

    Submit Chrome Duplex Short Edge Job and check whether it is displayed
    Chrome Extension Duplex Short Edge verification
    Print Job
    #Delete Submitted Jobs

    Submit Chrome Duplex Long Edge Job and check whether it is displayed
    Chrome Extension Duplex Long Edge verification
    Print Job
    #Delete Submitted Jobs

    Submit Chrome Simplex Job and check whether it is displayed
    Chrome Extension Simplex verification
    Print Job
    #Delete Submitted Jobs

    Log Out Close Browsers

###################################################################