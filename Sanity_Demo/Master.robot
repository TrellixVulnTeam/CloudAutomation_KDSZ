*** Settings ***
Library  SeleniumLibrary
#Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Library     ../Library/ChromeWebDriver.py
Resource     ../Resources/Master.robot
Library     OperatingSystem


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
#${URL}                          https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Firefox
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${NORMALBROWSER}                Edge
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
${FILEPATH}                             C:\\Users\\neogis\\D Drive\\FREEDOM\\Python\\STL_Automation\\Attachments\\Attachment.txt
${WEBFILENAME}                          Attachment.txt
${SUITENAME}                             Environment is:
${ENV}

*** Settings ***
Force Tags      Environment-${URL}

*** Test Cases ***
Verification of correct cloud login
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Check CPM page opens
    Validate CPM page opens


Verify quota creation Total 50 and Color 50 for current month
    Open Organisational Policy Page
    Open Quota Definition Page
    Create Quota different for month
Verify Cost Center Assignment
    Open Organisational Policy Page
    Select Cost Center or Personal First
    Open Quota Assignment Page
    Set Quota Assignment for Cost Center
    Delete Quota
