ad_library {

    Faq Library - Reply Handling

    @creation-date 2004-03-31
    @author Ben Adida <ben@openforce.biz>
    @author by Gerardo Morales <gmorales@galileo.edu>
}

namespace eval faq {

    ad_proc -public get_instance_info {
        -arrayname:required
        -faq_id:required
    } {
        returns the name of the FAQ and whether to display
        questions and their answers all on the listing page
        or on separate pages
    } {
        upvar $arrayname faq_info
        db_0or1row get_info "" -column_array faq_info
    }

    ad_proc -public new {
        -faq_id
        -faq_name:required
        -separate:boolean
        {-package_id ""}
        {-user_id ""}
        {-creation_ip ""}
    } {
        Creates a new FAQ.

        @return integer faq_id
    } {
        if {![info exists faq_id]} {
            set faq_id [db_nextval acs_object_id_seq]
        }

        if {[ns_conn isconnected]} {
            if {$package_id eq ""} {
                set package_id [ad_conn package_id]
            }
            if {$user_id eq ""} {
                set user_id [ad_conn user_id]
            }
            if {$creation_ip eq ""} {
                set creation_ip [ad_conn host]
            }
        }

        db_exec_plsql create_faq {}

        return $faq_id
    }

}

namespace eval faq::notification {

    ad_proc -private get_url {
        object_id
    } {
        This proc implements the GetURL operation of the
        NotificationType Service Contract and should not be invoked
        directly.

        @return a full URL to the object_id (an FAQ entry)
    } {

        set q_and_a_id $object_id
        db_1row get_faq_id "*SQL*"
        set faq_url  "[ad_url][ad_conn package_url]"
        return ${faq_url}one-faq?faq_id=$faq_id

    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
