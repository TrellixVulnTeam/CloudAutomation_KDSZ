#Login Page Elements
txt_username = "id:user_email"
txt_password = "id:user_password"

btn_next = "id:btn-email-next"
btn_login = "id:btn-email-login"

lnk_cpm = "xpath://*[@id='card-10']/cui-card-body/cui-priv-block/div/div"
lnk_cpm_nonadmin="xpath://*[@id='card-14']/cui-card-body/cui-priv-block/div/div"
lnk_cpm_quotauser="xpath://*[@id='card-8']/cui-card-body/cui-priv-block/div/div"

name_printqueue = "id:link-navPrintQueue"

txt_nojob= "id:documents-row-0-id"

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
header_delegate="id:delegatesPageHeaderDropDown_button"
spin_delegate="id:delegatesDatagridLoadingBusySpinner"

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
lbl_clientdownload="xpath:/html/body/lpm-app/div/lpm-driver-config/cui-pageheader/div[1]/div[1]/div[2]/h2[1]"

title_clientdownload="xpath://*[@id='clientDownloadPageHeader']/div[1]/div[2]/h2[1]"

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

page_header="id:organizationalPolicyPageHeader"
chk_clientdownload="id:enableClientDownloadCheckbox"
header_clientdownload="id:clientDownloadPageHeader"
lnk_customwin="id:createCustomPackageWindows"
lnk_custommac="id:createCustomPackageMac"
btn_save="id:save_changes_btn"

chk_delegates="id:enablePrintDocumentDelegationCheckbox"
chk_email="id:enableEmailSubmissionCheckbox"
header_email="id:email-submission-banner"

chk_quota="id:enableQuotasCheckbox"
radio_costcenter="id:useCostCenterOption_radio_input"
radio_dept="id:useDepartmentOption_radio_input"
radio_personal="id:usePersonalOption_radio_input"
lbl_quotadefinition="id:navAdminDropdownQuotaDefinition"
lbl_quotaassignment="id:navAdminDropdownQuotaAssignments"
lbl_quotastatus="id:navAdminDropdownUserQuotaStatus"

btn_confirmchange="id:confirmation-modal_okButton"
#tab_costcenter="id:costCenterTab"
tab_costcenter="xpath://*[@id='costCenterTab']/a"
tab_personal="xpath://*[@id='userTab']/a"


chk_costcenter="id:useCostCenterOption_radio_input"
chk_dept="id:useDepartmentOption_radio_input"
chk_personal="id:usePersonalOption_radio_input"

btn_default="id:defaultQuotaDefinitionAccordian-item0-action-button-0"
icon_definition="id:defaultQuotaDefinitionAccordian-toggle-button-0"
quota_interval_value="xpath://*[@id='cdk-drop-list-0']/div/div[2]/div/lpm-default-quota-definition-summary/div/div[1]/div[2]"
total_quota_value="xpath://*[@id='cdk-drop-list-0']/div/div[2]/div/lpm-default-quota-definition-summary/div/div[2]/div[2]"
bw_quota_value="xpath://*[@id='cdk-drop-list-0']/div/div[2]/div/lpm-default-quota-definition-summary/div/div[3]/div[2]"

quota_limit="id:definitionLimitsSelectControl"
total_quota="id:definitionTotalSelectControl"
radio_unlimited="id:unlimitedRadioOption_radio_input"

btn_cancel_changes="id:cancelChanges"

btn_create_quota="id:createQuotaDefinition"
txt_quotaname="id:definitionName"

costcenter_name="id:collections-row-0-name"

lst_quotalimit="id:definitionLimitsSelectControl"
lst_total_quota="id:definitionTotalSelectControl"

lst_total_quota_value="id:definitionTotalSelectControl-listbox"


costcenter_assignment_count="id:quotaDefinitionGrid-row-0-assignments.costCenterAssignments"
personal_assignment_count="id:quotaDefinitionGrid-row-0-assignments.individualAssignments"
dept_assignment_count="id:quotaDefinitionGrid-row-0-assignments.departmentAssignments"

radio_fullcolor="id:unlimitedRadioOption_radio_input"
radio_disablecolor="id:disabledRadioOption_radio_input"
radio_customcolor="id:customRadioOption_radio_input"

txt_color_value="id:colorQuotaLabel_input"
txt_total_value="id:totalQuotaLabel_input"

