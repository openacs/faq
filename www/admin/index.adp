<master>
<property name="context">@context@</property>
<property name="title">FAQ Admin</property>

<if @faqs:rowcount@ eq 0>
 <i>There are no FAQs available.</i><p>
</if>

<else>
  <multiple name=faqs>
    <if @faqs.disabled_p@ true><h4>Disabled FAQs</h4></if>
    <else><h4>Available FAQs</h4></else>
    <ul>
      <group column="disabled_p">
        <li>
          <a href="one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
            ( 
            <a href="faq-edit?faq_id=@faqs.faq_id@">edit</a> |
            <if @faqs.disabled_p@ true>
              <a href="@faqs.enable_url@">enable</a>
            </if>
            <else>
              <a href="@faqs.disable_url@">disable</a>
            </else>
            |
            <a href="faq-delete?faq_id=@faqs.faq_id@">delete</a> 
            )
        </li>
      </group>
    </ul>
  </multiple>
 </ul>
</else>

  <a href="faq-new">Create a new FAQ</a>
