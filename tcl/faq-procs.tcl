ad_library {

    Faq Library - Reply Handling

    @creation-date 2004-03-31
    @author Ben Adida <ben@openforce.biz>
    @Modifyed by Gerardo Morales <gmorales@galileo.edu>
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
