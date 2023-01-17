INSERT INTO medecin (N_med, Nom, Prenom) VALUES(1, 'Michel', 'François');
INSERT INTO medecin (N_med, Nom, Prenom) VALUES(2, 'Mouche', 'Romain');


INSERT INTO laboratoire_pharmaceutique (n_labo, nom, adresse) VALUES (1, 'Prince des oranges', 'PARIS');
INSERT INTO laboratoire_pharmaceutique (n_labo, nom, adresse) VALUES (2, 'Chine occidentale', 'ROUEN');


INSERT INTO travaille (n_labo, n_Med) VALUES (1, 2);
INSERT INTO travaille (n_labo, n_Med) VALUES (2, 1);


INSERT INTO patient (n_pat, Nom, Prenom) VALUES(1, 'Dupont', 'Jean');
INSERT INTO patient (n_pat, Nom, Prenom) VALUES(2, 'Jiji', 'Léa');


INSERT INTO medicament (id, nom, notice_url) VALUES (1, "Doliprane", "");
INSERT INTO medicament (id, nom, notice_url) VALUES (2, "Efferalgan", "");
INSERT INTO medicament (id, nom, notice_url) VALUES (3, "Dafalgan", "");
INSERT INTO medicament (id, nom, notice_url) VALUES (4, "Levothyrox", "");


INSERT INTO effet_indesirable (id, text) VALUES (1, "Augmentation de la transpiration, une augmentation du flux sanguin cutané et une perte de chaleur.")
INSERT INTO effet_indesirable (id, text) VALUES (2, "Augmentation de la transpiration, une augmentation du flux sanguin cutané et une perte de chaleur.")
INSERT INTO effet_indesirable (id, text) VALUES (3, "Augmentation de la transpiration, une augmentation du flux sanguin cutané et une perte de chaleur.")
INSERT INTO effet_indesirable (id, text) VALUES (4, "Augmentation du rythme cardiaque.")


INSERT INTO substance_active (id, nom, descrip) VALUES (1, "Paracétamol", "Le paracétamol est un médicament utilisé dans le traitement des douleurs légères à modérées et/ou dans les états fébriles.");
INSERT INTO substance_active (id, nom, descrip) VALUES (2, "Lévothyroxine sodique", "Hormone thyroïdienne, chimiquement définie sous sa forme naturelle L plus active que la forme D.");


INSERT INTO effet_connus_s (id, subs_id) VALUES (1, 1);
INSERT INTO effet_connus_s (id, subs_id) VALUES (2, 1);
INSERT INTO effet_connus_s (id, subs_id) VALUES (3, 1);
INSERT INTO effet_connus_s (id, subs_id) VALUES (4, 2);


INSERT INTO effet_connus_m (id, medic_id) VALUES (1, 1);
INSERT INTO effet_connus_m (id, medic_id) VALUES (2, 2);
INSERT INTO effet_connus_m (id, medic_id) VALUES (3, 3);
INSERT INTO effet_connus_m (id, medic_id) VALUES (4, 4);


INSERT INTO substance_contenu (medic_id, subs_id) VALUES (1, 1);
INSERT INTO substance_contenu (medic_id, subs_id) VALUES (1, 2);
INSERT INTO substance_contenu (medic_id, subs_id) VALUES (1, 3);
INSERT INTO substance_contenu (medic_id, subs_id) VALUES (2, 4);


INSERT INTO classe_pharmacologique (code, parent) VALUES ("Antalgiques", "Antalgiques");
INSERT INTO classe_pharmacologique (code, parent) VALUES ("Antalgiques non opiacés", "Antalgiques");
INSERT INTO classe_pharmacologique (code, parent) VALUES ("Endocrinologie", "Endocrinologie");
INSERT INTO classe_pharmacologique (code, parent) VALUES ("Médicaments de la thyroïde", "Endocrinologie");


INSERT INTO substance_pharmacologique (code, subs_id) VALUES ("Antalgiques non opiacés", 1);
INSERT INTO substance_pharmacologique (code, subs_id) VALUES ("Antalgiques non opiacés", 2);
INSERT INTO substance_pharmacologique (code, subs_id) VALUES ("Antalgiques non opiacés", 3);
INSERT INTO substance_pharmacologique (code, subs_id) VALUES ("Médicaments de la thyroïde", 4);


INSERT INTO effet_connus_p (id, pharm_code) VALUES (1, "Antalgiques non opiacés");
INSERT INTO effet_connus_p (id, pharm_code) VALUES (2, "Antalgiques non opiacés");
INSERT INTO effet_connus_p (id, pharm_code) VALUES (3, "Antalgiques non opiacés");
INSERT INTO effet_connus_p (id, pharm_code) VALUES (4, "Médicaments de la thyroïde");