btn_create_def="id:updateQuotaDefinition"
btn_quota_select_all="id:quotaDefinitionGrid-select-all"
btn_delete_quota="id:deleteDefinitionButton"
btn_delete_def="id:confirmation-modal_okButton"

undefined="id:footer-3"

lst_new_quota_namme="id:quotaDefinitionGrid-row-0-definition.name"
lst_new_quota_interval="id:quotaDefinitionGrid-row-0-definition.type"
lst_new_quota_total="id:quotaDefinitionGrid-row-0-definition"
lst_new_quota_color="//*[@id='quotaDefinitionGrid']/ag-grid-angular/div/div[1]/div/div[3]/div[2]/div/div/div/div[4]/lpm-quota-definition-value-renderer"


btn_monthly="id:updateQuotaLimitsGrid"
btn_vary_ok="id:definition_ok_button"
btn_cancel_monthly="id:cancelChanges"

job_name="id:definition_link_0"

quota_name_link="xpath://*[@id='collections-row-0-quotaDefinition.name']/lpm-definition-summary-renderer"


btn_assignquota="id:createUserAssignment"
txt_costcentername="xpath://*[@id='collectionSelectControl']/div"
txt_costcentername_input="id:collectionSelectControl_Input"
lst_costcentername="id:collectionSelectControl-listbox"
lst_quota_def="id:selectQuotaDefinitionControl-listbox"
txt_quota_def="xpath://*[@id='selectQuotaDefinitionControl']/div"


tbl_costcenter_quota="id:collections-row-0-checkbox"
tbl_costcenter_quota_name="id:collections-row-0-quotaDefinition.name"

btn_summary_close="id:definition_summary_close_id"

header_quota_preview="id:quotaPreviewDiv"

txt_email="xpath://*[@id='userSelectControl']/div"
txt_email_input="id:userSelectControl_Input"
lst_email="id:userSelectControl-listbox"

personal_name="id:userAssignmentGrid-row-0-identityEmail"
tbl_email_quota="id:userAssignmentGrid-row-checkbox-0"
tbl_personal_name="id:userAssignmentGrid-row-0-identityEmail"
tbl_email_quota_name="id:userAssignmentGrid-row-0-quotaDefinition.name"

email_quota_link="xpath://*[@id='userAssignmentGrid-row-0-quotaDefinition.name']/lpm-definition-summary-renderer"

lbl_quota_status="id:link-navAdminDropdownUserQuotaStatus"
lbl_totalquotaremaining="id:quotaStatusGrid-row-0-totalQuotaRemaining"
lbl_colorquotaremaining="id:quotaStatusGrid-row-0-colorQuotaRemaining"
icon_condition="xpath://*[@id='quotaStatusGrid-row-0-condition']/lpm-quota-condition-renderer/div/cui-icon"
lbl_quotausername="id:quotaStatusGrid-row-0-identityEmail"

quota_interval="id:definitionLimitsSelectControl-listbox-item-2"
quota_interval_1="id:definitionLimitsSelectControl-listbox-item-1"
month="id:individualQuotaValuesId-row-checkbox-6"
quota_total="id:definitionTotalSelectControl-listbox-item-3"
quota_color="id:customRadioOption_radio_input"

btn_upload="id:printQueueUploadButton"
queue_dropdown="id:printQueuePageHeaderDropDown_button"
txt_search="id:userFilterInput"

lnk_history="id:link-navJobHistory"
monthly_total_id="id:individualQuotaValuesId-row-5-totalQuota"
monthly_color_id="id:individualQuotaValuesId-row-5-colorQuota"

tbl_cc_quota_name="id:collections-row-0-quotaDefinition.name"

fileupload="xpath://*[@id='_Content']/div"

impression_count="id:dataGridMyPrintJobsId-row-0-impressions"

header_costcenter="xpath://*[@id='costCenterTabContent']/lpm-collection-quota-assignments/lpm-collection-quota-assignment-modal/cui-form/form/cui-modal/div/div[2]/div[1]/div/cui-modal-body/cui-priv-block/div/div/div/lpm-collection-select/cui-select/div/cui-label/label"
chk_guestprint="id:enableGuestPrintSubmissionCheckbox"

chk_printandkeep="id:enablePrintKeepCheckbox"