<master>
<property name="context">@context;noquote@</property>
<p>
      @notification_chunk;noquote@ 
</p>
<property name="title">@faq_name;noquote@</property>
<property name="displayed_object_id">@faq_id;noquote@</property>

<table width="70%" border="0">
<tr><td align="left" valign="top">
<if @one_question:rowcount@ eq 0>
  <i>#faq.lt_no_questions#</i>
  <p>
</if>
<else>
  <ol>
<multiple name="one_question">
<if @separate_p@ true>
    <li>
      <a href="one-question?entry_id=@one_question.entry_id@">@one_question.question;noquote@</a>
    </li>
</if>
<if @separate_p@ false>
    <li>
      <a href="#@one_question.entry_id@">@one_question.question;noquote@</a>
<if @use_categories_p@>
      <a href="categories/categorize?object_id=@one_question.entry_id@">Categorize</a>
</if>
    </li>
</if>
</multiple>
  </ol>

<if @separate_p@ false>
  <hr>
  <ol>
<multiple name="one_question">
    <li>
      <a name=@one_question.entry_id@></a>
      <b>#faq.Q#</b> <i>@one_question.question;noquote@</i>
      <p>
      <b>#faq.A#</b> @one_question.answer;noquote@
      <p>
    </li>
</multiple>
  </ol>
</if>

</else>
</td><td align="right" valign="top">
<if @use_categories_p@>
 <multiple name="categories">
           <h2>@categories.tree_name@</h2>
           <group column="tree_id">
             <a href="@package_url@cat@categories.category_id@?faq_id=@faq_id@&category_id=@categories.category_id@">@categories.category_name@</a><br>
           </group>
         </multiple>
<br><a href="@package_url@one-faq?faq_id=@faq_id@">#faq.All_QA#</a>
</if>
</td></tr>
</table>
