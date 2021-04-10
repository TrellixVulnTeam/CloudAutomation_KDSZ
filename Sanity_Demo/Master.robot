*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete.py
Library     ../Library/Mobile_Submission.py
Library     ../Library/send_email.py
#Resource     ../Resources/CPM_LoginPage_resources.robot
Resource     ../Resources/Master.robot


*** Variables ***
#${LOGIN URL}                    https://dev.us.cloud.onelxk.co
#${URL}                          https://dev.us.cloud.onelxk.co
#${BROWSER}                      Chrome
#${USER}                         sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
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
${costcenter}                   stl
${quota_name}                   Quota_Total50_Color50
${dept}                         rnd
${FILENAME2}                    Test Mail.html

*** Test Cases ***
Correct Login verification
    Open CPM portal and Login Verification      ${USER}     ${PASSWORD}
Verification of dashboard title
    Dashboard Should Open
Logout from portal
    Exit
Delegate addition using ${EMAIL USER}
    Open Browser To Login Page
    Check Adding Valid and Duplicate Delegates      ${EMAIL USER}
Mobile Job Submission
    Mobile submission
Email submission with different file using ${FILENAME}
    Email submission with  ${FILENAME}
Verify quota creation Total 50 and Color 50 for current month
    Open Browser To Login Page using admin
    Open Organisational Policy Page
    Open Quota Definition Page
    Create Quota different for month
Verify Cost Center Assignment
    Open Organisational Policy Page
    Select Cost Center or Personal First
    Open Quota Assignment Page
    Set Quota Assignment for Cost Center
    Delete Quota
Verify quota creation Total 50 and Color 50 for all month
    Open Quota Definition Page
    Create Monthly Quota
Verify Department Quota Assignment
    Open Organisational Policy Page
    Select Department or Personal
    Open Quota Assignment Page
    Set Quota Assignment for Department
    Delete Quota
Reset Quota to Cost Center
    Open Organisational Policy Page
    Select Cost Center or Personal
Verify User Quota Status by personal assignment
    Open Organisational Policy Page
    Select Personal
    Open Quota Definition Page
    Create Custom Quota
    Set Quota Assignment for Personal
    Check Status Table for normal
    Check Status Table for warning
    Check Status Table for exceeded
    Delete Quota
    Reset to Cost center
    Logoutadmin

###################################################################