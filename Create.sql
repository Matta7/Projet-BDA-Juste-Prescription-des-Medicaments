CREATE TABLE medecin 
(N_med NUMBER,
Nom VARCHAR(30),
Prenom VARCHAR(30),
CONSTRAINT PK_MEDECIN primary key (n_med)
);

-- Les maladies parentes ont un code qui est un préfixe de la maladie fils
CREATE TABLE maladie
(Code VARCHAR(30) NOT NULL,
Nom VARCHAR(60),
CONSTRAINT PK_MALADIE primary key (code)
);

CREATE TABLE patient
(n_pat NUMBER,
Nom VARCHAR(30),
Prenom VARCHAR(30),
CONSTRAINT PK_PATIENT primary key (n_pat)
);

CREATE TABLE traitement
(id NUMBER NOT NULL,
Date_debut Date,
Date_fin Date,
n_Med NUMBER,
n_pat NUMBER,
Constraint PK_TRAITEMENT primary key (id),
Constraint FK_TRAITEMENT_N_MED_MEDECIN foreign key (n_med) references medecin (n_Med),
Constraint FK_TRAITEMENT_N_PAT_PATIENT foreign key (n_pat) references patient (n_pat)
);

CREATE TABLE recommandation
(id NUMBER NOT NULL,
text VARCHAR(60),
Constraint PK_RECOMMANDATION primary key (id, text),
Constraint FK_RECOMMANDATION_ID_TRAIT foreign key (id) references traitement (id) ON DELETE CASCADE
);

CREATE TABLE consultation
(id NUMBER NOT NULL,
n_med NUMBER NOT NULL,
n_pat NUMBER NOT NULL,
VisitDate Date,
Constraint PK_CONSULTATION primary key (id),
Constraint FK_CONSULTATION_MED foreign key (n_med) references medecin (n_med),
Constraint FK_CONSULTATION_PAT foreign key (n_pat) references patient (n_pat)
);

CREATE TABLE observation
(id NUMBER NOT NULL,
text VARCHAR(60),
Constraint PK_OBSERVATION primary key (id)
);


CREATE TABLE symptome
(mal_code VARCHAR(30) NOT NULL, 
obs_id NUMBER NOT NULL,
Constraint PK_SYMPTOME primary key (mal_code, obs_id),
Constraint FK_SYMPTOME_MALADIE foreign key (mal_code) references maladie (code),
Constraint FK_SYMPTOME_OBSERV foreign key (obs_id) references observation (id)
);