ad_page_contract {

} {
    object_id:integer
}

set container_id [ad_conn [parameter::get -parameter CategoryContainer -default package_id]]

set context Categorize

ad_return_template
