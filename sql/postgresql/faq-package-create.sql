-- Package create for faq
--
-- @author @jennie.ybos.net,@wirth.ybos.net,openacs port @samir.symphinity.com
-- 
-- @cvs-id $Id$
--

select define_function_args('faq__new_q_and_a','entry_id;null,faq_id,question,answer,sort_key,object_type,creation_date;current_timestamp,creation_user;null,creation_ip;null,context_id;null');

CREATE OR REPLACE FUNCTION faq__new_q_and_a (
       p_entry_id      faq_q_and_as.entry_id%TYPE,
       p_faq_id        faq_q_and_as.faq_id%TYPE,
       p_question      faq_q_and_as.question%TYPE,
       p_answer        faq_q_and_as.answer%TYPE,
       p_sort_key      faq_q_and_as.sort_key%TYPE,
       p_object_type   acs_objects.object_type%TYPE,   -- default faq_q_and_a
       p_creation_date acs_objects.creation_date%TYPE, -- default current_timestamp,
       p_creation_user acs_objects.creation_user%TYPE, -- default null,
       p_creation_ip   acs_objects.creation_ip%TYPE,   -- default null,
       p_context_id    acs_objects.context_id%TYPE    -- default null
) RETURNS faq_q_and_as.entry_id%TYPE AS $$
DECLARE
	v_entry_id 			faq_q_and_as.entry_id%TYPE;
	v_package_id 			acs_objects.package_id%TYPE;
BEGIN
        select package_id into v_package_id from acs_objects where object_id = p_faq_id;

	v_entry_id := acs_object__new (
		p_entry_id,
		p_object_type,		
		p_creation_date,
		p_creation_user,
		p_creation_ip,
		p_context_id,
                't',
                p_question,
                v_package_id
  		);
	insert into faq_q_and_as
		(entry_id, faq_id, question, answer, sort_key)
	values
		(v_entry_id, p_faq_id, p_question, p_answer, p_sort_key);

  return v_entry_id;
END;
$$ LANGUAGE plpgsql;



-- added
select define_function_args('faq__delete_q_and_a','entry_id');

--
-- procedure faq__delete_q_and_a/1
--
CREATE OR REPLACE FUNCTION faq__delete_q_and_a(
   p_entry_id faq_q_and_as.entry_id%TYPE
) RETURNS integer AS $$
DECLARE
BEGIN
	delete from faq_q_and_as where entry_id =  p_entry_id;
	raise NOTICE 'Deleting FAQ_Q_and_A...';
	PERFORM acs_object__delete(p_entry_id);

	return 0;
END;
$$ LANGUAGE plpgsql;




-- added
select define_function_args('faq__new_faq','faq_id,faq_name,separate_p,object_type,creation_date,creation_user,creation_ip,context_id');

--
-- procedure faq__new_faq/8
--
CREATE OR REPLACE FUNCTION faq__new_faq(
   p_faq_id        faqs.faq_id%TYPE,
   p_faq_name      faqs.faq_name%TYPE,
   p_separate_p    faqs.separate_p%TYPE,
   p_object_type   acs_objects.object_type%TYPE,
   p_creation_date acs_objects.creation_date%TYPE,
   p_creation_user acs_objects.creation_user%TYPE,
   p_creation_ip   acs_objects.creation_ip%TYPE,
   p_context_id    acs_objects.context_id%TYPE
) RETURNS faqs.faq_id%TYPE AS $$
DECLARE
	v_faq_id 				faqs.faq_id%TYPE;
BEGIN

	v_faq_id := acs_object__new (
		p_faq_id,
		p_object_type,
		p_creation_date,
		p_creation_user,
		p_creation_ip,
		p_context_id,
                't',
                p_faq_name,
                p_context_id );

	insert into faqs
		(faq_id, faq_name,separate_p)
	values
		(v_faq_id, p_faq_name,p_separate_p);

return v_faq_id;

END;
$$ LANGUAGE plpgsql;




-- added
select define_function_args('faq__delete_faq','faq_id');

--
-- procedure faq__delete_faq/1
--
CREATE OR REPLACE FUNCTION faq__delete_faq(
   p_faq_id faqs.faq_id%TYPE
) RETURNS integer AS $$
DECLARE
	del_rec record;
BEGIN
	   	-- Because q_and_as are objects, we need to
    	-- loop through a list of them, and call an explicit
    	-- delete function for each one. (i.e. each
    	-- entry_id)
	for del_rec in select entry_id from faq_q_and_as
		where faq_id = p_faq_id
  loop
		PERFORM faq__delete_q_and_a(del_rec.entry_id);
	end loop;

	delete from faqs where faq_id = p_faq_id;

	PERFORM  acs_object__delete(p_faq_id);

	return 0;

END;
$$ LANGUAGE plpgsql;



-- added
select define_function_args('faq__name','faq_id');

--
-- procedure faq__name/1
--
CREATE OR REPLACE FUNCTION faq__name(
   p_faq_id faqs.faq_id%TYPE
) RETURNS faqs.faq_name%TYPE AS $$
DECLARE 
    v_faq_name    faqs.faq_name%TYPE;
BEGIN
	select faq_name  into v_faq_name
		from faqs
		where faq_id = p_faq_id;

    return v_faq_name;
END;

$$ LANGUAGE plpgsql;


-- apisano 2020-03-20: not sure what is going on with this function,
-- as it calls for faq__new_faq with 3 arguments signature... in
-- current codebase we do not define such function...
-- added
select define_function_args('faq__clone','new_package_id,old_package_id');

--
-- procedure faq__clone/2
--
CREATE OR REPLACE FUNCTION faq__clone(
   p_new_package_id integer, --default null,
   p_old_package_id integer  --default null

) RETURNS integer AS $$
DECLARE
 v_faq_id 		faqs.faq_id%TYPE;
 one_faq		record;
 entry			record;

BEGIN
            -- get all the faqs belonging to the old package,
            -- and create new faqs for the new package
            for one_faq in select *
                            from acs_objects o, faqs f
                            where o.object_id = f.faq_id
                            and o.context_id = p_old_package_id
            loop
               v_faq_id := faq__new_faq (
                    			one_faq.faq_name,
                    			one_faq.separate_p,
                    			p_new_package_id
               	);

           	for entry in select * from faq_q_and_as
                                   where faq_id = one_faq.faq_id
           	loop

           		perform  faq__new_q_and_a (
                       		entry.faq_id,
                       		v_faq_id,
                       		entry.question,
                       		entry.answer,
                       		entry.sort_key
           	);
               end loop;
           end loop;
 return 0;
 END;

$$ LANGUAGE plpgsql;

