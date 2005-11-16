<?xml version="1.0"?>
<queryset>

<fullquery name="callback::datamanager::move_faq::impl::datamanager.update_faqs">
<querytext>
    update acs_objects
	set context_id = :new_package_id,package_id=:new_package_id
    where object_id = :object_id
</querytext>
</fullquery>

<fullquery name="callback::datamanager::move_faq::impl::datamanager.update_faqs_q_and_a">
<querytext>
    update acs_objects
	set package_id = :new_package_id
    where context_id = :object_id
</querytext>
</fullquery>


<fullquery name="callback::datamanager::delete_faq::impl::datamanager.del_update_faqs">
<querytext>
    UPDATE acs_objects
	SET context_id = :trash_package_id,package_id=:trash_package_id
    WHERE object_id = :object_id
</querytext>
</fullquery>

<fullquery name="callback::datamanager::delete_faq::impl::datamanager.del_update_faqs_q_and_a">
<querytext>
    UPDATE acs_objects
	SET package_id = :trash_package_id
    WHERE context_id = :object_id
</querytext>
</fullquery>

<fullquery name="callback::datamanager::copy_faq::impl::datamanager.get_faq_package_id">
<querytext>
    SELECT b.object_id as package_id 
    FROM acs_objects as a,acs_objects as b  
    WHERE a.context_id=:selected_community and a.object_type='apm_package' and a.object_id=b.context_id and b.title='FAQ';
</querytext>
</fullquery>

<fullquery name="callback::datamanager::copy_faq::impl::datamanager.get_faq_name">
<querytext>
    SELECT faq_name,separate_p
    FROM faqs
    WHERE faq_id=:object_id;
</querytext>
</fullquery>

<fullquery name="callback::datamanager::copy_faq::impl::datamanager.get_q_a_list">      
      <querytext>
        SELECT question,answer 
        FROM faq_q_and_as 
        WHERE faq_id=:object_id;
      </querytext>
</fullquery>



<fullquery name="callback::datamanager::copy_faq::impl::datamanager.create_q_and_a">      
      <querytext>
        select faq__new_q_and_a (
             	:entry_id,
             	:faq_id,
             	:one_question,
             	:one_answer,
 							:sort_key,
							'faq_q_and_a',
							now(),
             	:user_id,
             	:creation_ip,
							:faq_id
            );
      </querytext>
</fullquery>


</queryset>
