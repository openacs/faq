<master>
<property name="context">@context;literal@</property>
<property name="doc(title)">@title;literal@</property>

<h1>@title;noquote@</h1>
<include src="/packages/faq/lib/faq-add-edit" &="faq_id" mode="display">

<if @faq_q_and_as:rowcount@ eq 0>
 <em>#faq.lt_no_questions#</em><p></p>
</if>

<else>
 <ol>
  <multiple name="faq_q_and_as">
   <li>
    @faq_q_and_as.question;noquote@ 
    (  
     <a href="q-and-a-add-edit?entry_id=@faq_q_and_as.entry_id@&amp;faq_id=@faq_id@" title="Edit Question"><adp:icon name='edit' title='#faq.edit#'</a> |
     <a href="one-question?entry_id=@faq_q_and_as.entry_id@" title="Preview Question"><adp:icon name='eye-open' title='#faq.preview#'</a> |
     <a href="q-and-a-delete?entry_id=@faq_q_and_as.entry_id@" class="acs-confirm-delete" title="Delete Question"><adp:icon name='trash' title='#faq.delete#'></a> |
     <if @faq_q_and_as.sort_key@ ne @highest_sort_key_in_list@>
       <a href="q-and-a-add-edit?prev_entry_id=@faq_q_and_as.entry_id@&amp;faq_id=@faq_id@" title="Insert new question after this one">#faq.insert_after#</a> |
       <a href="swap?faq_id=@faq_id@&amp;entry_id=@faq_q_and_as.entry_id@" title="Swap question with next one">#faq.swap_with_next#</a>
     </if>
     <else>
       <a href="q-and-a-add-edit?prev_entry_id=@faq_q_and_as.entry_id@&amp;faq_id=@faq_id@" title="Insert new question after this one">#faq.insert_after#</a>
     </else>
    )
   </li>
  </multiple>
 </ol>
</else>

<ul class="action-links">
  <li><a href="q-and-a-add-edit?faq_id=@faq_id@">#faq.Create_New_QA#</a></li>
  <li><a href=".">#faq.View_All_FAQs#</a></li>
</ul>
