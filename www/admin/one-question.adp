<master src="master">
<property name="context">@context@</property>
<property name="title">One Question</property>

<b>Q:</b> @question@
<P>
<b>A:</b> @answer@
<p>
<a href=q_and_a-edit?<%=[export_url_vars entry_id faq_id]%>>Edit</a> | <a href=q_and_a-delete?<%=[export_url_vars entry_id faq_id]%>>Delete</a> | <a href="q_and_a-new?<%=[export_url_vars faq_id]%>">New</a>

<p>
<a href="index">Back to FAQs</a>

