ad_library {
    Automated tests for faqs-callbacks.

    @author Luis de la Fuente (lfuente@it.uc3m.es)
    @creation-date 15 November 2005
}

aa_register_case faq_move {
    Test the cabability of moving faqs.
} {    

    aa_run_with_teardown \
        -rollback \
        -test_code {
            #Create origin
            set origin_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            #Create destiny
            set destiny_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            #set packages...
            set origin_package_id [faq::get_package_id -community_id $origin_club_key]
            set destiny_package_id [faq::get_package_id -community_id $destiny_club_key]

            #create faq
            set faq_name [ad_generate_random_string]
            set faq_id [faq::faq_new -package_id $origin_package_id -faq_name $faq_name]
            
            #move the faq
            callback -catch datamanager::move_faq -object_id $faq_id -selected_community $destiny_club_key

            #check operations
            set dest_success_p [db_string dest_success_p {
                select 1 from acs_objects where object_id = :faq_id and package_id = :destiny_package_id
            } -default "0"]

            set orig_success_p [db_string orig_success_p {
                select 0 from acs_objects where object_id = :faq_id and package_id = :origin_package_id
            } -default "1"]

            if { $orig_success_p == 1 &&  $dest_success_p == 1 } { set success_p 1 } else { set success_p 0}
            aa_equals "Faq was moved succesfully" $success_p 1
        }
}

aa_register_case faq_copy {
    Test the cabability of copying faqs.
} {    

    aa_run_with_teardown \
        -rollback \
        -test_code {
            #Create origin
            set origin_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            #Create destiny
            set destiny_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            #set packages...
            set origin_package_id [faq::get_package_id -community_id $origin_club_key]
            set destiny_package_id [faq::get_package_id -community_id $destiny_club_key]

            #create faq
            set faq_name [ad_generate_random_string]
            set faq_id [faq::faq_new -package_id $origin_package_id -faq_name $faq_name]
            
            #copy the faq
            set new_faq_id [callback -catch datamanager::copy_faq -object_id $faq_id -selected_community $destiny_club_key]
            #check operations
            set dest_success_p [db_string dest_success_p {
                select 1 from acs_objects where object_id = :new_faq_id and package_id = :destiny_package_id
            } -default "0"]

            set orig_success_p [db_string orig_success_p {
                select 1 from acs_objects where object_id = :faq_id and package_id = :origin_package_id
            } -default "0"]

            aa_equals "Faq was keeped at origin succesfully" $orig_success_p 1
            aa_equals "Faq was created succesfully" $dest_success_p 1
        }
}
