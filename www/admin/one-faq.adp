<master>
<property name="context">@context;noquote@</property>
<property name="title">#faq.faq_name_Admin#</property>

<b>#faq.Title#</b> @faq_name@ (<a href=faq-edit?faq_id=@faq_id@>#faq.edit#</a>)
<p>
<if @faq_q_and_as:rowcount@ eq 0>
 <i>#faq.lt_no_questions#</i><p>
</if>

<else>
 <ol>
  <multiple name=faq_q_and_as>
   <li>
	@faq_q_and_as.question@ 
	(	
	 <a href="q_and_a-edit?entry_id=@faq_q_and_as.entry_id@">#faq.edit#</a> |
	 <a href="one-question?entry_id=@faq_q_and_as.entry_id@">#faq.preview#</a> |
	 <a href="q_and_a-delete?entry_id=@faq_q_and_as.entry_id@" onclick="return confirm('#faq.lt_Are_you_sure_you_want_1#');">#faq.delete#</a> |

         <if @faq_q_and_as.sort_key@ ne @highest_sort_key_in_list@>
	   <a href="q_and_a-new?entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@">#faq.insert_after#</a> |
 	   <a href="swap?faq_id=@faq_id@&entry_id=@faq_q_and_as.entry_id@">#faq.swap_with_next#</a>
         </if>
	 <else>
	   <a href="q_and_a-new?entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@">#faq.insert_after#</a>
	</else>

	)
    </li>
  </multiple>
 </ol>
</else>
<ul>
  <li><a href="@new_faq_url@">#faq.Create_New_QA#</a>
<li><a href="index">#faq.View_All_FAQs#</a>
</ul>

