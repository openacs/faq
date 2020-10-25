-- 
-- packages/faq/sql/postgresql/faq-sc-create.sql
-- 
-- @author Emmanuelle Raffenne (eraffenne@dia.uned.es)
-- @creation-date 2007-07-11
-- @cvs-id $Id$
--

create function faq_sc__itrg ()
returns trigger as $$
begin
    perform search_observer__enqueue(new.entry_id,'INSERT'); 
    return new;
end; 
$$ language plpgsql;

create function faq_sc__dtrg ()
returns trigger as $$
begin
    perform search_observer__enqueue(old.entry_id,'DELETE'); 
    return old;
end;
$$ language plpgsql;

create function faq_sc__utrg ()
returns trigger as $$
begin
    perform search_observer__enqueue(old.entry_id,'UPDATE'); 
    return old;
end; 
$$ language plpgsql;

create trigger faq_sc__itrg after insert on faq_q_and_as for each row execute procedure faq_sc__itrg ();
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
-- create trigger faq_sc__dtrg after delete on faq_q_and_as for each row execute procedure faq_sc__dtrg ();
create trigger faq_sc__utrg after update on faq_q_and_as for each row execute procedure faq_sc__utrg ();
