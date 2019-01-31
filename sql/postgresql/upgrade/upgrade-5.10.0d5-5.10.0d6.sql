begin;

alter table faqs drop constraint faqs_faq_id_fk;
alter table faqs add constraint faqs_faq_id_fk
      foreign key (faq_id) references acs_objects(object_id) on delete cascade;

alter table faq_q_and_as drop constraint faq_q_and_as_entry_id_fk;
alter table faq_q_and_as add constraint faq_q_and_as_entry_id_fk
      foreign key (entry_id) references acs_objects(object_id) on delete cascade;

-- Foreign key constraint on faq_q_and_as.faq_id was defined without
-- and explicit name. One could save/drop/recreate the faq_id column
-- or do something like this...
DO
$body$
DECLARE
   v_constraint_name text := (
      select tc.constraint_name
      from information_schema.table_constraints AS tc,
           information_schema.key_column_usage AS kcu,
           information_schema.constraint_column_usage AS ccu
     where tc.constraint_name = kcu.constraint_name
       and tc.constraint_catalog = kcu.constraint_catalog
       and tc.constraint_schema = kcu.constraint_schema
       and tc.table_catalog = kcu.table_catalog
       and tc.table_schema = kcu.table_schema
       and ccu.constraint_name = tc.constraint_name
       and ccu.constraint_catalog = kcu.constraint_catalog
       and ccu.constraint_schema = kcu.constraint_schema
       and ccu.table_catalog = kcu.table_catalog
       and ccu.table_schema = kcu.table_schema
       and tc.constraint_type = 'FOREIGN KEY'
       and tc.table_name   = 'faq_q_and_as'
       and kcu.column_name = 'faq_id'
       and ccu.table_name  = 'faqs'
       and ccu.column_name = 'faq_id');
BEGIN
   EXECUTE '
      ALTER TABLE faq_q_and_as DROP CONSTRAINT "' || v_constraint_name || '"';
   EXECUTE '
      ALTER TABLE faq_q_and_as
      ADD CONSTRAINT "' || v_constraint_name || '" FOREIGN KEY (faq_id)
      REFERENCES faqs (faq_id) ON DELETE CASCADE';
END
$body$;

-- -- - create a temp column with the value of faq_id
-- alter table faq_q_and_as add column tmp_faq_id integer;
-- update faq_q_and_as set tmp_faq_id = faq_id;
-- -- - drop faq_id column
-- alter table faq_q_and_as drop column faq_id;
-- -- - re-create it with values stored in temp column
-- alter table faq_q_and_as add column faq_id integer;
-- update faq_q_and_as set faq_id = tmp_faq_id;
-- -- - update constraints
-- alter table faq_q_and_as alter column faq_id set not null;
-- alter table faq_q_and_as add constraint faq_q_and_as_faq_id_fkey
--       foreign key (faq_id) references faqs(faq_id) on delete cascade;
-- -- - drop temp column
-- alter table faq_q_and_as drop column tmp_faq_id;

end;
