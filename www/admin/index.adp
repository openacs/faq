<master>
<property name="context">@context@</property>
<property name="title">#faq.FAQ_Admin#</property>

<if @faqs:rowcount@ eq 0>
 <i>#faq.lt_no_FAQs#</i><p>
</if>

<else>
 <ul>
  <multiple name=faqs>
   <li><a href="one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
	( 
	<a href="faq-edit?faq_id=@faqs.faq_id@">#faq.edit#</a> |
	<a href="faq-delete?faq_id=@faqs.faq_id@" onclick="return confirm('#faq.lt_Are_you_sure_you_want#');">#faq.delete#</a> 
	)
    </li>
  </multiple>
 </ul>
</else>

  <a href="faq-new">#faq.Create_a_new_FAQ#</a>

