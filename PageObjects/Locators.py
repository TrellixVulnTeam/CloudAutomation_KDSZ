#Login Page Elements
txt_username = "id:user_email"
txt_password = "id:user_password"

btn_next = "id:btn-email-next"
btn_login = "id:btn-email-login"

lnk_cpm = "xpath://*[@id='card-10']/cui-card-body/cui-priv-block/div/div"

name_printqueue = "id:link-navPrintQueue"

txt_nojob= "xpath://*[@id='documents']/ag-grid-angular/div/div[1]/div/div[6]/div/div/span"

job_name="id:document_link_0"
job_status= "id:documents-row-0-documentStatus"
job_copies="id:documents-row-0-printOptions.copies.value"
job_source="xpath://*[@id='documents-row-0-client']/lpm-source-renderer/div"
job_icon="xpath://*[@id='documents-row-0-client']/lpm-source-renderer/div"
job_colormode="xpath://*[@id='documents-row-0-printOptions.color.value']"
job_duplex="id:documents-row-0-printOptions.duplex.value"
job_nup="id:documents-row-0-printOptions.nUp.value"

chk_deleteall="id:documents-select-all"
btn_delete="id:printQueueDeleteButton"

btn_cancel="id:confirmation-modal_cancelButton"
btn_yes="id:confirmation-modal_okButton"
lbl_delete="id:confirmation-modal_modalHeader"
txt_table="id:document_link_0"

lnk_username="id:userMenu"
lnl_logout="id:link-logout"

txt_nodocument="xpath://*[@id='documents']/ag-grid-angular/div/div[1]/div/div[6]/div/div/span"

txt_lgnyear="xpath:/html/body/div/div[2]/section/div[2]/div/p"

lbl_incorrect="xpath://*[@id='error_explanation']/div"
lbl_errormessage="xpath://*[@id='error_explanation']/div/label"

lbl_delegate="id:link-navDelegates"
txt_delegate="xpath://*[@id='delegatesPageHeaderDropDown_button']/div"

btn_delegate_add="id:delegatesAddButton"
btn_delegate_remove="id:delegatesRemoveButton"

dlg_btn_delegate_add="id:addDelegatesModalAdd"
dlg_btn_delegate_cancel="id:addDelegatesModalCancel"

txt_delegate_email="xpath://*[@id='delegateUserSelectControl']/div"
txt_delegate_input="id:delegateUserSelectControl_Input"
lst_delegate="id:delegateUserSelectControl-listbox"

btn_delegate_delete_cancel="id:confirmation-modal_cancelButton"
btn_delegate_delete_ok="id:confirmation-modal_okButton"
lbl_delete_delegate="id:confirmation-modal_modalHeader"
lst_table_entry="xpath://*[@id='delegates-row-0-identityEmail']"

chk_delegate_delete="id:delegates-select-all"

email_job1="id:documents-row-0-id"
email_job2="id:documents-row-1-id"

tbl_printqueue="xpath://*[@id='documents']/ag-grid-angular/div/div[1]/div/div[3]"

email_job1_description="id:documents-row-0-description"
email_job2_description="id:documents-row-1-description"

email_icon_job1="id:documents-row-0-client"
email_icon_job2="id:documents-row-1-client"


email_job1_status="xpath://*[@id='documents-row-0-documentStatus']/lpm-status-renderer"
email_job2_status="xpath://*[@id='documents-row-1-documentStatus']/lpm-status-renderer"

spinner_printqueue="id:printQueueBusySpinner"

tab_clientdownload="id:link-navClientDownload"
lbl_clientdownload="xpath:/html/body/lpm-app/div/lpm-driver-config/cui-pageheader/div[1]/div[1]/h2"
title_clientdownload="xpath://*[@id='clientDownloadPageHeader']/div[1]/h2"

lnk_custompackage="id:createCustomPackageWindows"
chk_status="id:StatusNotification"
chk_deletefolder="id:DeleteClientFolders"
txt_noprint_span="id:deleteAfterLabel_input"
#txt_noprint_span="xpath://*[@id='deleteAfterLabel']/div/cui-input"
lbl_error_span="xpath:/html/body/lpm-app/div/lpm-driver-config/div/cui-form/form/lpm-global-print-release-config/fieldset/cui-numeric-stepper/div/cui-errors/div"
chk_saas="id:PrintReleaseCheckbox"
chk_hybrid="id:enableServerlessPrintReleaseCheckbox"
txt_unprinted_job="id:deleteUnprintedJobsAfterId_input"
txt_printed_job="id:deletePrintedJobsAfterId_input"
chk_latebinding="id:allowLateBindingCheckbox"
rad_hybrid="id:defaultDriverLPMServerless_radio_input"
rad_saas="id:defaultDriverLpmSaas_radio_input"
rad_exclude="id:defaultDriverNone_radio_input"
btn_create="id:create_btn"
btn_cancel="id:cancel_btn"
dlg_discard="xpath://*[@id='confirmation-modal_modalHeader']/div[2]/h4"
btn_discard_ok="id:confirmation-modal_okButton"
btn_discard_cancel="id:confirmation-modal_cancelButton"
dummy_click="id:delete-after-stepper-desc"
dlg_download="xpath:/html/body/lpm-app/div/lpm-driver-config/div/cui-form/form/lpm-download-modal/cui-modal/div/div[2]/div[1]/cui-modal-header/div/div[2]/h4"
lbl_complete="xpath:/html/body/lpm-app/div/lpm-driver-config/div/cui-form/form/lpm-download-modal/cui-modal/div/div[2]/div[1]/div/cui-modal-body/cui-priv-block/div/p"
btn_download="id:download_btn"

btn_delete_folder_increment="id:deleteAfterLabel_increment"
btn_delete_folder_decrement="id:deleteAfterLabel_decrement"

btn_delete_unprinted_increment="id:deleteUnprintedJobsAfterId_increment"
btn_delete_unprinted_decrement="id:deleteUnprintedJobsAfterId_decrement"
txt_unprinted_jobs="id:deleteUnprintedJobsAfterId_input"

#txt_unprinted_jobs="id:deleteUnprintedJobsAfterId_input"
#txt_printed_jobs="xpath://*[@id='deletePrintedJobsAfterId']/div/cui-input"
txt_printed_jobs="id:deletePrintedJobsAfterId_input"

btn_delete_printed_increment="id:deletePrintedJobsAfterId_increment"
btn_delete_printed_decrement="id:deletePrintedJobsAfterId_decrement"

radio_PCLXL="id:Radio 1_radio_input"
radio_PCL5="id:Radio 2_radio_input"
radio_PS="id:Radio 3_radio_input"
radio_Exclude="id:Radio 4_radio_input"


admin_dropdown="id:navAdminDropdown"
org_policy="id:navAdminDropdownOrganizationalPolicy"

page_header="xpath://*[@id='organizationalPolicyPageHeader']/div[1]/h2"
chk_clientdownload="id:enableClientDownloadCheckbox"
btn_save="id=save_changes_btn"




