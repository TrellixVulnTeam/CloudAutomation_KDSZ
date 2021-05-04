*** Settings ***
Library  SeleniumLibrary
Variables    ../PageObjects/Locators.py
#Library     DataDriver  ../TestData/Win_Custom_Package.xlsx

*** Variables ***
#${URL}                    https://dev.us.cloud.onelxk.co/
#${DOWNLOADBROWSER}                      Edge
#${USER}                     sravantesh.neogi@lexmark.com
#${PASSWORD}                     Password@1234
#${PACKAGE NAME}                 customPackage.zip
${message}                      Pass
${messagefail}                  Fail

##########################################

*** Keywords ***

Open Browser To Login Page
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${title_clientdownload}

Create Custom Package
    [Arguments]   ${notification}     ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}
    Set Global Variable      ${unused_client_value_delete_span}
    Open Browser    ${URL}    ${DOWNLOADBROWSER}
    Maximize Browser Window
    Input Text    ${txt_username}    ${USER}
    Click Button    ${btn_next}
    Input Text    ${txt_password}    ${PASSWORD}
    Click Button    ${btn_login}
    Wait Until Keyword Succeeds    35 sec    5 sec    page should contain      Cloud Services Home
#Click CPM and verify Page Opens
    ${lnk_cpm} =   Catenate    SEPARATOR=   ${URL}   cpm
    go to       ${lnk_cpm}
    Wait Until Keyword Succeeds     25 sec  5 sec   title should be     Print Management | Lexmark Cloud Services
    Switch Window       Print Management | Lexmark Cloud Services
    Title should be     Print Management | Lexmark Cloud Services
    Wait until Element Is Visible   ${tab_clientdownload}
    Click Element   ${tab_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${title_clientdownload}
    click element    ${lnk_custompackage}
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${lbl_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_status}
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
    scroll element into view        ${btn_create}

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
    Wait Until Keyword Succeeds     25 sec  5 sec   element should be visible     ${dlg_download}
    Wait Until Keyword Succeeds     40 sec  5 sec   element should be enabled     ${btn_download}
    element text should be      ${lbl_complete}     Your custom package is ready for downloading.

#Click Download
    click button        ${btn_download}
    #logout and close browsers
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In

    ${download_flag}=   download_wait   customPackage.zip

    ${validation_flag}=  check_values     ${notification}   ${DELETE CLIENT FOLDER}   ${unused_client_value_delete_span}      ${hybrid_unprinted_jobs_value}  ${latebind}    ${hybrid_printed_jobs_value}    ${saas}

    close browser


Set Unused Client Folder values

    ${unused_client_value_delete_span_temp}    get value   ${txt_noprint_span}

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
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      ${lbl_clientdownload}
    Wait Until Keyword Succeeds     25 sec  5 sec   page should contain checkbox     ${chk_status}
#Validating default state for notifications
    checkbox should be selected     ${chk_status}
    #element should be disabled      ${btn_create}
#Validating default state for unused client folder
    checkbox should not be selected     ${chk_deletefolder}
#Enable unused client folder
    select checkbox     ${chk_deletefolder}

#Validate SAAS is enabled
    checkbox should be selected     ${chk_saas}
#Enable hybrid
    checkbox should not be selected     ${chk_hybrid}

    element should be disabled     ${btn_delete_printed_increment}
    element should be disabled      ${btn_delete_printed_decrement}

    select checkbox     ${chk_hybrid}
    element should be enabled     ${btn_delete_unprinted_increment}
    element should be enabled      ${btn_delete_unprinted_decrement}

    scroll element into view        ${btn_cancel}
#Check default values
    element attribute value should be       ${txt_unprinted_jobs}    value    48
    element attribute value should be       ${txt_printed_jobs}    value    48

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
    ${usermenu}     set variable    userMenu
    ${logout}       set variable    link-logout
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      userMenu
    click element   ${usermenu}
    Wait Until Keyword Succeeds    35 sec    5 sec    element should be visible      link-logout
    click element   ${logout}
    Wait Until Keyword Succeeds    35 sec    5 sec    title should be       Lexmark Log In
    close all browsers


###################################################################################################################


