ad_page_contract {

  View contents of one faq. Filter by categories if enabled
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @author Nima Mazloumi (nima.mazloumi@gmx.de)
    @creation-date 2000-10-24

} {
    {category_id:object_type(category) {}}
    faq_id:object_type(faq)
}

#/faq/www/one-faq.tcl

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

permission::require_permission -object_id $package_id -privilege faq_view_faq

faq::get_instance_info -arrayname faq_info -faq_id $faq_id

if { ![info exists faq_info(faq_name)] } {
    ns_returnnotfound
    ad_script_abort
}

set context [list $faq_info(faq_name)]

# Use Categories?
set use_categories_p [parameter::get -parameter "EnableCategoriesP" -default 0]

if { $use_categories_p == 1 && $category_id ne "" } {
    db_multirow one_question categorized_faq "" {}
} else {
    db_multirow one_question uncategorized_faq "" {}
}


# Site-Wide Categories
if { $use_categories_p == 1} {
    set package_url [ad_conn package_url]
    if { $category_id ne "" } {
        set category_name [category::get_name $category_id]
        if { $category_name eq "" } {
            ad_return_exception_page 404 "No such category" \
                "Site-wide Category with ID $category_id doesn't exist"
            ad_script_abort
        }

        # Replace last element of context (the FAQ name) with link to that FAQ and current category name
        set context [lreplace $context end end [list "one-faq?faq_id=$faq_id" $faq_info(faq_name)] $category_name]
    }

    db_multirow -unclobber -extend { category_name tree_name } categories faq_categories "" {
        set category_name [category::get_name $category_id]
        set tree_name [category_tree::get_name $tree_id]
    }
}

set return_url [export_vars -base [ad_conn url] {faq_id}]

if { [namespace which ::general_comments_create_link] ne ""
     && [parameter::get -package_id $package_id -parameter GeneralCommentsP -default 0] } {
    set gc_link [general_comments_create_link -link_attributes { title="#general-comments.Add_comment#" } $faq_id $return_url]
    set gc_comments [general_comments_get_comments $faq_id $return_url]
} else {
    set gc_link ""
    set gc_comments ""
}

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
