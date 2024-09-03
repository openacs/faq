ad_page_contract {

} {
    object_id:object_type(acs_object)
    faq_id:object_type(faq)
}

set container_id [ad_conn [parameter::get -parameter CategoryContainer -default package_id]]

# get faq info for breadcrumbs
faq::get_instance_info -arrayname faq_info -faq_id $faq_id

set context [list [list "../one-faq?faq_id=$faq_id" $faq_info(faq_name)] Categorize]

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
