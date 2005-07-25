ad_library {
    Automated tests.

    @author Mounir Lallali
    @creation-date 14 June 2005
   
}

namespace eval faq::twt {

ad_proc new { faq_name } {

        set response 0
	tclwebtest::cookies clear
	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)
	
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 
	
	# Create a new FAQ		
 	tclwebtest::link follow "administer"	
	tclwebtest::link follow	"Create a new FAQ"

	tclwebtest::form find ~n "faq_add_edit"
	tclwebtest::field find ~n "faq_name"
	tclwebtest::field fill "$faq_name"
	tclwebtest::form submit
	aa_log "Faq form submited"

	set response_url [tclwebtest::response url]	
	
        aa_log "$response_url"
	if {[string match "*admin/one-faq*" $response_url] } {
		if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] && [catch {tclwebtest::field find "$faq_name"} errmsg] } {
			aa_error  "twt::faq::new failed $errmsg : Dont't create a New Faq"
		} else {
			aa_log "New faq Created !!"
		        set response 1
		}
	} else {
		aa_error "twt::faq::new failed, bad response url : $response_url"
	}
	twt::user::logout
	return $response
}

ad_proc delete { faq_name} {

        set response 0
	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 
			
 	tclwebtest::link follow "administer"	

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
	::twt::do_request "faq-delete?faq_id=$faq_id"

	set response_url [tclwebtest::response url]	
	
	if { [string match "*admin/*" $response_url] } {
		if {![catch {tclwebtest::link find "$faq_name" } errmsg]} {
			aa_error "twt::faq::delete failed $errmsg : Dont't delete $faq_name Faq"
		} else {
			aa_log "Faq Deleted"
		        set response 1
		}
	} else {
		aa_error "twt::faq::delete failed, bad response url : $response_url"
	}
	twt::user::logout
	return $response
}

ad_proc edit_one { faq_name faq_new_name} {

        set response 0
	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
	 
	# Edit the FAQ and request the FAQ Admin page
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 
			
 	tclwebtest::link follow "administer"		 	
	::twt::do_request "faq-add-edit?faq%5fid=$faq_id"	
	
	tclwebtest::form find ~n "faq_add_edit"
	tclwebtest::field find ~n "faq_name"
	tclwebtest::field fill "$faq_new_name"
	tclwebtest::form submit	
	aa_log " Faq form submited"

	set response_url [tclwebtest::response url]	
	
	if {[string match "*admin/one-faq*" $response_url] } {
		if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] && [catch {tclwebtest::field find "$faq_name"} errmsg] } {
			aa_error  "twt::faq::edit_one failed $errmsg : Dont't Edit a Faq"
		} else {
			aa_log "Faq Edited" 
		        set response 1
		}
	} else {
		aa_error "twt::faq::edit_one failed, bad response url : $response_url"
	}
	twt::user::logout
	return $response
}

ad_proc edit_two { faq_name faq_new_name} {

	set response 0
        tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	# Edit the FAQ and request the FAQ Admin page
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
 	tclwebtest::link follow "administer"
	tclwebtest::link follow "$faq_name"

	# Clic Edit Button
	tclwebtest::form find ~n faq_add_edit
	tclwebtest::form submit
	aa_log " Edit form submited"
	
	tclwebtest::form find ~n "faq_add_edit"
	tclwebtest::field find ~n "faq_name"
	tclwebtest::field fill "$faq_new_name"
	tclwebtest::form submit
	aa_log " Faq form submited"	

	set response_url [tclwebtest::response url]		

	if {[string match "*admin/one-faq*" $response_url] } {
		if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] && [catch {tclwebtest::field find "$faq_name"} errmsg] } {
			aa_error  "twt::faq::edit_two failed $errmsg : Dont't Edit a Faq"
		} else {
			aa_log "Faq Edited"
		        set response 1
		}
	} else {
		aa_error "twt::faq::edit_two failed, bad response url : $response_url"
	}
	twt::user::logout
	return $response 
}

ad_proc disable_enable { faq_name option} {

	# Option : disable or enable

        set response 0
	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)
	
	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"

	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	
	#tclwebtest::link follow ~u "faq-$option?faq_id=$faq_id"
	::twt::do_request "faq-$option?faq_id=$faq_id"			
	
	set response_url [tclwebtest::response url]

	if { [string match "*$faq_page_url*" $response_url] } {
		if {! [catch {tclwebtest::link find ~u "faq-$option?faq%5fid=$faq_id" } errmsg]} {
			aa_error "twt::faq::$option failed $errmsg : Dont't $option $faq_name Faq"
		} else {
			aa_log "Faq $option"
		        set response 1
		}
	} else {
		aa_error "twt::faq::$option failed. Bad  response url : $response_url "
	}
	twt::user::logout
	return $response
}

