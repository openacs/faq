ad_library {
    callback routines for faq package 
    @author Luis de la Fuente (lfuente@it.uc3m.es)
    @creation_date 2005-07-08
}

ad_proc -public -callback datamanager::move_faq -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Move a faq to another class or community
} {

db_dml update_faqs {}
}
