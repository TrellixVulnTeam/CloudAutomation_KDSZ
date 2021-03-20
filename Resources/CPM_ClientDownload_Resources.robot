*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py
#Library     DataDriver  ../TestData/Win_Custom_Package.xlsx

*** Variables ***
${LOGIN URL}                    https://dev.us.cloud.onelxk.co/
${BROWSER}                      Chrome
${username}                     sravantesh.neogi@lexmark.com
${password}                     Password@1234
${PACKAGE NAME}                 customPackage.zip
${message}                      Pass
${messagefail}                  Fail

#Data parametrization variables
########################################
#${notification}                         False
#${DELETE CLIENT FOLDER}                 False
#${unused_client_value_delete_span}      30
#${hybrid_unprinted_jobs_value}          180
#${latebind}                             False
#${hybrid_printed_jobs_value}            150
#${saas}                                 False
${CPM URL}                              https://qa.us.iss.lexmark.com/cpm
##########################################

*** Keywords ***

Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call
    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    sleep_call
    wait until element is visible   ${title_clientdownload}
    sleep_call_2

    #go to   ${CPM URL}
    sleep_call
    #sleep_call


Create Custom Package
    [Arguments]   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
    Set Global Variable      ${unused_client_value_delete_span}
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${username}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${password}
    Click Button    ${btn_login}
    sleep_call

#Update Secuirty policy
#Change security preferences to allow EXE downloads
    go to   chrome://settings/security
    sleep_call_2

#Navigate to Standard Security Policy
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB
    Press Keys    None      TAB

    sleep_call_2
    Press Keys    None      ARROW_UP
    sleep_call_2

    go to   ${LOGIN URL}

    sleep_call
    Wait Until Element Is Visible   ${lnk_cpm}
    Click Element   ${lnk_cpm}
    sleep_call_2
    Switch Window       Print Management | Lexmark Cloud Services
    sleep_call
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    sleep_call
    wait until element is visible   ${title_clientdownload}
    sleep_call_2

    log     ${notification}
    #go to   ${CPM URL}
    sleep_call
    #sleep_call
    click element    ${lnk_custompackage}
    sleep_call_2
    wait until element is visible   ${lbl_clientdownload}
    sleep_call_2

#Setting the value for notifications
    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_status}
    log     ${notification}
    log     ${isCheck}

    ${notification}     convert to string   ${notification}
    ${isCheck}     convert to string   ${isCheck}

    ${result}=  run keyword and return status   Should Be Equal As Strings      ${notification}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_status}
    ...     ELSE        unselect checkbox       ${chk_status}

    ${navigation}   run keyword and return status   checkbox should be selected     ${chk_status}

#######################################################################################
#Setting value for Delete Unused Client folder
    ${isCheck} =    Run Keyword And Return Status    checkbox should not be selected   ${chk_deletefolder}

    ${DELETE CLIENT FOLDER}     convert to string   ${DELETE CLIENT FOLDER}
    ${isCheck}     convert to string   ${isCheck}

    ${result}=  run keyword and return status   Should Be Equal As Strings      ${DELETE CLIENT FOLDER}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_deletefolder}
    ...     ELSE    unselect checkbox       ${chk_deletefolder}
    ${delete_folder_flag}=   run keyword and return status   checkbox should be selected   ${chk_deletefolder}

    run keyword if  ${delete_folder_flag}   Set Unused Client Folder values
    ${unused_client_value}    get value   ${txt_noprint_span}

########################################################################################

#Validate SAAS is enabled
    checkbox should be selected     ${chk_saas}
#Enable hybrid
    select checkbox     ${chk_hybrid}
    sleep_call_2
    scroll element into view        ${btn_create}
    sleep_call_2

#Get user input values for Hybrid Unprinted job
#######################################################################3
    ${hybrid_unprinted_jobs_value_temp}    get value   ${txt_unprinted_jobs}
    ${count}    get length  ${hybrid_unprinted_jobs_value_temp}

    FOR    ${index}    IN RANGE    ${count}
        press keys      ${txt_unprinted_jobs}       DELETE
    END

    input text    ${txt_unprinted_jobs}    ${hybrid_unprinted_jobs_value}

    ${hybrid_unprinted_jobs_value}    get value   ${txt_unprinted_jobs}

#Get user input values for Hybrid printed job
#########################################################################
    ${hybrid_printed_jobs_value_temp}    get value   ${txt_printed_jobs}
    ${count}    get length  ${hybrid_printed_jobs_value_temp}

    FOR    ${index}    IN RANGE    ${count}
        press keys      ${txt_printed_jobs}       DELETE
    END

    input text    ${txt_printed_jobs}    ${hybrid_printed_jobs_value}
    ${hybrid_printed_jobs_value}    get value   ${txt_printed_jobs}

