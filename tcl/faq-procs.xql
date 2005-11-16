<?xml version="1.0"?>
<queryset>

    <fullquery name="faq::notification::get_url.get_faq_id">
        <querytext>	
        select faq_id from faq_q_and_as 
        where entry_id = $q_and_a_id
        </querytext>
    </fullquery>

    <fullquery name="faq::get_package_id.get_faqs_package">
        <querytext>
            SELECT package_id
            FROM dotlrn_community_applets
            WHERE community_id = :community_id and applet_id = (select applet_id from dotlrn_applets where applet_key = 'dotlrn_faq')
        </querytext>
    </fullquery>

    <fullquery name="faq::faq_new.create_faq">      
      <querytext>
	  select faq__new_faq (:faq_id, :faq_name,:separate_p,'faq', now(), :user_id,:creation_ip,:package_id);
      </querytext>
</fullquery>

</queryset>










