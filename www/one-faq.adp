<master>
<property name="context">@context@</property>
<property name="title">@faq_name@</property>

<if @one_question:rowcount@ eq 0>
  <i>#faq.lt_no_questions#</i>
  <p>
</if>
<else>

  <ol>
<multiple name="one_question">
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

<if @separate_p@ eq "f">
  <hr>
  <ol>
<multiple name="one_question">
    <li>
      <a name=@one_question.entry_id@></a>
      <b>#faq.Q#</b> <i>@one_question.question@</i>
      <p>
      <b>#faq.A#</b> @one_question.answer@
      <p>
    </li>
</multiple>
  </ol>
</if>

</else>

