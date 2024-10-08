#faq/www/admin/q-and-a-edit.tcl

ad_page_contract {

  View contents of one Q&A
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
 
} {
    entry_id:object_type(faq_q_and_a)
} -properties {
    entry_id:onevalue
}

set package_id [ad_conn package_id]

permission::require_permission -object_id $package_id -privilege faq_modify_faq

set action "q-and-a-edit-2"
set submit_label [_ faq.Update_This_QA]

set user_id [ad_conn user_id]

db_1row q_and_a_info "select question, answer,faq_name,qa.faq_id
                      from faq_q_and_as qa, faqs f
                      where entry_id = :entry_id
                      and f.faq_id = qa.faq_id"

set context [list [list "one-faq?faq_id=$faq_id" "$faq_name"] "One Q&A"]

set delete_url [export_vars -base q-and-a-delete { entry_id faq_id }]

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
