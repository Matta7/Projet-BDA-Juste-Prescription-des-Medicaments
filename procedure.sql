CREATE OR REPLACE PROCEDURE deduce (id_obs NUMBER) 
IS 
BEGIN
	DBMS_OUTPUT.PUT_LINE('From most specific to most general:');
	FOR mal IN (
		SELECT DISTINCT *
		FROM maladie
		WHERE maladie.code IN (SELECT mal_code FROM symptome WHERE symptome.obs_id = id_obs)
		ORDER BY length(maladie.code)
	) 
	LOOP
	DBMS_OUTPUT.PUT_LINE(mal.nom);
	END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE meds_for_disease(name maladie.nom%TYPE) IS
var number;
BEGIN
	FOR cn IN (
	select nom,code,(
	select count(*)
	from maladie m1
	where maladie.code = 
	substr(m1.code,1,length(maladie.code))) as lvl	
	from maladie
	where exists (select m.code from maladie m
		where maladie.code = substr(m.code,1,length(maladie.code))
		and m.nom = name)
	order by lvl
	) LOOP
	
	SELECT count(*) 
	into var 
	FROM medicament
	WHERE id in (select medic_id from indication where mal_code = cn.code);

	IF var > 0 THEN
		DBMS_OUTPUT.PUT_LINE('Possible treatment for '||cn.nom||':');
		FOR md IN (
			select *
			from medicament
			where id in (select medic_id from indication where mal_code = cn.code)
		) LOOP
		DBMS_OUTPUT.PUT_LINE(md.nom);
		END LOOP;
		EXIT;
	END IF;
	END LOOP;
END;
/
