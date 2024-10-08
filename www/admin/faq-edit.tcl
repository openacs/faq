#faq/www/admin/faq-edit.tcl

ad_page_contract {

    Displays a form for editing a faq.

    @author Peter Vessenes peterv@ybos.net
    @creation-date 2000-10-25
} {
    faq_id:object_type(faq)
} -properties {
    context:onevalue
    faq_id:onevalue
    title:onevalue
    faq_name:onevalue
    separate_p:onevalue
}


permission::require_permission -object_id [ad_conn package_id] -privilege faq_modify_faq

set context [list [_ faq.Edit_an_FAQ]]
set title [_ faq.Edit_an_FAQ]
set action "faq-edit-2"
set submit_label [_ faq.Update_FAQ]

db_1row faq_get_name "select faq_name,separate_p from faqs where faq_id = :faq_id"

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
