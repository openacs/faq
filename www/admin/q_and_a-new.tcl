#faq/www/admin/q_and_a-new.tcl

ad_page_contract {

    Displays a form for creating a new Q&A.

    @author Elizabeth Wirth (wirth@ybos.net)
    @author Jennie Housman (jennie@ybos.net)
    @creation-date 2000-10-24
} {

    entry_id:naturalnum,optional
    faq_id:naturalnum,notnull

}  -properties {
    context_bar:onevalue
    entry_id:onevalue
    title:onevalue
    action:onevalue
    submit_label:onevalue
    question:onevalue
    answer:onevalue
}

ad_require_permission [ad_conn package_id] faq_create_faq

db_1row get_name "select faq_name from faqs where faq_id=:faq_id"

set page_title "Add Q&A for $faq_name"
set context_bar [list [list "one-faq?faq_id=$faq_id" "$faq_name"] "Create new Q&A"]
set title "Create new Q&A"
set target "q_and_a-new-2"
set submit_label "Create Q&A"
set question ""
set answer ""
set insert_p "f"

if { [info exists entry_id]} {
    set insert_p "t"
}

set mime_type ""

ad_return_template 

