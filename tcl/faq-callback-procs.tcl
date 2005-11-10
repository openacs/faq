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
    
    db_transaction {
        db_dml update_faqs_q_and_a {}
        db_dml update_faqs {}
    } on_error {
        ad_return_error "Database error" "A database error occured:<pre>$errmsg</pre>"
    }
}


ad_proc -public -callback datamanager::delete_faq -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Move a faq to the trash
} {
set trash_id [datamanager::get_trash_id]
set trash_package_id [datamanager::get_trash_package_id]    
    db_transaction {
        db_dml del_update_faqs_q_and_a {}
        db_dml del_update_faqs {}
    } on_error {
        ad_return_error "Database error" "A database error occured:<pre>$errmsg</pre>"
    }
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

#Callbacks for application-track

ad_proc -callback application-track::getApplicationName -impl faqs {} { 
        callback implementation 
    } {
        return "faqs"
    }    
    
ad_proc -callback application-track::getGeneralInfo -impl faqs {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(f.faq_id) as result
			from faqs f, acs_objects o, dotlrn_communities com
		    	where o.object_id=f.faq_id
			and com.community_id=:comm_id
			and apm_package__parent_id(o.context_id) = com.package_id	
	}
	
	return "$result"
    }
    
ad_proc -callback application-track::getSpecificInfo -impl faqs {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select f.faq_name as name,f1.question as question,f1.answer as answer
			from faqs f, acs_objects o, dotlrn_communities com,faq_q_and_as f1
		    	where o.object_id=f.faq_id
			and com.community_id=:class_instance_id
			and apm_package__parent_id(o.context_id) = com.package_id
			and f.faq_id = f1.faq_id
 }
		
	set my_elements {
    		name {
	            label "Name"
	            display_col name	                        
	 	    html {align center}
	 	               
	        }
	        questions {
	            label "Questions"
	            display_col question 	      	              
	 	    html {align center} 	 	                
	        }
	        questions {
	            label "Answers"
	            display_col answer 	      	              
	 	    html {align center}	 	                
	        }
        
	}

        return "OK"
    }
    