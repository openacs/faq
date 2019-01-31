begin;

-- apisano 2019-01-30: intended purpose of this trigger is to schedule
-- deletion of faq content from the search package engine indexes by
-- calling search_observer__enqueue(entry_id, 'DELETE') on the just
-- deleted entry. However, as this entry depends on the corresponding
-- q_and_a acs_object, either we keep this object hanging around until
-- the unindexing happens, or we just delete this as well (e.g. this
-- happens in faq__delete_q_and_a stored procedure):
-- -- delete from faq_q_and_as where entry_id =  p_entry_id;
-- -- raise NOTICE 'Deleting FAQ_Q_and_A...';
-- -- PERFORM acs_object__delete(p_entry_id);
-- Deleting the object brings the entry in the search queue to be
-- deleted as well via on delete cascade, de-facto preventing this
-- tuple from being used at all in the scheduled search indexer.
-- Furthermore, unindexing will take place anyway via on delete
-- cascate defined on txt.object_id for tsearch2-driver and apparently
-- also on site_wide_index.object_id for the intermedia-driver on
-- Oracle, making all this trigger daydream quite pointless. To make
-- things worse, this trigger complicates removal of a faq instance,
-- as long as faqs with entries are there.
-- drop trigger faq_sc__dtrg on faq_q_and_as;
DO
$body$
DECLARE
   v_trigger_name text := (
      select trigger_name
      from information_schema.triggers
     where event_object_table = 'faq_q_and_as'
       and event_manipulation = 'DELETE'
       and action_timing = 'AFTER');
BEGIN
   EXECUTE '
      DROP TRIGGER "' || v_trigger_name || '" on faq_q_and_as';
END
$body$;

end;
