ad_page_contract {
} {
    object_id:object_type(acs_object)
    cat:object_type(category)
}

db_dml nuke {delete from category_object_map where category_id = :cat and object_id = :object_id}

ad_returnredirect -message "removed category" [util::get_referrer]
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
