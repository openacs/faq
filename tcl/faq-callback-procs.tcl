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

db_1row get_faqs_package {}

db_dml update_faqs_q_and_a {}
db_dml update_faqs {}
}


ad_proc -public -callback datamanager::delete_faq -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Move a faq to the trash
} {
set trash_id [datamanager::get_trash_id]
set trash_package_id [datamanager::get_trash_package_id]    
    
db_dml del_update_faqs_q_and_a {}
db_dml del_update_faqs {}
}


ad_proc -public -callback datamanager::copy_faq -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Copy a faq to another class or community. Q&A are also copied
} {

#get data about the faq
   db_1row get_faq_package_id {}
   db_1row get_faq_name {}

   set user_id [ad_conn user_id]
   set creation_ip [ad_conn host]
   set faq_id [db_nextval acs_object_id_seq]
 
   
#then, the faq is copied
    db_transaction {
        db_exec_plsql create_faq {
        begin
          :1 := faq.new_faq (
                faq_id => :faq_id,
                    faq_name => :faq_name,
                separate_p => :separate_p,
                creation_user => :user_id,
                        creation_ip => :creation_ip,
                    context_id => :package_id
                );
        end;
        }
    }

#get list of Q&A (ids)
   set q_a_list [db_list_of_lists get_q_a_list {}]      

   set q_a_number [llength $q_a_list]

#for each Q&A, one entry
     for {set i 0} {$i < $q_a_number} {incr i} {

       set one_question [lindex [lindex $q_a_list $i] 0]
       set one_answer [lindex [lindex $q_a_list $i] 1]
       set entry_id [db_nextval acs_object_id_seq]
       set sort_key $entry_id
       
        db_transaction {
            db_exec_plsql create_q_and_a {
                begin
                    :1 := faq.new_q_and_a (
                        entry_id => :entry_id,
                        context_id => :faq_id,
                faq_id=> :faq_id,            
                        question => :one_question,
                        answer => :one_answer,
                sort_key => :sort_key,
                        creation_user => :user_id,
                        creation_ip => :creation_ip
                    );
                end;
            }
        }
    }    
}
