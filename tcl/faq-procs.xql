<?xml version="1.0"?>
<queryset>

    <fullquery name="faq::notification::get_url.get_faq_id">
        <querytext>	
        select faq_id from faq_q_and_as 
        where entry_id = $q_and_a_id
        </querytext>
    </fullquery>

</queryset>










