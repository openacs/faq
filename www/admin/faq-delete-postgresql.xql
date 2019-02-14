<?xml version="1.0"?>
<queryset>
   <rdbms>
     <type>postgresql</type>
     <version>7.1</version>
   </rdbms>

   <fullquery name="delete_faq">
     <querytext>
       select acs_object__delete(faq_id)
       from faqs where faq_id = :faq_id
     </querytext>
   </fullquery>

</queryset>
