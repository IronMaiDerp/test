--Création de la base de donnée
createdb -O "user" bddAeroClub;

--Utilisation de la BDD
su postgresql
psql bddAeroClub

--Table TypeAvion
CREATE TABLE TypeAvion(
NumeroTypeAvion INT PRIMARY KEY,
Description VARCHAR (20),
Forfait1 NUMERIC,
Forfait2 NUMERIC,
Forfait3 NUMERIC,
Heures_Forfait1 NUMERIC,
Heures_Forfait2 NUMERIC,
Heures_Forfait3 NUMERIC,
Reduction_Semaine NUMERIC
);

INSERT INTO TypeAvion VALUES (1,'PA28',1161,0,1387,10,0,10,4);
INSERT INTO TypeAvion VALUES (2,'D112',655,0,895,10,0,10,0);
INSERT INTO TypeAvion VALUES (3,'HR200',850,0,1109,10,0,10,0);
INSERT INTO TypeAvion VALUES (4,'C150',270,0,0,3,0,0,0);
INSERT INTO TypeAvion VALUES (5,'ATL',810,0,1048,10,0,10,0);
INSERT INTO TypeAvion VALUES (6,'TB10',0,0,0,0,0,0,0);
INSERT INTO TypeAvion VALUES (7,'A6M2',127,0,666,10,0,10,4);
INSERT INTO TypeAvion VALUES (8,'JU87',1936,6500,1945,10,0,10,4);
INSERT INTO TypeAvion Values (9,'KI-45',1941,0,1945,05,19,41,11);

--Table Avion
CREATE TABLE Avion (
Num_Avion SERIAL PRIMARY KEY,
Immatriculation VARCHAR (30),
Taux NUMERIC, 
NumeroTypeAvion INTEGER
);

INSERT INTO Avion VALUES (DEFAULT,'D112 F-PNUI',70,2);
INSERT INTO Avion VALUES (DEFAULT,'PA28 F-GDJF',127,1);
INSERT INTO Avion VALUES (DEFAULT,'A6M2 RAIZEN',27,7);
INSERT INTO Avion VALUES (DEFAULT,'JU87 Stuka',7,8);
INSERT INTO Avion VALUES (DEFAULT,'KI-45 Ko',11,9);

ALTER SEQUENCE Avion_Num_Avion_seq RESTART WITH 1;

ALTER TABLE Avion
	ADD CONSTRAINT fk_Avion_TypeAvion FOREIGN KEY (NumeroTypeAvion) REFERENCES TypeAvion (NumeroTypeAvion);
	
--Table Civilite + Remplissage de la table.
CREATE TABLE Civilite (
Num_Civilite NUMERIC PRIMARY KEY,
CivCourt VARCHAR (5),
CivLong VARCHAR (16)
);

INSERT INTO Civilite VALUES (1,'M','Monsieur');
INSERT INTO Civilite VALUES (2,'Mme','Madame');
INSERT INTO Civilite VALUES (3,'Mlle','Mademoiselle');

--Table Instructeurs
CREATE TABLE Instructeurs (
Num_Instructeurs SERIAL PRIMARY KEY,
Nom VARCHAR (64),
Prenom VARCHAR (64),
Civilite VARCHAR(20),
Taux_Instructeur NUMERIC,
Adresse VARCHAR (128),
Code_Postal CHAR (5),
Ville VARCHAR (32),
Tel CHAR (10),
Portable CHAR (10),
Fax VARCHAR (32),
Commentaire VARCHAR (64),
Num_Badge VARCHAR (16),
Email VARCHAR (32)
);


INSERT INTO Instructeurs VALUES (DEFAULT,'HALLU','Pierre','Monsieur',25,'1 rue test','59430','Dunkerque','0666666666','0333333333','','','159','HalluPierre@sfr.fr');

ALTER SEQUENCE Instructeurs_Num_Instructeurs_seq RESTART WITH 1;


--Table Qualif + Remplissage de la table
CREATE TABLE Qualif(
Num_Qualif NUMERIC PRIMARY KEY,
Qualif VARCHAR (16)
);

INSERT INTO Qualif VALUES (1,'ST');
INSERT INTO Qualif VALUES (2,'BB');
INSERT INTO Qualif VALUES (3,'PPL-A');
INSERT INTO Qualif VALUES (4,'TT');
INSERT INTO Qualif VALUES (5,'PP');

--Table Membre
CREATE TABLE Membres (
Num_Membre SERIAL PRIMARY KEY,
Num_Qualif NUMERIC,
Num_Civilite NUMERIC,
Nom VARCHAR (64),
Prenom VARCHAR (32),
Adresse VARCHAR (64),
Code_Postal VARCHAR (5),
Ville VARCHAR (32),
Telephone VARCHAR (10),
Portable VARCHAR (10),
Email VARCHAR (32),
Commentaire VARCHAR (128),
Date_VM DATE,
Validite_VM DATE,
Date_SEP DATE,
Validite_SEP DATE,
Num_Badge VARCHAR (32),
Profession VARCHAR (62),
Date_Naissance DATE,
Lieu_Naissance VARCHAR (32),
Carte_Federal VARCHAR (32),
Date_Attestation DATE,
Date_Entree DATE,
Menbre_Actif BOOLEAN,
Menbre_Inscrit BOOLEAN,
Solde_Compte INT
);

