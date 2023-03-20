#faq/www/admin/faq-new-2.tcl

ad_page_contract {

    Create a new faq.
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24

    @param faq_id    The ID of the new faq to be created (debounce)
    @param faq_name  The short name of the faq

} {
    faq_id:object_id,notnull
    faq_name:notnull,trim
    separate_p:boolean,notnull
}

permission::require_permission -object_id $package_id -privilege faq_create_faq

faq::new \
    -faq_id $faq_id \
    -faq_name $faq_name \
    -separate=$separate_p

ad_returnredirect "."
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
