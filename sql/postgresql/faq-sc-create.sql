-- 
-- packages/faq/sql/postgresql/faq-sc-create.sql
-- 
-- @author Emmanuelle Raffenne (eraffenne@dia.uned.es)
-- @creation-date 2007-07-11
-- @cvs-id $Id$
--

create function faq_sc__itrg ()
returns opaque as $$
begin
    perform search_observer__enqueue(new.entry_id,'INSERT'); 
    return new;
end; 
$$ language plpgsql;

create function faq_sc__dtrg ()
returns opaque as $$
begin
    perform search_observer__enqueue(old.entry_id,'DELETE'); 
    return old;
end;
$$ language plpgsql;

create function faq_sc__utrg ()
returns opaque as $$
begin
    perform search_observer__enqueue(old.entry_id,'UPDATE'); 
    return old;
end; 
$$ language plpgsql;

create trigger faq_sc__itrg after insert on faq_q_and_as for each row execute procedure faq_sc__itrg ();
create trigger faq_sc__dtrg after delete on faq_q_and_as for each row execute procedure faq_sc__dtrg ();
create trigger faq_sc__utrg after update on faq_q_and_as for each row execute procedure faq_sc__utrg ();