ad_proc new_Q_A { faq_name question answer} {

        set response 0 
	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "Create New Q&A"
	
	tclwebtest::form find ~n "new_quest_answ"
	tclwebtest::field find ~n "question"
	tclwebtest::field fill "$question"
	tclwebtest::field find ~n "answer"
	tclwebtest::field fill "$answer"
	tclwebtest::form submit	
	aa_log " Faq Question Form submited"
	
	
	set response_url [tclwebtest::response url]

	if { [string match "*admin/one-faq*" $response_url] } {
		if { [catch {tclwebtest::assert text "$question"} errmsg] } { 
			aa_error "twt::faq::new_Q_A :  failed $errmsg : Dont't Create New Question"
		} else {
			aa_log "New Faq Question Created"
		        set response 1
		}
	} else {
		aa_error "twt::faq::new_Q_A failed. Bad  response url : $response_url"
	}
	twt::user::logout
	return $response
}

ad_proc edit_Q_A { faq_name new_question new_answer } {
 
        set response 0 
	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "edit"	
	
	tclwebtest::form find ~n "new_quest_answ"
	tclwebtest::field find ~n "question"
	tclwebtest::field fill "$new_question"
	tclwebtest::field find ~n "answer"
	tclwebtest::field fill "$new_answer"
	tclwebtest::form submit		
	aa_log " Faq Question Form submited"

	set response_url [tclwebtest::response url]

	if { [string match "*admin/one-faq*" $response_url] } {
		if { [catch {tclwebtest::assert text "$new_question"} errmsg] } { 
			aa_error "twt::faq::edit_Q_A :  failed $errmsg : Dont't Edit a Question"
		} else {
			aa_log "Faq Question Edited"
		        set response 1
		}
	} else {
		aa_error "twt::faq::edit_Q_A failed. Bad  response url : $response_url"
	}
	twt::user::logout
	return $response
}

ad_proc preview_Q_A { faq_name } {

	set response 0
        tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "preview"	

	set response_url [tclwebtest::response url]
	set question_text "Q:"
	set answer_text "A:"

	if { [string match "*admin/one-question*" $response_url] } {
		if { [catch {tclwebtest::assert text "$question_text"} errmsg] || [catch {tclwebtest::assert text "$answer_text"} errmsg] } { 
			aa_error "twt::faq::preview_Q_A :  failed $errmsg : Dont't Preview a Question"
		} else {
			aa_log "Faq Question Previewed"
		        set response 1
		}

	} else {
		aa_error "twt::faq::preview_Q_A failed. Bad  response url : $response_url"
	}	
	twt::user::logout
	return $response
}

ad_proc delete_Q_A { faq_name question } {

	set response 0
        tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "delete"	

	set response_url [tclwebtest::response url]
	
	if { [string match "*admin/one-faq*" $response_url] } {	
		if { [catch {tclwebtest::assert text -fail "$question"} errmsg] } { 
			aa_error "twt::faq::delete_Q_A :  failed $errmsg : Dont't  Delete a Question"
		} else {
			aa_log "Faq Question Deleted"
		        set response 1
		}
	} else {
		aa_error "twt::faq::delete_Q_A failed. Bad  response url : $response_url"
	}	
	twt::user::logout
	return $response
}

ad_proc insert_after_Q_A { faq_name } {

	set response 0
        tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "insert after"
	
	set question [ad_generate_random_string] 
	set answer [ad_generate_random_string]
	
	tclwebtest::form find ~n "new_quest_answ"
	tclwebtest::field find ~n "question"
	tclwebtest::field fill "$question"
	tclwebtest::field find ~n "answer"
	tclwebtest::field fill "$answer"
	tclwebtest::form submit	
	aa_log " Faq Question Form submited"
	
	set response_url [tclwebtest::response url]	

	if { [string match "*admin/one-faq*" $response_url] } {
		tclwebtest::link follow "delete"
		if { [catch {tclwebtest::assert text "$question"} errmsg] } { 
			aa_error "twt::faq::insert_after_Q_A :  failed $errmsg : Dont't Insert After a Question"
		} else {
			aa_log "Faq Question inserted after a nother"
		        set response 1
		}
	} else {
		aa_error "twt::faq::insert_after_Q_A failed. Bad  response url : $response_url"
	}	
	twt::user::logout
	return $response
}

ad_proc swap_with_next_Q_A { faq_name } {

	tclwebtest::cookies clear

	# Login user
	array set user_info [twt::user::create -admin]
	twt::user::login $user_info(email) $user_info(password)

	db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
		
	# The Faq page url
	set faq_page_url [aa_get_first_url -package_key faq]	 
	::twt::do_request $faq_page_url 	
				
	tclwebtest::link follow "administer"
	tclwebtest::link follow $faq_name	
	tclwebtest::link follow "swap with next"
		
	set response_url [tclwebtest::response url]
	
	if { [string match "*admin/one-faq*" $response_url] } {
		aa_log "Faq Question swaped with next question"
	        set response 1

	} else {
		aa_error "twt::faq::insert_after_Q_A failed. Bad  response url : $response_url"
	}
	twt::user::logout
	return $response
}
	
}