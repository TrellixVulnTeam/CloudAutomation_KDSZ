*** Settings ***
Library  SeleniumLibrary
Library     CloudLogin.py
Library     Mobile_Submission.py
Library     ../Email/Printerautomation.py
Resource     ../Resources/CPM_Mobile_Resources.robot

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${URL}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${tab1name}                     Print Queue
${correct}                      Correct Number of Pages listed

*** Test Cases ***
Mobile Job Submission
    Open Browser To Login Page
    Mobile submission
    Log out
    #Validation of Paper size dropdown
    #Reset , Log Out and Close Browsers

#
#*** Keywords ***
#Mobile
#    ${jobstatus}=   mobile_submit




###################################################################################################################
