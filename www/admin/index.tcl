#faq/www/admin/index.tcl

ad_page_contract {

    Admin for FAQs on this site

    @author Jennie Housman (jennie@ybos.net)
    @author Elizabeth Wirth (wirth@ybos.net)
    @creation-date 2000-10-24
   
} {
} -properties {
  context_bar:onevalue
  package_id:onevalue
  user_id:onevalue
}

set package_id [ad_conn package_id]

ad_require_permission $package_id faq_admin_faq


set context_bar {}

set user_id [ad_verify_and_get_user_id]



db_multirow faqs faq_select {
    select faq_id, faq_name
      from acs_objects o, faqs f
      where object_id = faq_id
        and context_id = :package_id
    order by faq_name
}

ad_return_template
