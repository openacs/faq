<?xml version="1.0"?>
<queryset>
   <rdbms>
     <type>postgresql</type>
     <version>7.1</version>
   </rdbms>

   <fullquery name="delete_entry">
     <querytext>
       select acs_object__delete(entry_id)
       from faq_q_and_as where entry_id = :entry_id;
     </querytext>
   </fullquery>

</queryset>
