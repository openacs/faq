<master>
<property name="context">@context;noquote@</property>
<property name="title">#faq.FAQ_Admin#</property>

<listtemplate name="faqs"></listtemplate>

<ul class="action-links">
  <li><a href="faq-add-edit">#faq.Create_a_new_FAQ#</a></lI>

<li><a href=configure?<%=[export_url_vars return_url]%>>#faq.Configure#</a>
<if @use_categories_p@>
   <li><a href="@category_map_url@" class="action_link">#faq.Site_wide_categories#</a>
</if>
</ul>
