#faq/www/admin/faq-edit-2.tcl

ad_page_contract {

    Edits a particular FAQ

    @author Peter Vessenes peterv@ybos.net
    @creation-date 2000-10-25
} {
    faq_id:object_type(faq)
    faq_name:notnull
    separate_p:oneof(t|f)
} 

permission::require_permission -object_id [ad_conn package_id] -privilege faq_modify_faq

db_dml faq_edit "update faqs 
                  set faq_name = :faq_name,
                  separate_p = :separate_p
                  where faq_id = :faq_id"

ad_returnredirect "."
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
