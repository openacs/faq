ad_page_contract {

  View contents of one faq. Filter by categories if enabled
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @author Nima Mazloumi (nima.mazloumi@gmx.de)
    @creation-date 2000-10-24
 
} {
    {category_id:integer,optional {}}
    faq_id:naturalnum,notnull
}

#/faq/www/one-faq.tcl

set package_id [ad_conn package_id]

set user_id [ad_conn user_id]

ad_require_permission $package_id faq_view_faq

db_1row faq_info "select faq_name, separate_p from faqs where faq_id=:faq_id"

set context [list $faq_name]

# Use Categories?
set use_categories_p [parameter::get -parameter "EnableCategoriesP" -default 0]

if { $use_categories_p == 1 && [exists_and_not_null category_id] } {

    set select_sql_query "select entry_id, faq_id, question, answer, sort_key
from faq_q_and_as qa, category_object_map com, acs_named_objects nam
where faq_id = :faq_id and
com.object_id = qa.entry_id and
nam.package_id = :package_id and
com.object_id = nam.object_id and 
com.category_id = :category_id
order by sort_key"

} else {

    set select_sql_query "select entry_id, faq_id, question, answer, sort_key
from faq_q_and_as
where faq_id = :faq_id
order by sort_key"
}

db_multirow one_question q_and_a_info $select_sql_query

# Site-Wide Categories
if { $use_categories_p == 1} {
    set package_url [ad_conn package_url]      
    if { ![empty_string_p $category_id] } {
	set category_name [category::get_name $category_id]
	if { [empty_string_p $category_name] } {
	    ad_return_exception_page 404 "No such category" "Site-wide \
          Category with ID $category_id doesn't exist"
            return
	}
	# Show Category in context bar
	append context_base_url /cat/$category_id
	lappend context [list $context_base_url $category_name]
	set type "all"
    }
    
    # Cut the URL off the last item in the context bar
    if { [llength $context] > 0 } {
        set context [lreplace $context end end [lindex [lindex $context end] end]]
    }
    
    db_multirow -unclobber -extend { category_name tree_name } categories categories {
	select c.category_id as category_id, c.tree_id
	from   categories c, category_tree_map ctm
	where  ctm.tree_id = c.tree_id
	and    ctm.object_id = :package_id
    } {
	set category_name [category::get_name $category_id]
	set tree_name [category_tree::get_name $tree_id]
    }
}

set notification_chunk [notification::display::request_widget \
                        -type one_faq_qa_notif \
                        -object_id $faq_id \
                        -pretty_name $faq_name \
                        -url [ad_conn url]?faq_id=$faq_id \
                        ]

ad_return_template
