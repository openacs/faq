<?xml version="1.0"?>
<queryset>

<fullquery name="callback::datamanager::move_faq::impl::datamanager.update_faqs">
<querytext>
        update acs_objects
	set context_id = (select package_id 
	from dotlrn_community_applets
	where community_id = :selected_community and applet_id = (
	    select applet_id from dotlrn_applets where applet_key = 'dotlrn_faq'
	))
	where object_id = :object_id

</querytext>
</fullquery>


</queryset>
