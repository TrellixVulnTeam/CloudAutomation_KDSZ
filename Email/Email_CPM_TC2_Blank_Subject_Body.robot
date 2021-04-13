*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/send_email.py
Library     ../Library/Printerautomation.py
Resource     ../Resources/CPM_Email_Resources.robot

*** Test Cases ***
Email job verification with blank subject and body
    Open Browser To Login Page
    Check blank subject email job
    Log out
    Open Browser To Login Page
    Check blank body email job
    Log out

###################################################################