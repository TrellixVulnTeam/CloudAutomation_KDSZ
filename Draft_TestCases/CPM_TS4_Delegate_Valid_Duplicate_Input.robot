*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/Delegate_ValidDuplicate.xlsx
Library     CloudLogin.py
Suite Setup     Open Browser To Login Page
Test Template   Check Adding Valid and Duplicate Delegates
#Test Template   Duplicate Delegate
#Suite Teardown  Duplicate Delegate

Suite Teardown     Delete delegates and Log Out Close Browsers

*** Variables ***
${LOGIN URL}                    https://qa.us.iss.lexmark.com
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234


*** Test Cases ***
Verify Delegate feature by adding user: ${EMAIL USER}

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window

#Check Copyright in Login

#Check Username field is enabled and displayed
    ${username_text}    set variable    id:user_email
    ${password_text}    set variable    id:user_password

#Input Username
    Input Text    id:user_email    ${username}

#Verify Next Button is enabled and verify value
    ${nextbtn}  set variable    btn-email-next

#Click Next button
    Click Button    btn-email-next

#Check Password field is enabled and displayed
    ${password_text}    set variable    id:user_password

#Input Password
    Input Text    id:user_password    ${password}

#Verify Login Button is enabled and verify value
    ${loginbtn}  set variable    btn-email-login

#Click Login Button
    Click Button    btn-email-login

#Dashboard Should Open

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call

Check Adding Valid and Duplicate Delegates
   [Arguments]        ${EMAIL USER}      ${VALIDATE}        ${ENTRY}

    Wait until Element Is Visible   id:link-navDelegates
    Click Element   id:link-navDelegates
    Wait until Element Is Visible   xpath://*[@id="delegatesPageHeaderDropDown_button"]/div
    sleep_call_2

#Verify Add button is enabled and Remove Button is disabled
    element should be enabled   delegatesAddButton
    element should be visible   delegatesAddButton
    element should be disabled  delegatesRemoveButton

#Click Add Delegates and check dialog
    click element   delegatesAddButton
    sleep_call_2
    element should be disabled  addDelegatesModalAdd
    element should be enabled   addDelegatesModalCancel
    click element   //*[@id="delegateUserSelectControl"]/div
    input text      delegateUserSelectControl_Input    ${EMAIL USER}
    sleep_call_2
    element should be visible   delegateUserSelectControl-listbox
    element should contain      delegateUserSelectControl-listbox       ${EMAIL USER}
    Press Keys    delegateUserSelectControl-listbox    ENTER
    sleep_call_2
    element should be enabled   addDelegatesModalAdd
    click button    addDelegatesModalAdd
    sleep_call_2

    ${table_entry}      set variable    ${ENTRY}
    element text should be      ${table_entry}      ${EMAIL USER}

#Add Duplicate User as Delegates and check dialog
    click element   delegatesAddButton
    sleep_call_2
    click element   //*[@id="delegateUserSelectControl"]/div
    input text      delegateUserSelectControl_Input    ${EMAIL USER}
    sleep_call_2
    element should be visible   delegateUserSelectControl-listbox
    element should contain      delegateUserSelectControl-listbox       ${EMAIL USER}
    Press Keys    delegateUserSelectControl-listbox    ENTER
    sleep_call_2
    element should be disabled   addDelegatesModalAdd
    page should contain      Delegate already exists
    click button    addDelegatesModalCancel

Delete delegates and Log Out Close Browsers
#Select all the delegates and click delete button
    ${remove_btn}   set variable    delegatesRemoveButton
    element should be disabled      ${remove_btn}
    ${delete_delegate_chkbox}    set variable    delegates-select-all
    ${dummy_click}      set variable        delegatesBreadcrumb
    sleep_call_2
    click element     ${delete_delegate_chkbox}
    sleep_call_2
    click element   ${dummy_click}
    element should be enabled      ${remove_btn}
    click button    ${remove_btn}
    sleep_call_2

#Validation of delete delegate dialog
    ${cancel_delegate_btn}   set variable    confirmation-modal_cancelButton
    ${delegate_del_btn}      set variable    confirmation-modal_okButton
    ${delete_title}     set variable    confirmation-modal_modalHeader
    ${table_entry}      set variable    //*[@id="delegates-row-0-identityEmail"]

    element text should be      ${delete_title}     Remove Delegates

    element should be enabled   ${cancel_delegate_btn}
    element should be enabled   ${delegate_del_btn}
    element should be focused   ${cancel_delegate_btn}

    click button    ${delegate_del_btn}
    sleep_call_2

    element should not be visible   ${table_entry}

#Log out
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################


