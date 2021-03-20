*** Settings ***
Library  SeleniumLibrary
Library     ../ChromeExtension/ChromeExtension.py
Library     ../ChromeExtension/CloudLogin.py
Resource     ../Resources/CPM_ClientDownload_Resources.robot
Library     ../Email/Printerautomation.py

*** Test Cases ***
Verify custom package download
    Open Browser To Login Page
    Check default state
    Logout

###################################################################