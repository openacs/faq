#faq/www/one-question.tcl

ad_page_contract {

  View contents of one Q&A
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
 
} {
    entry_id:object_type(faq_q_and_a)
}

set package_id [ad_conn package_id]

permission::require_permission -object_id $package_id -privilege faq_view_faq

db_1row question_info {}

set context [list [list "one-faq?faq_id=$faq_id" $faq_name] [_ faq.One_Question]]

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
