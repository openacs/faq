-- fix name method, update package

update acs_objects set name_method = 'faq__name' where name_method = 'faq.name' and object_type = 'faq';

\i ../faq-package-create.sql
