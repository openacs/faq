#faq/www/admin/index.tcl

ad_page_contract {

    Admin for FAQs on this site
    Categories for FAQ-Package added

    @author Jennie Housman (jennie@ybos.net)
    @author Elizabeth Wirth (wirth@ybos.net)
    @author Nima Mazloumi (nima.mazloumi@gmx.de)
    @creation-date 2000-10-24

} {
} -properties {
    context:onevalue
    package_id:onevalue
    user_id:onevalue
}

set package_id [ad_conn package_id]

permission::require_permission -object_id $package_id -privilege faq_admin_faq

set title "#faq.FAQ_Admin#"
set context {}

set user_id [ad_conn user_id]

template::list::create \
    -name faqs \
    -elements {
        edit {
            display_template {
                <a href="@faqs.edit_url@" title="#faq.Edit_FAQ# @faqs.faq_name@">
                  <adp:icon name="edit" text="#faq.Edit#">
                </a>
            }
            sub_class narrow
        }
        faq_name {
            label "#faq.name#"
            display_template {
                <a href="@faqs.manage_url@" title="#faq.Name# @faqs.faq_name;noquote@">
                    @faqs.faq_name;noquote@
                </a>
            }
        }
        num_q_and_as {
            label "#faq.number_qa#"
            html { align center }
        }
        disabled_p {
            label "#faq.enabled#"
            display_template {
                <if @faqs.disabled_p;literal@ false>
                  <a href="@faqs.disable_url@" title="#faq.Disable_FAQ# @faqs.faq_name@">
                    <adp:icon name="checkbox-checked" text="#faq.Disable#">
                  </a>
                </if>
                <else>
                  <a href="@faqs.enable_url@" title="#faq.Enable_FAQ# @faqs.faq_name@">
                    <adp:icon name="checkbox-unchecked" text="#faq.Enable#">
                  </a>
                </else>
            }
            html { align center }
        }
        delete {
            display_template {
                <a href="@faqs.delete_url@" title="#faq.Delete_FAQ# @faqs.faq_name@">
                  <adp:icon name="trash" text="#faq.Delete#">
                </a>
            }
            sub_class narrow
        }
    }


db_multirow -extend { edit_url manage_url delete_url disable_url enable_url } faqs faq_select {} {
    set edit_url [export_vars -base faq-add-edit { faq_id }]
    set manage_url [export_vars -base one-faq { faq_id }]
    set delete_url [export_vars -base faq-delete { faq_id }]
    set disable_url [export_vars -base faq-disable { faq_id }]
    set enable_url [export_vars -base faq-enable { faq_id }]
}

# for categories
set use_categories_p [parameter::get -parameter "EnableCategoriesP"]
set category_container [parameter::get -parameter "CategoryContainer"]
set category_map_url [export_vars -base "[site_node::get_package_url -package_key categories]cadmin/one-object" { { object_id $package_id } }]

set return_url [ns_conn url]

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
