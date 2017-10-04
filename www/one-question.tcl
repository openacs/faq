#faq/www/one-question.tcl

ad_page_contract {

  View contents of one Q&A
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
 
} {
    entry_id:naturalnum,notnull
}

set package_id [ad_conn package_id]

permission::require_permission -object_id $package_id -privilege faq_view_faq

if {![db_0or1row question_info {}]} {
    ad_return_complaint 1 [_ faq.lt_no_questions]
    ad_script_abort
}

set context [list [list "one-faq?faq_id=$faq_id" $faq_name] [_ faq.One_Question]]

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
