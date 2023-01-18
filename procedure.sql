-- 1ère procédure
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

-- 2ème procédure
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


-- 3.Une fonction/procedure qui permet de sauvegarder le patient, son traitement (l’ensemble du ou des m ́edicaments et/ou recommandations) et la ou les maladies diagnostiquees par un medecin. Pour contrôler les prescriptions, le système ne doit pas autoriser un medecin à prescrire un medicament pour lequel il a participé l’élaboration. Lancez les messages d’erreurs adequats à l’utilisateur.

CREATE OR REPLACE PROCEDURE saveData (p_nom VARCHAR, p_prenom VARCHAR, p_date_debut DATE, p_date_fin DATE, p_n_med NUMBER, p_n_medics medicament.id%ROWTYPE, p_mal_codes maladie.Code%ROWTYPE)
AS r_id_pat NUMBER; r_id_trait NUMBER;
BEGIN
	SELECT MAX(n_pat)+1 INTO r_id_pat FROM patient;
	SELECT MAX(id)+1 INTO r_id_trait FROM traitement;

	INSERT INTO patient (n_pat, Nom, Prenom) VALUES (r_id_pat, p_nom, p_prenom);
	INSERT INTO traitement(id, Date_debut, Date_fin, n_Med, n_pat) VALUES (r_id_trait, p_data_debut, p_date_fin, p_n_med, r_id_pat);

	FOR row IN (
	p_n_medics
	) LOOP
	IF p_n_med = (SELECT n_med FROM developpe WHERE n_med = p_n_med AND medic_id = row) THEN
	dbms_output.put_line('Le médicament ' || to_char(row) ||' ne peut être prescrit car le médecin a développé le médicament.');
	ELSE
	INSERT INTO trait_med (trait_id, medic_id) VALUES (r_id_trait, row);
	END IF;
	END LOOP;

	FOR rowm IN (p_mal_codes) LOOP
	INSERT INTO chronique (n_pat, mal_code) VALUES (r_id_pat, rowm);
	END LOOP;
END;
/


-- 4ème procédure
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


-- 5. Une fonction / procédure qui permet pour chaque médecin de connaître la liste de tous les médicaments qu'il a prescrits.

CREATE OR REPLACE PROCEDURE medicList (p_med NUMBER)
AS
BEGIN
	FOR row IN (
	SELECT medic.nom
	FROM medicament medic, trait_med tm, traitement t
	WHERE medic.id = tm.medic_id AND tm.trait_id = t.id AND t.n_Med = p_med
	) LOOP dbms_output.put_line(row.nom); END LOOP;
END;
/