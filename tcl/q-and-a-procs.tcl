ad_library {

    Faq Library - Reply Handling
    @creation-date 2004-04-02
    @author Gerardo Morales <gmorales@galileo.edu>
}


namespace eval faq::notification_delivery {

    ad_proc -public do_notification {
        question
        answer
        entry_id
        faq_id
        user_id
    } {
        Issues notifications for a FAQ
    } {
        set faq_name [db_string select_faq_name {
            select faq_name from faqs
            where faq_id = :faq_id
        }]
        set name [person::name -person_id $user_id]
        set email [party::email -party_id $user_id]

        set faq_url [faq::notification::get_url $entry_id]

        set q_a_text [ns_reflow_text -- "Question: $question\nAnswer: $answer"]
        set text_version [subst {Faq: $faq_name\nAuthor: $name ($email)\n\n$q_a_text\n\n--To view the entire FAQ go to: $faq_url}]

        set new_content $text_version
        set package_id [ad_conn package_id]

        # Notifies the users that requested notification for the specific FAQ
        notification::new \
            -type_id [notification::type::get_type_id \
                          -short_name one_faq_qa_notif] \
            -object_id $faq_id \
            -response_id $entry_id \
            -notif_subject "New Q&A of $faq_name" \
            -notif_text $new_content

        # Notifies the users that requested notification for all FAQ's
        notification::new \
            -type_id [notification::type::get_type_id \
                          -short_name all_faq_qa_notif] \
            -object_id $package_id \
            -response_id $entry_id \
            -notif_subject "New Q&A of $faq_name" \
            -notif_text $new_content
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
