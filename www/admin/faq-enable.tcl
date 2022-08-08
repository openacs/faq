ad_page_contract {
    
    enable an FAQ
    @author Lars Pind (lars@collaboraid.biz)
    @creation-date 2003-03-06

} {
    faq_id:object_type(faq)
    {referer:localurl "index"}
}
set package_id [ad_conn package_id]

permission::require_permission -object_id $package_id -privilege faq_delete_faq 

db_dml disable_faq {
    update faqs set disabled_p = 'f' where faq_id = :faq_id
}

ad_returnredirect $referer
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
