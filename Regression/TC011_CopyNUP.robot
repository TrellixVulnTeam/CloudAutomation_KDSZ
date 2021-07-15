*** Settings ***
Library  SeleniumLibrary
Library     ../Library/ChromeExtension.py
Library     ../Library/CloudLogin.py
Library     ../Library/Printerautomation.py
Library     ../Library/CreateDelete_all.py
Library     ../Library/Mobile_Submission_all.py
Library     ../Library/send_email_us_eu.py
Library     ../Library/XMLParser.py
Force Tags      Print Settings

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${BROWSER}                      Chrome
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
${loginyear}                    © 2021, Lexmark. All rights reserved.
${cpmyear}                      © 2021 Lexmark.
${tab1name}                     Print Queue
${tab2name}                     Delegates
${tab3name}                     Print Job History
${tab4name}                     Download Print Management Client
${next}                         Next
${login}                        Log In
${id}                           2
${job_status_actual}            Ready
${default_title_actual}         Set Default Print Settings
${delete_dlg_title_actual}      Delete Print Jobs


*** Test Cases ***
Copy Collate NupOrientation validation
    Open Browser To Login Page
    Increment Copy validation by 1 to 2
    Decrement Copy Validation from 2 to 1
Collate verification
    Collate Checkbox disable validation on making copy 1
    Collate Checkbox enable validation on making copy more than 1
    Collate checkbox validation by checking and unchecking
    Validation with incorrect copies value more than 999
    Validation with incorrect copies value of 0
N-Up validation
    Validate NUp orientation is disabled
    Validate NUp orientation is enabled with NUP value
    Validate NUp orientation is disabled with NUP value as 1
Paper size validation
    Validation of Paper size dropdown
Log Out
    Log Out Close Browsers


*** Keywords ***
#
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    set selenium timeout    20
#Maximise Browser
    Maximize Browser Window
    Title Should Be     Lexmark Log In

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${USER}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${PASSWORD}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services


#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

    ${default_settings_btn}     set variable    printQueueDefaultPrintSettingsButton
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible     printQueueUploadButton
    click button    ${default_settings_btn}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    ${default_title}            set variable    printSettingsBreadcrumb

    #element attribute value should be   ${default_title}    aria-label   ${default_title_actual}

Increment Copy validation by 1 to 2
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    textfield should contain    //*[@id="copies_input"]  1
    click element   //*[@id="copies_increment"]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  2
    element should be enabled   //*[@id="copies"]/div/div[1]

Decrement Copy Validation from 2 to 1
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    click element   //*[@id="copies"]/div/div[1]
    sleep_call_1
    textfield should contain    //*[@id="copies_input"]  1

Collate Checkbox disable validation on making copy 1
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    element should be disabled   id:collateCheckbox

Collate Checkbox enable validation on making copy more than 1
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    click element   //*[@id="copies_increment"]
    sleep_call_1

    element should be enabled   id:collateCheckbox
    ${isCheck} =    Run Keyword And Return Status    element should be enabled   id:collateCheckbox
    Run keyword if  ${isCheck}      checkbox should be selected     id:collateCheckbox

Collate checkbox validation by checking and unchecking
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    unselect checkbox       id:collateCheckbox
    sleep_call_1
    checkbox should not be selected     id:collateCheckbox
    sleep_call_1
    select checkbox     id:collateCheckbox
    sleep_call_1
    checkbox should be selected     id:collateCheckbox
    sleep_call_1
    click element   //*[@id="copies_decrement"]
    sleep_call_1
    element attribute value should be   id:collateCheckbox     disabled        true


Validation with incorrect copies value more than 999
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    input text      //*[@id="copies_input"]     1000
    sleep_call_1
    click element   //*[@id="collateCheckboxDiv"]/div/cui-description/span

    page should contain      Value must range from 1 to 999.
    element should be disabled      //*[@id="copies_increment"]


Validation with incorrect copies value of 0
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    click element   //*[@id="copies"]/div/div[1]
    sleep_call_1
    press keys      //*[@id="copies_input"]      \DELETE
    press keys      //*[@id="copies_input"]      \DELETE
    press keys      //*[@id="copies_input"]      \DELETE
    input text      //*[@id="copies_input"]     0
    click element   //*[@id="collateCheckboxDiv"]/div/cui-description/span
    sleep_call_1

    page should contain      Value must range from 1 to 999.
    sleep_call_1
    element should be disabled      //*[@id="copies_decrement"]
    click element       //*[@id="copies_increment"]

Validate NUp orientation is disabled
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    element attribute value should be   //*[@id="nupOrientation"]/div    disabled   true
    sleep_call_1
    click element   nup
    wait until page contains element    nup-listbox-item-3
    click element   nup-listbox-item-3
    sleep_call_1

Validate NUp orientation is enabled with NUP value
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    element attribute value should be   //*[@id="nupOrientation"]/div    aria-disabled   false
    click element   nupOrientation
    wait until page contains element    nupOrientation-listbox-item-shortedge
    click element       nupOrientation-listbox-item-shortedge

    click element   nupOrientation
    wait until page contains element    nupOrientation-listbox-item-longedge
    click element       nupOrientation-listbox-item-longedge

    click element   nupOrientation
    wait until page contains element    nupOrientation-listbox-item-auto
    click element       nupOrientation-listbox-item-auto

Validate NUp orientation is disabled with NUP value as 1
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    sleep_call_1
    click element   nup
    wait until page contains element    nup-listbox-item-1
    click element   nup-listbox-item-1
    sleep_call_1
    element attribute value should be   //*[@id="nupOrientation"]/div    disabled   true

Validation of Paper size dropdown
    set selenium timeout    20
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Layout
    scroll element into view        saveChangesButton
    sleep_call_1
    click element       paperSize
    sleep_call_1
    wait until page contains element    paperSize
    sleep_call_1
    click element       //*[@id="paperSize-listbox"]/div


Log Out Close Browsers
    set selenium timeout    20
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


