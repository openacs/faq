<master>
<property name="context">@context;noquote@</property>
<property name="title">#faq.FAQ_Admin#</property>

<if @faqs:rowcount@ eq 0>
 <i>#faq.lt_no_FAQs#</i><p>
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
            <a href="faq-edit?faq_id=@faqs.faq_id@">#faq.edit#</a> |
            <if @faqs.disabled_p@ true>
              <a href="@faqs.enable_url@">enable</a>
            </if>
            <else>
              <a href="@faqs.disable_url@">disable</a>
            </else>
            |
            <a href="faq-delete?faq_id=@faqs.faq_id@" onclick="return confirm('#faq.lt_Are_you_sure_you_want#');">#faq.delete#</a> 
            )
        </li>
      </group>
    </ul>
  </multiple>
 </ul>
</else>

<a href="faq-new">#faq.Create_a_new_FAQ#</a>

