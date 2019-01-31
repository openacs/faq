<?xml version="1.0"?>
<queryset>
  <rdbms>
    <type>oracle</type>
    <version>8.1.6</version>
  </rdbms>

  <fullquery name="delete_faq">
    <querytext>
      begin;
      select acs_object.delete(faq_id)
      from faqs where faq_id = :faq_id;
      end;
    </querytext>
  </fullquery>

</queryset>
