<?xml version="1.0"?>
<queryset>
  <rdbms>
    <type>oracle</type>
    <version>8.1.6</version>
  </rdbms>

  <fullquery name="delete_faq">
    <querytext>
      begin;
      select acs_object.delete(entry_id)
      from faq_q_and_as where entry_id = :entry_id;
      end;
    </querytext>
  </fullquery>

</queryset>
