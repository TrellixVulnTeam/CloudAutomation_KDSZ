*** Settings ***
Library  SeleniumLibrary
#Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
#Library     ../Library/ChromeWebDriver.py
Resource     ../Resources/Master.robot




*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${URL}                          https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${USER}                         sravantesh.neogi@lexmark.com
${PASSWORD}                     Password@1234
${NORMALBROWSER}                Chrome
${username_blank}
${username_invalid}             sravantesh@lexmark.com
${password_blank}
${password_invalid}             Password@12345
${EMAIL USER}                   user_pallabi@test.onelxk.co
${FILENAME}                     Attachment.txt
${username_nonadmin}            cpmautomation@test.onelxk.co
${email_text}                   In addition to uploading a file, you may also e-mail it to lcp.dev2@lexmark.com to place it in your print queue.
${costcenter}                   stl
${noquotaassignment}            No custom quota definitions for assigning.
${totaldisable}                 0
${total}
${color}
${mobile_job}                   mobile.doc
${quota_name}                   Quota_Total50_Color50
${dept}                         rnd
${FILENAME2}                    Test Mail.html
${MACSAASNAME}                         Cloud Print Management
${MACSAASLINK}                         macPackageType-listbox-item-default
${MACSAAS_PACKAGE NAME}                 LPMCCloudUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.197.pkg
${MACHYBRIDNAME}                         Hybrid Print Management
${MACHYBRIDLINK}                         macPackageType-listbox-item-serverless
${MACHYBRID_PACKAGE NAME}                 LPMCServerlessUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.188.pkg
${WINSAASNAME}                      Cloud Print Management
${WINSAASLINK}                      windowsPackageType-listbox-item-default
${WINSAAS_PACKAGE NAME}             LPMC_CloudUS_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${WINHYBRIDNAME}                      Hybrid Print Management
${WINHYBRIDLINK}                      windowsPackageType-listbox-item-serverless
${WINHYBRID_PACKAGE NAME}             LPMC_ServerlessUS_2.3.960.0_UPD_2.15_Win_PCLXL_1.0.289.exe
${notification}                         True
${DELETE CLIENT FOLDER}                 True
${unused_client_value_delete_span}      10
${hybrid_unprinted_jobs_value}          20
${latebind}                             True
${hybrid_printed_jobs_value}            120
${saas}                                 True
${FILEPATH}                             C:/Users/neogis/D Drive/FREEDOM/Python/CloudAutomation/Attachments/Attachment.txt
${WEBFILENAME}                          Attachment.txt
#${IP}                                   10.195.6.123
#${PIN}                                  1234
${SUITENAME}                             Environment is:
${ENV}

*** Settings ***
Force Tags      Environment-${URL}

*** Test Cases ***
#Install chrome driver
#    ${result}=  set_chromedriver
Verification of correct cloud login
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
###Verification of dashboard title
##    Dashboard Should Open
#Logout from portal for admin
#####    Exit
#Delegate addition using ${EMAIL USER}
##    Open Browser To Login Page
#    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}
#Web Upload verification for Text file
#    Web upload with     ${IP}   ${PIN}  ${WEBFILENAME}
#Mobile Job Submission
#    Mobile submission
#Email submission with different file using ${FILENAME}
#    Email submission with  ${FILENAME}
#Verify quota creation Total 50 and Color 50 for current month
#    Open Organisational Policy Page
#    Open Quota Definition Page
#    Create Quota different for month
#Verify Cost Center Assignment
#    Open Organisational Policy Page
#    Select Cost Center or Personal First
#    Open Quota Assignment Page
#    Set Quota Assignment for Cost Center
#    Delete Quota
#Verify quota creation Total 50 and Color 50 for all month
#    Open Quota Definition Page
#    Create Monthly Quota
#Verify Department Quota Assignment
#    Open Organisational Policy Page
#    Select Department or Personal
#    Open Quota Assignment Page
#    Set Quota Assignment for Department
#    Delete Quota
#Reset Quota to Cost Center
#    Open Organisational Policy Page
#    Select Cost Center or Personal
#Verify User Quota Status by personal assignment
#    Open Organisational Policy Page
#    Select Personal
#    Open Quota Definition Page
#    Create Custom Quota
#    Set Quota Assignment for Personal
#Verify user status for normal reduction
#    Check Status Table for normal
#Verify user status for warning reduction
#    Check Status Table for warning
#Verify user status for exceeded reduction
#    Check Status Table for exceeded
#    Delete Quota
#    Reset to Cost center
#Log out from portal
#    Logoutadmin
#Verfication download of MAC Default SAAS package
#    Download MAC Default Packages for SAAS    ${MACSAASNAME}     ${MACSAASLINK}     ${MACSAAS_PACKAGE NAME}
#Verfication download of MAC Default Hybrid package
#    Download MAC Default Packages for Hybrid    ${MACHYBRIDNAME}     ${MACHYBRIDLINK}     ${MACHYBRID_PACKAGE NAME}
#Verification download of Windows Default Packages for SAAS
#    Download Default Packages for Windows for SAAS    ${WINSAASNAME}     ${WINSAASLINK}      ${WINSAAS_PACKAGE NAME}
#Verification download of Windows Default Packages for Hybrid
#    Download Default Packages for Windows for Hybrid    ${WINHYBRIDNAME}     ${WINHYBRIDLINK}      ${WINHYBRID_PACKAGE NAME}
#Verification of custom package for Windows
#    Create Custom Package for Windows   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
####################################################################