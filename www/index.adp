<master>
<property name="context">@context@</property>
<property name="title">FAQs</property>

<if @admin_p@ eq 1>
<P>[<a href="./admin">administer</a>]</P>
</if>


<if @faqs:rowcount@ eq 0>
 <i>There are no faqs available.</i><p>
</if>

<else>
 <ul>
  <multiple name=faqs>
   <li><a href="one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
   </li>
  </multiple>
 </ul>
</else>




