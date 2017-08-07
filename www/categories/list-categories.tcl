ad_page_contract { 
    Main category display page 
    @author Jeff Davis (davis@xarg.net)
    @cvs-id $Id$
} {
    {cat:trim,integer {}}
    {orderby:token "object_title"}
}

set cat_name [category::get_names $cat]

ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
