ad_page_contract { 
    Displays a form for creating a new faq or edit an existing faq. 
    @author Rocael Hernandez (roc@viaro.net) 
    @author Gerardo Morales Cadoret (gmorales@galileo.edu) 
    @creation-date 2003-11-26 
} {  
    faq_id:optional 
} -properties { 
    context:onevalue 
    faq_id:onevalue 
    title:onevalue 
    action:onevalue 
    submit_label:onevalue 
    faq_name:onevalue 
   
} 
 
set context {[_ faq.Create_an_FAQ]} 
set submit_label [_ faq.Create_FAQ] 
set faq_name "" 
set package_id [ad_conn package_id] 
set user_id [ad_verify_and_get_user_id] 
set creation_ip [ad_conn host] 

if { ![ad_form_new_p -key faq_id]} { 
    set context {[_ faq.Edit_an_FAQ]}
    set page_title [_ faq.Edit_an_FAQ] 
    permission::require_permission -object_id [ad_conn package_id] -privilege faq_modify_faq 
} else { 
    set context {[_ faq.Create_an_FAQ]}
    set page_title [_ faq.Create_an_FAQ]
    permission::require_permission -object_id [ad_conn package_id] -privilege faq_create_faq 
} 

ad_form -name faq_add_edit -export { } -form {

        faq_id:key
	{faq_name:text(text) {label "FAQ Name"} {html { size 20 }}}
	{separate_p:text(select) {label "Category"} { options {{No f} {Yes t}} } }

    } -select_query {
	select faq_name,separate_p from faqs where faq_id = :faq_id
    } -new_data {
	db_exec_plsql create_faq { *SQL* }
    } -edit_data {
db_dml faq_edit "update faqs  
                  set faq_name = :faq_name, 
                  separate_p = :separate_p 
                  where faq_id = :faq_id" 
    } -after_submit {
        ad_returnredirect "/faq/admin"
        ad_script_abort
    }

