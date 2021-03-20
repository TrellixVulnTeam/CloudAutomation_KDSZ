*** Settings ***
Library  SeleniumLibrary
Library     ../ChromeExtension/ChromeExtension.py
Library     ../ChromeExtension/CloudLogin.py
Library     ../Email/send_email.py
Library     Printerautomation.py
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