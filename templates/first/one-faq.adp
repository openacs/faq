<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">$faq_name</property>

<if @one_question:rowcount@ eq 0>
 <i>There are no questions available.</i><p>
</if>

<else>
<table>
 <tr valign=top>
 <td width="30%">
 <ol>
  <multiple name=one_question>
   <if @separate_p@ eq "t">
   
   <li>
	<a href="one-question?entry_id=@one_question.entry_id@">@one_question.question@</a>

    </li>
	</if>
    <if @separate_p@ eq "f">

   <li>
      <a href="#@one_question.entry_id@">@one_question.question@</a>

    </li>
   </if>
  </multiple>
 </ol>
</td>
<if @separate_p@ eq "f">
<td>
 <ol>
  <multiple name=one_question>
   <li>
    <a name=@one_question.entry_id@></a>
     <b>Q:</b> @one_question.question@
     <P>
     <b>A:</b> @one_question.answer@
     <p>

   </li>
  </multiple>
 </ol>

</if>
</td>
</tr>
</table>
</else>

