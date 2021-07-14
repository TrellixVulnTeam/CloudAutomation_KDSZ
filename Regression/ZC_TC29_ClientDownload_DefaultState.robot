*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Resource     ../Resources/CPM_ClientDownload_Resources.robot
Library     ../Library/Printerautomation.py
Force Tags      Client Download

*** Test Cases ***
Verify default state of controls
    Open Browser To Login Page
    Check default state
    Logout

###################################################################