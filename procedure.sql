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

CREATE OR REPLACE PROCEDURE side_effects_of(med_id medicament.id%TYPE) IS
varx medicament.nom%TYPE;
notice medicament.notice_url%TYPE;
BEGIN
	SELECT nom,notice_url INTO varx, notice
	FROM medicament
	WHERE id = med_id;
	DBMS_OUTPUT.PUT_LINE('Known side effects of ' ||varx||' include:');
	
	FOR row IN (
	SELECT *
	FROM effet_indesirable ei
	WHERE EXISTS (select * from effet_connus_m ec where ec.id = ei.id AND ec.medic_id = med_id)
	) LOOP
	DBMS_OUTPUT.PUT_LINE(row.text);
	END LOOP;
	
	DBMS_OUTPUT.NEW_LINE;
	DBMS_OUTPUT.PUT_LINE('    '||notice);
	DBMS_OUTPUT.NEW_LINE;
	DBMS_OUTPUT.PUT_LINE('Possible side effects include :');
	
	FOR row IN (
	SELECT *
	FROM effet_indesirable ei
	WHERE NOT EXISTS (select * from effet_connus_m ec where ec.id = ei.id AND ec.medic_id = med_id)
	AND (
		EXISTS (select * from effet_connus_s ec where ec.id = ei.id AND ec.subs_id IN (
			select sc.subs_id from substance_contenu sc where sc.medic_id = med_id))
		OR EXISTS (select * from effet_connus_c ec where ec.id = ei.id AND ec.chim_code IN (
			select c.code from classe_chimique c start with c.code in (select sc.code from substance_chimique sc
				where sc.subs_id in (select scont.subs_id from substance_contenu scont where scont.medic_id = med_id)
				) connect by prior parent = code
			)
		) OR EXISTS (select * from effet_connus_p ec where ec.id = ei.id AND ec.pharm_code IN (
			select p.code from classe_pharmacologique p start with p.code in (select sp.code from substance_pharmacologique sp
				where sp.subs_id in (select scont.subs_id from substance_contenu scont where scont.medic_id = med_id)
				) connect by prior parent = code
			)
		)
	)	
	) LOOP
	DBMS_OUTPUT.PUT_LINE(row.text);
	END LOOP;
END;
/
