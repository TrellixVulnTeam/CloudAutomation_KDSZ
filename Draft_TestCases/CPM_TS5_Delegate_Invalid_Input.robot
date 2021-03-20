*** Settings ***
Library  SeleniumLibrary
Library     DataDriver  ../TestData/Delegate_Invalid.xlsx
Library     CloudLogin.py
Suite Setup     Open Browser To Login Page
Test Template   Check Adding Invalid Delegates
Suite Teardown     Log out

*** Variables ***
${LOGIN URL}                    https://qa.us.iss.lexmark.com
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234


*** Test Cases ***
Verify Delegate feature by adding invalid user using : ${TEST CASE}

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

Check Adding Invalid Delegates
   [Arguments]        ${EMAIL USER}      ${VALIDATE}

    Wait until Element Is Visible   id:link-navDelegates
    Click Element   id:link-navDelegates
    Wait until Element Is Visible   xpath://*[@id="delegatesPageHeaderDropDown_button"]/div
    sleep_call_2

#Verify Add button is enabled and Remove Button is disabled
    element should be enabled   delegatesAddButton
    element should be visible   delegatesAddButton
    element should be disabled  delegatesRemoveButton

#Click Add Invalid Delegates and check dialog
    click element   delegatesAddButton
    sleep_call_2
    element should be disabled  addDelegatesModalAdd
    element should be enabled   addDelegatesModalCancel
    click element   //*[@id="delegateUserSelectControl"]/div
    input text      delegateUserSelectControl_Input    ${EMAIL USER}
    sleep_call_2
    element should not be visible   delegateUserSelectControl-listbox
    sleep_call_2
    element should be disabled   addDelegatesModalAdd
    click button    addDelegatesModalCancel
    sleep_call_2


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

Log out
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers

###################################################################################################################