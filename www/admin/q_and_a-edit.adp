<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">One Question</property>

<form action="@action@" >
<input type=hidden name=entry_id value=@entry_id@>
 <table>
  <tr>
   <th align=right>Question</th>
   <td>
    <textarea rows=4 cols=50 name=question>@question@</textarea>
   </td>
  </tr>
  <tr>
   <th align=right>Answer</th>
   <td>
    <textarea rows=10 cols=50 name=answer>@answer@</textarea>
   </td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td><input type=submit value="@submit_label@"></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td> <a href=q_and_a-delete?<%=[export_url_vars entry_id faq_id]%>>Delete This Q&A</a></td>
  </tr>
 </table>
</form>


