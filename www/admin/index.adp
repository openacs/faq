<master src="master">
<property name="context">@context@</property>
<property name="title">FAQ Admin</property>

<if @faqs:rowcount@ eq 0>
 <i>There are no FAQs available.</i><p>
</if>

<else>
 <ul>
  <multiple name=faqs>
   <li><a href="one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
	( 
	<a href="faq-edit?faq_id=@faqs.faq_id@">edit</a> |
	<a href="faq-delete?faq_id=@faqs.faq_id@">delete</a> 
	)
    </li>
  </multiple>
 </ul>
</else>

  <a href="faq-new">Create a new FAQ</a>
