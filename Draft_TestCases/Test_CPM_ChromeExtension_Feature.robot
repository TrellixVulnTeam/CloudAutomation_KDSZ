*** Settings ***
Library  SeleniumLibrary
Library     ChromeExtension.py
Library     CloudLogin.py
Library     DataDriver  ../TestData/Nup.xlsx
Suite Setup     Login to chrome extension and job submission
Test Template   Chrome Extensions Nup Job verification
Suite Teardown     Log Out Close Browsers

*** Test Cases ***
Chrome extension N-Up Verification with N-Up equal ${NUP}
    Login to chrome extension and job submission
    Chrome Extensions Nup Job verification
    Log Out Close Browsers

*** Keywords ***
Login to chrome extension and job submission
    login_job

    Open Browser    ${LOGIN URL}    ${BROWSER}

#Maximise Browser
    Maximize Browser Window

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

#Click CPM and verify Page Opens
    sleep_call
    Wait Until Element Is Visible   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    Click Element   xpath://*[@id="card-12"]/cui-card-body/cui-priv-block/div/div
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    Title Should Be     Print Management | Lexmark Cloud Services
    sleep_call

#Check Print Queue Opens and check Text
    Wait until Element Is Visible   id:link-navPrintQueue
    Click Element   id:link-navPrintQueue
    element should contain  xpath://*[@id="printQueuePageHeaderDropDown_button"]/div   ${tab1name}

    sleep_call_2
    ${joblist}=     run keyword and return status   element text should be      //*[@id="documents"]/ag-grid-angular/div/div[1]/div/div[6]/div/div/span     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  documents-row-0-documentStatus  Processing
    run keyword if  ${pagestatus}   reload page


#Check job and copies value
    sleep_call_2
    ${job_name}     set variable    document_link_0
    ${job_status}   set variable    documents-row-0-documentStatus
    ${job_copies}   set variable    documents-row-0-printOptions.copies.value
    ${job_source}   set variable    //*[@id="documents-row-0-client"]/lpm-source-renderer/div
    ${job_icon}     set variable    //*[@id="documents-row-0-client"]/lpm-source-renderer/div
    ${job_colormode}    set variable    //*[@id="documents-row-0-printOptions.color.value"]
    ${job_icon}     set variable    //*[@id="documents-row-0-client"]/lpm-source-renderer/div
    ${job_duplex}      set variable    documents-row-0-printOptions.duplex.value
    ${job_nup}          set variable    documents-row-0-printOptions.nUp.value

    set global variable     ${job_name}
    set global variable     ${job_status}
    set global variable     ${job_copies}
    set global variable     ${job_source}
    set global variable     ${job_icon}
    set global variable     ${job_colormode}
    set global variable     ${job_icon}
    set global variable     ${job_duplex}
    set global variable     ${job_nup}

    sleep_call_2
    element text should be      ${job_status}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}

    sleep_call_1
    ${delete_chkbox}    set variable    documents-select-all
    ${delete_btn}   set variable    printQueueDeleteButton

    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
    element should be disabled      ${delete_btn}
    click element     ${delete_chkbox}
    sleep_call_1
    click element   ${dummy_click}
    sleep_call_1
    element should be enabled      ${delete_btn}
    sleep_call_1
    click button    ${delete_btn}
    sleep_call_2

    ${cancel_job_btn}   set variable    confirmation-modal_cancelButton
    ${yes_job_btn}      set variable    confirmation-modal_okButton
    ${delete_title}     set variable    confirmation-modal_modalHeader
    ${table_entry}      set variable    //*[@id="document_link_0"]

    sleep_call_1

    click button    ${yes_job_btn}
    sleep_call_2

    element should not be visible   ${table_entry}
    element text should be      //*[@id="documents"]/ag-grid-angular/div/div[1]/div/div[6]/div/div/span     No data available

Chrome Extensions Nup Job verification
    [Arguments]        ${NUP}
    chrome_nup  ${NUP}
    sleep_call
    ${joblist}=     run keyword and return status   element text should be      //*[@id="documents"]/ag-grid-angular/div/div[1]/div/div[6]/div/div/span     No data available
    run keyword if  ${joblist}   reload page
    ${pagestatus}=  run keyword and return status   element text should be  documents-row-0-documentStatus  Processing
    run keyword if  ${pagestatus}   reload page


    sleep_call_2
    element text should be      ${job_status}     Ready
    element text should be      ${job_name}    Google
    element attribute value should be       ${job_source}   title   Chrome Print Extension
    element should be visible           ${job_icon}
    element text should be      ${job_duplex}       Off
    element text should be      ${job_nup}      ${NUP}

    #
    sleep_call_1
    ${delete_chkbox}    set variable    documents-select-all
    ${delete_btn}   set variable    printQueueDeleteButton

    ${dummy_click}  set variable    //*[@id="documents-total-items-bottom"]/span
    element should be disabled      ${delete_btn}
    click element     ${delete_chkbox}
    sleep_call_1
    click element   ${dummy_click}
    sleep_call_1
    element should be enabled      ${delete_btn}
    sleep_call_1
    click button    ${delete_btn}
    sleep_call_2

    ${cancel_job_btn}   set variable    confirmation-modal_cancelButton
    ${yes_job_btn}      set variable    confirmation-modal_okButton
    ${delete_title}     set variable    confirmation-modal_modalHeader
    ${table_entry}      set variable    //*[@id="document_link_0"]

    sleep_call_1

    click button    ${yes_job_btn}
    sleep_call_2

    element should not be visible   ${table_entry}
    element text should be      //*[@id="documents"]/ag-grid-angular/div/div[1]/div/div[6]/div/div/span     No data available

Log Out Close Browsers
    chrome_nup_reset
    #Switch Window       Print Management | Lexmark Cloud Services
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    click element   ${usermenu}
    wait until page contains element    ${logout}
    sleep_call_2
    click element   ${logout}
    sleep_call
    close all browsers


###################################################################