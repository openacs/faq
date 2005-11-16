ad_library {

    Faq Library - Reply Handling

    @creation-date 2004-03-31
    @author Ben Adida <ben@openforce.biz>
    @Modifyed by Gerardo Morales <gmorales@galileo.edu>
}

namespace eval faq {
    ad_proc -public get_package_id {
        -community_id
    } {
        if {[info exist community_id]} { } else { set community_id [ad_conn community_id] }

        db_1row get_faqs_package {}
        return $package_id
        
    }


    ad_proc -public faq_new {
        -package_id
        {-separate_p "f"}
        -faq_name:required
    } {
        if {[info exist package_id]} { } else { set package_id [ad_conn package_id] }
        set faq_id [db_nextval acs_object_id_seq]
        set user_id [ad_conn user_id]
        set creation_ip [ad_conn host]

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

    return $faq_id
        
    }


}



namespace eval faq::notification {

    ad_proc -public get_url {
        object_id
    } {
        returns a full url to the object_id.
        handles messages and forums.
    } { 

	    set q_and_a_id $object_id
            db_1row get_faq_id "*SQL*"
	    set faq_url  "[ad_url][ad_conn package_url]"
	    return ${faq_url}one-faq?faq_id=$faq_id

    }
}