INSERT INTO maladies (Code, Nom) VALUES('C', 'maladies')
INSERT INTO maladies (Code, Nom) VALUES('C01', 'infections bactériennes et mycoses');
INSERT INTO maladies (Code, Nom) VALUES('C01.252', 'infections bactériennes');
INSERT INTO maladies (Code, Nom) VALUES('C01.252.100', 'bactériémie');
INSERT INTO maladies (Code, Nom) VALUES('C01.252.100.375', 'septicémie hémorragique');
INSERT INTO maladies (Code, Nom) VALUES('C01.252.200', 'infections bactériennes du système nerveux central');
INSERT INTO maladies (Code, Nom) VALUES('C01.252.200.100', 'abcès cérébral');
INSERT INTO maladies (Code, Nom) VALUES('C02', 'maladies virales');
INSERT INTO maladies (Code, Nom) VALUES('C02.081', 'infections à arbovirus');
INSERT INTO maladies (Code, Nom) VALUES('C02.081.030', 'peste équine');
INSERT INTO maladies (Code, Nom) VALUES('C02.081.125', 'fièvre catarrhale du mouton');
INSERT INTO maladies (Code, Nom) VALUES('C02.109', 'bronchiolite virale');


INSERT INTO traitement (id, Date_debut, Date_fin, n_Med, n_pat) VALUES(1, TO_DATE('17/12/2015', 'DD/MM/YYYY'), TO_DATE('25/12/2015', 'DD/MM/YYYY'), 1, 1);
INSERT INTO traitement (id, Date_debut, Date_fin, n_Med, n_pat) VALUES(2, TO_DATE('18/12/2015', 'DD/MM/YYYY'), TO_DATE('25/12/2015', 'DD/MM/YYYY'), 2, 1);
INSERT INTO traitement (id, Date_debut, Date_fin, n_Med, n_pat) VALUES(3, TO_DATE('27/12/2029', 'DD/MM/YYYY'), TO_DATE('2/1/2030', 'DD/MM/YYYY'), 1, 2);


INSERT INTO recommandation (id, text) VALUES (1, "Attention");
INSERT INTO recommandation (id, text) VALUES (2, "Ne pas lancer les médicaments par terre trop violemment");
INSERT INTO recommandation (id, text) VALUES (3, "Bien doser");


INSERT INTO consultation (id, n_med, n_pat, VisitDate) VALUES (1, 1, 1, TO_DATE('17/12/2015', 'DD/MM/YYYY'));
INSERT INTO consultation (id, n_med, n_pat, VisitDate) VALUES (2, 2, 2, TO_DATE('19/12/2030', 'DD/MM/YYYY'));


INSERT INTO observation (id, text) VALUES (1, "Toux");
INSERT INTO observation (id, text) VALUES (2, "50° de fièvre");
INSERT INTO observation (id, text) VALUES (3, "40° de fièvre");
INSERT INTO observation (id, text) VALUES (4, "Oeil gonflé");
INSERT INTO observation (id, text) VALUES (5, "Problème de tension");


INSERT INTO observe (obs_id, con_id) VALUES (1, 1);
INSERT INTO observe (obs_id, con_id) VALUES (2, 1);
INSERT INTO observe (obs_id, con_id) VALUES (4, 1);
INSERT INTO observe (obs_id, con_id) VALUES (1, 2);
INSERT INTO observe (obs_id, con_id) VALUES (3, 2);
INSERT INTO observe (obs_id, con_id) VALUES (5, 2);


INSERT INTO symptome (mal_code, obs_id) VALUES ('C02.109', 1);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C02.081.125', 2);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C02.081.030', 4);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C01.252.200.100', 1);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C01.252.200.100', 3);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C01.252.100.375', 5);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C01.252', 1);
INSERT INTO symptome (mal_code, obs_id) VALUES ('C01.252', 3);


INSERT INTO trait_med (trait_id, medic_id) VALUES(1, 1);
INSERT INTO trait_med (trait_id, medic_id) VALUES(1, 2);
INSERT INTO trait_med (trait_id, medic_id) VALUES(2, 3);
INSERT INTO trait_med (trait_id, medic_id) VALUES(3, 2);


INSERT INTO developpe (n_med, medic_id) VALUES (1, 1);
INSERT INTO developpe (n_med, medic_id) VALUES (2, 1);
INSERT INTO developpe (n_med, medic_id) VALUES (2, 3);
INSERT INTO developpe (n_med, medic_id) VALUES (1, 2);
INSERT INTO developpe (n_med, medic_id) VALUES (2, 4);