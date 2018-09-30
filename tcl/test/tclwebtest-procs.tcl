ad_library {
    Automated tests.

    @author Mounir Lallali
    @creation-date 14 June 2005

}

namespace eval faq::twt {

    ad_proc new { faq_name } {
        Adds a FAQ from the UI.
    } {
        set response 0
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
        aa_log "Faq form submitted"

        set response_url [tclwebtest::response url]

        aa_log "$response_url"
        if {[string match "*admin/one-faq*" $response_url] } {
            if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] || [catch {tclwebtest::field find ~v "$faq_name"} errmsg] } {
                aa_error  "faq::twt::new failed $errmsg : Don't create a New Faq"
            } else {
                aa_log "New faq Created !!"
                set response 1
            }
        } else {
            aa_error "faq::twt::new failed, bad response url : $response_url"
        }

        return $response
    }

    ad_proc delete { faq_name } {
        Deletes a FAQ from the UI.
    } {
        set response 0

        # The Faq page url
        set faq_page_url [aa_get_first_url -package_key faq]
        ::twt::do_request $faq_page_url

        tclwebtest::link follow "administer"

        db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"
        ::twt::do_request [export_vars -base "faq-delete" {faq_id}]

        set response_url [tclwebtest::response url]

        if { [string match "*admin/*" $response_url] } {
            if {![catch {tclwebtest::link find "$faq_name" } errmsg]} {
                aa_error "faq::twt::delete failed $errmsg : Don't delete $faq_name Faq"
            } else {
                aa_log "Faq Deleted"
                set response 1
            }
        } else {
            aa_error "faq::twt::delete failed, bad response url : $response_url"
        }

        return $response
    }

    ad_proc edit_one { faq_name faq_new_name } {
        Edits a FAQ from the UI by decoding faq_name and retrieving
        directly edit URL by faq_id.
    } {
        set response 0

        db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"

        # Edit the FAQ and request the FAQ Admin page
        # The Faq page url
        set faq_page_url [aa_get_first_url -package_key faq]
        ::twt::do_request $faq_page_url

        tclwebtest::link follow "administer"
        ::twt::do_request [export_vars -base "faq-add-edit" {faq_id}]

        tclwebtest::form find ~n "faq_add_edit"
        tclwebtest::field find ~n "faq_name"
        tclwebtest::field fill "$faq_new_name"
        tclwebtest::form submit
        aa_log " Faq form submitted"

        set response_url [tclwebtest::response url]

        if {[string match "*admin/one-faq*" $response_url] } {
            if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] || [catch {tclwebtest::field find ~v "$faq_new_name"} errmsg] } {
                aa_error  "faq::twt::edit_one failed $errmsg : Don't Edit a Faq"
            } else {
                aa_log "Faq Edited"
                set response 1
            }
        } else {
            aa_error "faq::twt::edit_one failed, bad response url : $response_url"
        }

        return $response
    }

    ad_proc edit_two { faq_name faq_new_name } {
        Edits a FAQ from the UI by simulating clicks to the edit page.
    } {
        set response 0

        # Edit the FAQ and request the FAQ Admin page
        # The Faq page url
        set faq_page_url [aa_get_first_url -package_key faq]
        ::twt::do_request $faq_page_url

        tclwebtest::link follow "administer"
        tclwebtest::link follow "$faq_name"

        # Clic Edit Button
        tclwebtest::form find ~n faq_add_edit
        tclwebtest::form submit
        aa_log " Edit form submitted"

        tclwebtest::form find ~n "faq_add_edit"
        tclwebtest::field find ~n "faq_name"
        tclwebtest::field fill "$faq_new_name"
        tclwebtest::form submit
        aa_log " Faq form submitted"

        set response_url [tclwebtest::response url]

        if {[string match "*admin/one-faq*" $response_url] } {
            if { [catch {tclwebtest::form find ~n "faq_add_edit"} errmsg] || [catch {tclwebtest::field find ~v "$faq_new_name"} errmsg] } {
                aa_error  "faq::twt::edit_two failed $errmsg : Don't Edit a Faq"
            } else {
                aa_log "Faq Edited"
                set response 1
            }
        } else {
            aa_error "faq::twt::edit_two failed, bad response url : $response_url"
        }

        return $response
    }

    ad_proc disable_enable {faq_name option} {
        Toggle enable/disable for a FAQ from the UI.
    } {
    # Option : disable or enable

        set response 0

        db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"

        # The Faq page url
        set faq_page_url [aa_get_first_url -package_key faq]
        ::twt::do_request $faq_page_url

        tclwebtest::link follow "administer"
        set optionurl [export_vars -base "faq-${option}" {faq_id}]
        ::twt::do_request $optionurl
        aa_log "url:$optionurl"

        set response_url [tclwebtest::response url]

        if { [string match "*$faq_page_url*" $response_url] } {
            if {![catch {tclwebtest::link find ~u  $optionurl } errmsg]} {
                aa_error "faq::twt::$option failed $errmsg : Don't $option $faq_name Faq"
            } else {
                aa_log "Faq $option"
                set response 1
            }
        } else {
            aa_error "faq::twt::$option failed. Bad  response url : $response_url "
        }

        return $response
    }

    ad_proc new_Q_A { faq_name question answer} {
        Creates a new Question/Answer from the UI.
    } {
        set response 0

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
        aa_log " Faq Question Form submitted"


        set response_url [tclwebtest::response url]

        if { [string match "*admin/one-faq*" $response_url] } {
            if { [catch {tclwebtest::assert text "$question"} errmsg] } {
                aa_error "faq::twt::new_Q_A :  failed $errmsg : Don't Create New Question"
            } else {
                aa_log "New Faq Question Created"
                set response 1
            }
        } else {
            aa_error "faq::twt::new_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

    ad_proc edit_Q_A { faq_name new_question new_answer } {
        Edits a Question/Answer from the UI.
    } {
        set response 0

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
        aa_log " Faq Question Form submitted"

        set response_url [tclwebtest::response url]

        if { [string match "*admin/one-faq*" $response_url] } {
            if { [catch {tclwebtest::assert text "$new_question"} errmsg] } {
                aa_error "faq::twt::edit_Q_A :  failed $errmsg : Don't Edit a Question"
            } else {
                aa_log "Faq Question Edited"
                set response 1
            }
        } else {
            aa_error "faq::twt::edit_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

    ad_proc preview_Q_A { faq_name } {
        Gets preview of a Question/Answer from the UI.
    } {
        set response 0

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
                aa_error "faq::twt::preview_Q_A :  failed $errmsg : Don't Preview a Question"
            } else {
                aa_log "Faq Question Previewed"
                set response 1
            }

        } else {
            aa_error "faq::twt::preview_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

    ad_proc delete_Q_A { faq_name question } {
        Deletes a Question/Answer from the UI.
    } {
        set response 0

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
                aa_error "faq::twt::delete_Q_A :  failed $errmsg : Don't  Delete a Question"
            } else {
                aa_log "Faq Question Deleted"
                set response 1
            }
        } else {
            aa_error "faq::twt::delete_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

    ad_proc insert_after_Q_A { faq_name } {
        Inserts a Question/Answer after another existing one from the
        UI.
    } {
        set response 0

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
        aa_log " Faq Question Form submitted"

        set response_url [tclwebtest::response url]

        if { [string match "*admin/one-faq*" $response_url] } {
            tclwebtest::link follow "delete"
            if { [catch {tclwebtest::assert text "$question"} errmsg] } {
                aa_error "faq::twt::insert_after_Q_A :  failed $errmsg : Don't Insert After a Question"
            } else {
                aa_log "Faq Question inserted after another"
                set response 1
            }
        } else {
            aa_error "faq::twt::insert_after_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

    ad_proc swap_with_next_Q_A { faq_name } {
        Swaps two adjacent questions in the FAQ from the UI.
    } {
        set response 0

        db_1row faq_id "select faq_id from faqs where faq_name=:faq_name"

        # The Faq page url
        set faq_page_url [aa_get_first_url -package_key faq]
        ::twt::do_request $faq_page_url

        tclwebtest::link follow "administer"
        tclwebtest::link follow $faq_name
        tclwebtest::link follow "swap with next"

        set response_url [tclwebtest::response url]

        if { [string match "*admin/one-faq*" $response_url] } {
            aa_log "Faq Question swapped with next question"
            set response 1

        } else {
            aa_error "faq::twt::insert_after_Q_A failed. Bad  response url : $response_url"
        }

        return $response
    }

}
# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
