<?xml version="1.0"?>
<queryset>

<fullquery name="faq::apm_callback::before_uninstantiate.faq_list">
    <querytext>
        select faq_id
        from   acs_objects o,
               faqs f
        where  object_id = faq_id
        and    context_id = :package_id
    </querytext>
</fullquery>

</queryset>
