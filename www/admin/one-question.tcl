#/faq/www/admin/one-question.tcl

ad_page_contract {

  View contents of one Q&A
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
 
} {

    entry_id:naturalnum,notnull
} -properties {
    entry_id:onevalue
}

set package_id [ad_conn package_id]

set user_id [ad_verify_and_get_user_id]

ad_require_permission $package_id faq_admin_faq


db_1row q_and_a_info "select question, answer, a.faq_id, f.faq_name  
      from faq_q_and_as a, faqs f 
      where entry_id = :entry_id
      and a.faq_id = f.faq_id"

set context_bar [list [list "one-faq?faq_id=$faq_id" "$faq_name"] "One Q&A"]
ad_return_template
