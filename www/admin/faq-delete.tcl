#/faq/admin/faq-delete.tcl

ad_page_contract {
    
    delete an FAQ, also deletes entries in acs_named_objects for categories
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24

} {

    faq_id:naturalnum,notnull

}
set package_id [ad_conn package_id]

permission::require_permission -object_id  $package_id -privilege faq_delete_faq

db_exec_plsql delete_faq {}

ad_returnredirect "index"
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