###############################################################

#Validate late Binding is enabled
    sleep_call_2
#Setting value for Late Binding
    ${isCheck} =    Run Keyword And Return Status    checkbox should be selected   ${chk_latebinding}

    ${latebind}     convert to string   ${latebind}
    ${isCheck}     convert to string   ${isCheck}
    ${result}=  run keyword and return status   Should Be Equal As Strings      ${latebind}     ${isCheck}
    run keyword if      ${result}       select checkbox     ${chk_latebinding}
    ...         ELSE    unselect checkbox       ${chk_latebinding}

    ${latebind}     run keyword and return status   checkbox should be selected     ${chk_latebinding}

###############################################################
#Check the default queue name as selected by user
#Check default state which is SAAS. If user provides true, keep as it is. If false, select Hybrid
    sleep_call_2

    ${isCheck} =    Run Keyword And Return Status    element attribute value should be      ${rad_saas}     aria-checked        true

    ${saas}     convert to string   ${saas}
    ${isCheck}     convert to string   ${isCheck}
    ${result}=  run keyword and return status   Should Be Equal As Strings      ${saas}     ${isCheck}
    run keyword if      ${result}       click element     ${rad_saas}
    ...         ELSE    click element       ${rad_hybrid}

    ${saas}     run keyword and return status       element attribute value should be       ${rad_saas}     aria-checked        true

####################################################################
#Create Pacakge
    click button        ${btn_create}

#Wait till package is ready
    sleep_call
    wait until element is visible   ${dlg_download}

    wait until element is enabled       ${btn_download}
    element text should be      ${lbl_complete}     Your custom package is ready for downloading.

    sleep_call_2

#Click Download
    click button        ${btn_download}
    #logout and close browsers
    sleep_call
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}

    ${download_flag}=   download_wait   customPackage.zip
    sleep_call

    ${validation_flag}=  check_values     ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}


    sleep_call
    close all browsers


Set Unused Client Folder values

    ${unused_client_value_delete_span_temp}    get value   ${txt_noprint_span}
    sleep_call_2

#Set user input values
    ${count}    get length  ${unused_client_value_delete_span_temp}

    FOR    ${index}    IN RANGE    ${count}
        #Press Key    ${txt_noprint_span}    \\8
        press keys      ${txt_noprint_span}       DELETE
    END

    input text    ${txt_noprint_span}    ${unused_client_value_delete_span}
    ${unused_client_value_delete_span}      get text    ${txt_noprint_span}

Check default state
    click element    ${lnk_custompackage}
    sleep_call_2
    wait until element is visible   ${lbl_clientdownload}
    sleep_call_2
#Validating default state for notifications
    checkbox should be selected     ${chk_status}
    #element should be disabled      ${btn_create}
#Validating default state for unused client folder
    checkbox should not be selected     ${chk_deletefolder}
#Enable unused client folder
    select checkbox     ${chk_deletefolder}
    sleep_call_2

#Validate SAAS is enabled
    checkbox should be selected     ${chk_saas}
#Enable hybrid
    checkbox should not be selected     ${chk_hybrid}

    element should be disabled     ${btn_delete_printed_increment}
    element should be disabled      ${btn_delete_printed_decrement}

    select checkbox     ${chk_hybrid}
    sleep_call_2
    element should be enabled     ${btn_delete_unprinted_increment}
    element should be enabled      ${btn_delete_unprinted_decrement}

    scroll element into view        ${btn_cancel}
#Check default values
    element attribute value should be       ${txt_unprinted_jobs}    value    48
    element attribute value should be       ${txt_printed_jobs}    value    48
    sleep_call_1

#Validate late Binding is enabled
    checkbox should be selected     ${chk_latebinding}

#Validate default driver datastream

    element attribute value should be     ${radio_PCLXL}        aria-checked    true
    element attribute value should be     ${radio_PCL5}        aria-checked    false
    element attribute value should be     ${radio_PS}        aria-checked    false
    element attribute value should be     ${radio_Exclude}        aria-checked    false

#Check button state
    element should be enabled       ${btn_cancel}
    element should be enabled      ${btn_create}
#Check default driver
    element attribute value should be     ${rad_saas}      aria-checked    true
    element attribute value should be     ${rad_hybrid}    aria-checked    false
    element attribute value should be    ${rad_exclude}     aria-checked    false

Logout
    click element   ${lnk_username}
    wait until page contains element    ${lnl_logout}
    sleep_call_2
    click element   ${lnl_logout}
    sleep_call
    close all browsers




#Validate package is downloaded
##PageObjects Python script to confirm correct file has been downloaded
#    sleep_call_2
#    ${download_flag}=   download_wait   customPackage.zip
#    log     ${download_flag}
#    exception

###################################################################################################################


