*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Resource     ../Resources/CPM_Email_Resources.robot

*** Test Cases ***
Email job verification with blank subject and body
    Open Browser To Login Page
    Check blank subject email job   ${IP}   ${PIN}
    Log out
    Open Browser To Login Page
    Check blank body email job
    Log out

###################################################################