INSERT INTO Membres (Num_Membre,Num_Qualif,Num_Civilite,Nom,Prenom) VALUES (DEFAULT,2,1,'Horthemel','Florent');
INSERT INTO Membres VALUES (DEFAULT,2,1,'Bernard','jean','11 rue test','59430','lille','0661648108','0328592340','ironmaiderp@sfr.fr','commentaire 3','2016-11-27','2020-11-27','2016-11-27','2020-11-27','05214564','chômeur','1997-11-27','Dunkerque','140334ADQ','2016-11-27','2016-11-27',true,true,270000);

--Table QualificationMembre
CREATE TABLE QualificationMembre(
Num_Membre INT,
Num_Qualif NUMERIC,
Date_theorique DATE,
Dates DATE,
Numero VARCHAR (32)
); 

ALTER TABLE QualificationMembre 
	ADD CONSTRAINT pk_QM PRIMARY KEY (Num_Membre, Num_Qualif);
ALTER TABLE QualificationMembre
	ADD CONSTRAINT fk_QM_Membre FOREIGN KEY (Num_Membre) REFERENCES Membres (Num_Membre);
ALTER TABLE QualificationMembre
	ADD CONSTRAINT fk_QM_Qualif FOREIGN KEY (Num_Qualif) REFERENCES Qualif (Num_Qualif);

INSERT INTO QualificationMembre VALUES (1,2,'2016-11-1','2016-11-27','TT13739');

--Table Utilisateur
CREATE TABLE Utilisateur(
Id SERIAL PRIMARY KEY,
MotDePasse VARCHAR (255),
Username VARCHAR (64)
);

ALTER SEQUENCE Utilisateur_Id_seq RESTART WITH 1;

INSERT INTO Utilisateur VALUES (DEFAULT,'MDPTest','UTest');

--Table Seq_Vol
CREATE TABLE Seq_Vol(
Num_Seq SERIAL PRIMARY KEY,
Num_Membre INT,
Num_Instructeur INT,
Num_Avion INT,
Date_Seq DATE,
Motif INT,
Reduction_Semaine DECIMAL (5,2),
Temps INT ,
Prix_Special DECIMAL (4,2),
Forfait_Initiation BOOLEAN
);

ALTER SEQUENCE Seq_Vol_Num_Seq_seq RESTART WITH 1;

ALTER TABLE Seq_Vol
	ADD CONSTRAINT fk_Seq_Vol_Membre FOREIGN KEY (Num_Membre) REFERENCES Membres (Num_Membre);
ALTER TABLE Seq_Vol
	ADD CONSTRAINT fk_Seq_Vol_Instructeur FOREIGN KEY (Num_Instructeur) REFERENCES Instructeurs (Num_Instructeurs);
ALTER TABLE Seq_Vol
	ADD CONSTRAINT fk_Seq_Vol_Avion FOREIGN KEY (Num_Avion) REFERENCES Avion (Num_Avion);
ALTER TABLE Seq_Vol
	ADD CONSTRAINT fk_Seq_Vol_Motif FOREIGN KEY (Motif) REFERENCES Motif (IdMotif);

INSERT INTO Seq_Vol VALUES (DEFAULT,1,1,2,'2016-09-1',0.00,72,0.00,FALSE,1);

--Table TypeOperation
CREATE TABLE TypeOperation(
IdType VARCHAR (4) PRIMARY KEY,
Libelle VARCHAR (32)
);

--Debit=Retire Credit=Rajoute
INSERT INTO TypeOperation VALUES ('DEB','Débit'), ('CRED','Crédit');

--Table OperationSurCompte
CREATE TABLE OperationSurCompte(
Num_Operation SERIAL,
Num_Membre INT,
Montant DECIMAL (6,2),
Type_Operation VARCHAR (4),
Commentaire VARCHAR (256),
Date_Operation DATE
);

ALTER TABLE OperationSurCompte
	ADD CONSTRAINT pk_Num_Operation_Num_Membre PRIMARY KEY (Num_Operation, Num_Membre);
ALTER TABLE OperationSurCompte
	ADD CONSTRAINT fk_OperationSurCompte_TypeOperation FOREIGN KEY (Type_Operation) REFERENCES TypeOperation (IdType);

INSERT INTO OperationSurCompte VALUES (DEFAULT,1,127.30,'CRED','Ajout pour le test d argent pour la bdd');


--Penser a actualiser le compte du membre avec chaque Operation

--Table Motif 
CREATE TABLE Motif(
IdMotif INT PRIMARY KEY,
Motif VARCHAR (128)
);

INSERT INTO Motif VALUES (1,'Vol Normal');
INSERT INTO Motif VALUES (2,'Vol Avec Instructeur');
INSERT INTO Motif VALUES (3,'Vol de Nuit');




