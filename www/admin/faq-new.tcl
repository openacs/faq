#faq/www/admin/faq-new.tcl

ad_page_contract {

    Displays a form for creating a new faq.

    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
} {
} -properties {
    context_bar:onevalue
    faq_id:onevalue
    title:onevalue
    action:onevalue
    submit_label:onevalue
    faq_name:onevalue
  
}

ad_require_permission [ad_conn package_id] faq_create_faq

set context_bar {"Create an FAQ"}
set title "Create an FAQ"
set action "faq-new-2"
set submit_label "Create FAQ"
set faq_name ""


set faq_id [db_nextval acs_object_id_seq]

ad_return_template 

