ad_library {
    callback routines for faq package 
    @author Luis de la Fuente (lfuente@it.uc3m.es)
    @creation_date 2005-07-08
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
    
