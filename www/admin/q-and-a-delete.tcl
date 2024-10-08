#faq/www/admin/q-and-a-delete.tcl

ad_page_contract {
    
    delete a QandA
    @author peterv@ybos.net
    @creation-date 2000-10-25

} {
    entry_id:object_type(faq_q_and_a)
}

# We need to rethink the q-and-a permissioning.

permission::require_permission -object_id [ad_conn package_id] -privilege faq_delete_faq

db_1row get_faq_id "select faq_id from faq_q_and_as where entry_id=:entry_id"

db_exec_plsql delete_entry {}

ad_returnredirect "one-faq?faq_id=$faq_id"
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
