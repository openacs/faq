<master>
<property name="context">@context@</property>
<property name="title">@title@</property>

<form action="@action@">
 <input type="hidden" name="faq_id" value="@faq_id@">
 <blockquote>
  <table>
   <tr>
    <th align="right">Name:</th>
    <td><input size="50" name="faq_name" value="@faq_name@"></td>
   </tr>
   <tr>
    <th align="right">Q&A On Separate Pages</th>
    <td><select name=separate_p>
	<if @separate_p@ eq "t">
	<option value="t" selected>Yes</option>
	<option value="f">No</option>
	</if>
	<else>
	<option value="t">Yes</option>
	<option value="f" selected>No</option>
	</else>
	</select>
	
    </td>
   </tr>
  
   <tr>
    <th></th>
    <td><input type="submit" value="@submit_label@"></td>
  </table>
 </blockquote>
</form>
