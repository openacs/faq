<master src="master">
<property name="title">@page_title@</property>
<property name="context_bar">@context_bar@</property>

<form action="@target@">
 <input type="hidden" name="insert_p" value="@insert_p@">
 <input type="hidden" name="faq_id" value="@faq_id@">


 <if @insert_p@ eq "t">
 	<input type="hidden" name="entry_id" value="@entry_id@">
 </if>

 <blockquote>
  <table>
  
   <tr valign="top">
    <th align="right"><br>Question</td>
    <td><textarea name="question" rows="3" cols="50" wrap><%= [ad_quotehtml $question] %></textarea></td>
   </tr>
   <tr>
  <tr valign="top">
    <th align="right"><br>Answer</td>
    <td><textarea name="answer" rows="10" cols="50" wrap><%= [ad_quotehtml $answer] %></textarea></td>
   </tr>
   <tr>   <th align="right">Text type?</th>
    <td>
     <select name="mime_type">
      <option value="text/plain; format=flowed" <if @mime_type@ nil or @mime_type@ eq "text/plain; format=flowed">selected</if>>Plain</option>
      <option value="text/plain" <if @mime_type@ not nil and @mime_type@ eq "text/plain">selected</if>>Preformatted</option>
      <option value="text/html" <if @mime_type@ not nil and @mime_type@ eq "text/html">selected</if>>HTML</option>
     </select>
    </td>
   </tr>
   <tr>
    <th></th>
    <td><input type="submit" value="@submit_label@"></td>
  </table>
 </blockquote>
</form>
