<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">$faq_name Admin</property>

<if @faq_q_and_as:rowcount@ eq 0>
 <i>There are no questions available.</i><p>
</if>

<else>
 <ol>
  <multiple name=faq_q_and_as>
   <li>
	@faq_q_and_as.question@ 
	(	
	 <a href="q_and_a-edit?entry_id=@faq_q_and_as.entry_id@">edit</a> |
	 <a href="one-question?entry_id=@faq_q_and_as.entry_id@">preview</a> |
	 <a href="q_and_a-delete?entry_id=@faq_q_and_as.entry_id@">delete</a> |

         <if @faq_q_and_as.sort_key@ ne @highest_sort_key_in_list@>
	   <a href="q_and_a-new?entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@">insert after</a> |
 	   <a href="swap?faq_id=@faq_id@&entry_id=@faq_q_and_as.entry_id@">swap with next</a>
         </if>
	 <else>
	   <a href="q_and_a-new?entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@">insert after</a>
	</else>

	)
    </li>
  </multiple>
 </ol>
</else>

  <a href="q_and_a-new?<%=[export_url_vars faq_id]%>">Create New Q&A</a>

<p>
<a href="index">Back to FAQs</a>

