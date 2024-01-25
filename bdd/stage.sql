
Create table client (
idclient int(11) not null auto_increment,
nom varchar(30),
tel varchar(10) UNIQUE,
email varchar(50) UNIQUE,
mdp varchar(255),
adresse varchar(100),
cp varchar(5),
ville varchar(50),
pays varchar(50),
etat enum("Prospect", "Client actif", "Client très actif"),
role enum("client", "admin"),
nbTentatives int not null default 0,
bloque int not null default 0,
nbConnexion int not null default 0,
type enum("Particulier", "Professionnel"),
date_creation_mdp datetime,
date_dernier_changement_mdp datetime,
date_creation_compte datetime,
connexion datetime,
deconnexion datetime,
primary key (idclient)
) ENGINE=InnoDB, CHARSET=utf8;

Create table salle(
    idsalle int(20) not null auto_increment,
    bâtiment varchar(2),
    nom varchar(10),
    primary key(idsalle)
) ENGINE=InnoDB, CHARSET=utf8;

Create or replace view vclient (idclient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role, nbTentatives, bloque, nbConnexion, type, date_creation_mdp, date_dernier_changement_mdp, date_creation_compte, connexion, deconnexion)
as select idclient, nom, tel, email, mdp, adresse, cp, ville, pays, etat, role, nbTentatives, bloque, nbConnexion, type, date_format(date_creation_mdp, '%d/%m/%Y %H:%i'), date_format(date_dernier_changement_mdp, '%d/%m/%Y %H:%i'), date_format(date_creation_compte, '%d/%m/%Y %H:%i'), date_format(connexion, '%d/%m/%Y %H:%i'), date_format(deconnexion, '%d/%m/%Y %H:%i')
from client;

Create table particulier (
idclient int(11) not null,
nom varchar(30),
prenom varchar(30),
tel varchar(10) UNIQUE,
email varchar(50) UNIQUE,
mdp varchar(255),
adresse varchar(100),
cp varchar(5),
ville varchar(50),
pays varchar(50),
etat enum("Prospect", "Client actif", "Client très actif"),
role enum("client", "admin"),
nbTentatives int not null default 0,
bloque int not null default 0,
nbConnexion int not null default 0,
type enum("Particulier"),
date_creation_mdp datetime,
date_dernier_changement_mdp datetime,
date_creation_compte datetime,
primary key (idclient),
foreign key (idclient) references client (idclient)
on update cascade
on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Drop function if exists countTelParticulier;
Delimiter //
Create function countTelParticulier(newtel varchar(10))
returns int
Deterministic
Begin
select count(*) from particulier where tel = newtel into @result;
return @result;
End //
Delimiter ;

Drop trigger if exists checkTelParticulier;
Delimiter //
Create trigger checkTelParticulier
Before insert on particulier
For each row
Begin
if countTelParticulier(new.tel)
then signal sqlstate '45000'
set message_text = 'Telephone deja utilisee !';
end if ;
End //
Delimiter ;

Drop function if exists countEmailParticulier;
Delimiter //
Create function countEmailParticulier(newemail varchar(50))
returns int
Deterministic
Begin
select count(*) from particulier where email = newemail into @result;
return @result;
End //
Delimiter ;

Drop trigger if exists checkEmailParticulier;
Delimiter //
Create trigger checkEmailParticulier
Before insert on particulier
For each row
Begin
if countEmailParticulier(new.email)
then signal sqlstate '45000'
set message_text = 'Email deja utilisee !';
end if ;
End //
Delimiter ;

Drop procedure if exists insertParticulier;
Delimiter //
Create procedure insertParticulier(in p_nom varchar(30), in p_prenom varchar(30), in p_tel varchar(10), in p_email varchar(50), in p_mdp varchar(255), in p_adresse varchar(100), in p_cp varchar(5), in p_ville varchar(50), in p_pays varchar(50), in p_etat enum("Prospect", "Client actif", "Client très actif"), in p_role enum("client", "admin"))
Begin
declare p_idclient int(11);
insert into client values (null, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Particulier', sysdate(), sysdate(), sysdate(), sysdate(), sysdate());
select idclient into p_idclient
from client
where tel = p_tel and email = p_email;
insert into particulier values (p_idclient, p_nom, p_prenom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Particulier', sysdate(), sysdate(), sysdate());
End //
Delimiter ;

call insertParticulier('CLIENT1', 'CLIENT1', '0353952424', 'client1.client1@gmail.com', 'ZuGh5iW2of1', '3, rue de Aulnay', '93600', 'AULNAY SOUS BOISA', 'France', 'Prospect', 'client');
call insertParticulier('CLIENT2', 'CLIENT2', '0214316122', 'client2.client2@gmail.com', 'eesh4Yush', '15, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'client');

# COMPTE(S) TEST
-- Compte particulier (admin)
call insertParticulier('ADMIN1', 'ADMIN1', '0101010101', 'admin1.admin1@gmail.com', 'Azerty123', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin');
call insertParticulier('ADMIN2', 'ADMIN2', '0101010102', 'admin2.admin2@gmail.com', 'Azerty123', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin');

Drop procedure if exists updateParticulier;
Delimiter //
Create procedure updateParticulier(in p_nom varchar(30), in p_prenom varchar(30), in p_tel varchar(10), in p_email varchar(50), in p_mdp varchar(255), in p_adresse varchar(100), in p_cp varchar(5), in p_ville varchar(50), in p_pays varchar(50), in p_etat enum("Prospect", "Client actif", "Client très actif"), in p_role enum("client", "admin"), in p_bloque int, in p_nbConnexion int, in p_date_changement_mdp datetime)
Begin
update client set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
update particulier set nom = p_nom, prenom = p_prenom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
End //
Delimiter ;

Drop procedure if exists deleteParticulier;
Delimiter //
Create procedure deleteParticulier(in p_tel varchar(10), in p_email varchar(50))
Begin
delete from particulier where tel = p_tel and email = p_email;
delete from client where tel = p_tel and email = p_email;
End //
Delimiter ;

Create table professionnel (
idclient int(11) not null,
nom varchar(30),
tel varchar(10) UNIQUE,
email varchar(50) UNIQUE,
mdp varchar(255),
adresse varchar(100),
cp varchar(5),
ville varchar(50),
pays varchar(50),
numSIRET varchar(50),
statut varchar(30),
etat enum("Prospect", "Client actif", "Client très actif"),
role enum("client", "admin"),
nbTentatives int not null default 0,
bloque int not null default 0,
nbConnexion int not null default 0,
type enum("Professionnel"),
date_creation_mdp datetime,
date_dernier_changement_mdp datetime,
date_creation_compte datetime,
primary key (idclient)
) ENGINE=InnoDB, CHARSET=utf8;

Drop function if exists countTelProfessionnel;
Delimiter //
Create function countTelProfessionnel(newtel varchar(10))
returns int
Deterministic
Begin
select count(*) from professionnel where tel = newtel into @result;
return @result;
End //
Delimiter ;

Drop trigger if exists checkTelProfessionnel;
Delimiter //
Create trigger checkTelProfessionnel
Before insert on particulier
For each row
Begin
if countTelProfessionnel(new.tel)
then signal sqlstate '45000'
set message_text = 'Telephone deja utilisee !';
end if ;
End //
Delimiter ;

Drop function if exists countEmailProfessionnel;
Delimiter //
Create function countEmailProfessionnel(newemail varchar(50))
returns int
Deterministic
Begin
select count(*) from professionnel where email = newemail into @result;
return @result;
End //
Delimiter ;

Drop trigger if exists checkEmailProfessionnel;
Delimiter //
Create trigger checkEmailProfessionnel
Before insert on professionnel
For each row
Begin
if countEmailProfessionnel(new.email)
then signal sqlstate '45000'
set message_text = 'Email deja utilisee !';
end if ;
End //
Delimiter ;

Drop procedure if exists insertProfessionnel;
Delimiter //
Create procedure insertProfessionnel(in p_nom varchar(30), in p_tel varchar(10), in p_email varchar(50), in p_mdp varchar(255), in p_adresse varchar(100), in p_cp varchar(5), in p_ville varchar(50), in p_pays varchar(50), in p_numSIRET varchar(50), in p_statut varchar(30), in p_etat enum("Prospect", "Client actif", "Client très actif"), in p_role enum("client", "admin"))
Begin
declare p_idclient int(11);
insert into client values (null, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Professionnel', sysdate(), sysdate(), sysdate(), sysdate(), sysdate());
select idclient into p_idclient
from client
where tel = p_tel and email = p_email;
insert into professionnel values (p_idclient, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_numSIRET, p_statut, p_etat, p_role, 0, 0, 0, 'Professionnel', sysdate(), sysdate(), sysdate());
End //
Delimiter ;

call insertProfessionnel('CLIENTPRO1', '0262560147', 'clientpro1.clientpro1@gmail.com', 'Haqu1oeJat2', '95, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'client');
call insertProfessionnel('CLIENTPRO2', '0173212847', 'clientpro2.clientpro2@gmail.com', 'Io0ko0ohThi', '88, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'client');

# COMPTE(S) TEST
-- Compte professionnel (admin)
call insertProfessionnel('SUPERADMIN', '0202020202', 'super.admin@gmail.com', 'Azerty123', '61, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'admin');

Drop procedure if exists updateProfessionnel;
Delimiter //
Create procedure updateProfessionnel(in p_nom varchar(30), in p_tel varchar(10), in p_email varchar(50), in p_mdp varchar(255), in p_adresse varchar(100), in p_cp varchar(5), in p_ville varchar(50), in p_pays varchar(50), in p_statut varchar(30), in p_etat enum("Prospect", "Client actif", "Client très actif"), in p_role enum("client", "admin"), in p_bloque int, in p_nbConnexion int, in p_date_changement_mdp datetime)
Begin
update client set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
update professionnel set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, statut = p_statut, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
End //
Delimiter ;

Drop procedure if exists deleteProfessionnel;
Delimiter //
Create procedure deleteProfessionnel(in p_tel varchar(10), in p_email varchar(50))
Begin
delete from professionnel where tel = p_tel and email = p_email;
delete from client where tel = p_tel and email = p_email;
End //
Delimiter ;

Create table type (
idtype int(11) not null auto_increment,
libelle varchar(50) not null UNIQUE,
primary key (idtype)
) ENGINE=InnoDB, CHARSET=utf8;

Insert into type values
(null, 'Autoradio'),
(null, 'GPS'),
(null, 'Aide a la conduite'),
(null, 'Haut-parleurs'),
(null, 'Kit mains-libre'),
(null, 'Amplificateur');

Drop trigger if exists checkTypeInsert;
Delimiter //
Create trigger checkTypeInsert
Before insert on type
For each row
Begin
if new.libelle = (select libelle from type where libelle = new.libelle)
then signal sqlstate '45000'
set message_text = 'Ce type est déjà enregistré !';
end if ;
End //
Delimiter ;

Create table produit (
idproduit int(11) not null auto_increment,
nomproduit varchar(100) not null UNIQUE,
imageproduit varchar(255),
descriptionproduit longtext,
qteproduit int(3) not null,
prixproduit decimal(6,2) not null,
idtype int(11) not null,
date_ajout datetime,
primary key (idproduit),
foreign key (idtype) references type (idtype)
on update cascade
on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Insert into produit values

-- Autoradio
(null, 'TOKAI LAR-15B', 'TOKAI_LAR-15B.png', 'Telephonie mains-libre via Bluetooth.', 22, 19.99, 1, sysdate()),
(null, 'PIONEER MVH-S110UB', 'PIONEER_MVH-S110UB.png', 'Controle de l autoradio a partir d un smartphone.', 25, 39.99, 1, sysdate()),
(null, 'SONY WX-920BT', 'SONY_WX-920BT.png', 'Telephonie mains-libre via Bluetooth et commande vocale SIRI.', 30, 199.99, 1, sysdate()),
(null, 'JVC KW-V420BT', 'JVC_KW-V420BT.png', 'Telephonie mains-libre via Bluetooth et commande vocale SIRI.', 5, 399.99, 1, sysdate()),

-- GPS
(null, 'MAPPY ULTI E538', 'MAPPY_ULTI_E538.png', 'Limitation de vitesse et mode de visualisation RealView.', 3, 79.99, 2, sysdate()),
(null, 'GARMIN DRIVE 51 LMT-S SE', 'GARMIN_DRIVE_51_LMT-S_SE.png', 'Alerte les zones de danger et carte de l Europe (15 pays) gratuits a vie', 5, 129.99, 2, sysdate()),
(null, 'POIDS LOURD SNOOPER PL6600', 'POIDS_LOURD_SNOOPER_PL6600.png', 'Guidage pernant en compte le gabarit.', 7, 599.0, 2, sysdate()),
(null, 'PIONEER AVIC-F88DAB', 'PIONEER_AVIC-F88DAB.png', 'Carte de l Europe (45 pays) et info trafic, compatible avec Apple Card Pay et Android Auto.', 8, 1299, 2, sysdate()),

-- Aide à la conduite
(null, 'CAMERA DE RECUL BEEPER RWEC100X-RF', 'CAMERA_DE_RECUL_BEEPER_RWEC100X-RF.png', 'Angle de vue de 140 horizontale.', 9, 199.99, 3, sysdate()),
(null, 'CAMERA DE RECUL BEEPER RWE200X-BL', 'CAMERA_DE_RECUL_BEEPER_RWEC200X-BL.png', 'Angle de vue 140 horizontale.', 10, 359.99, 3, sysdate()),
(null, 'CAMERA EMBARQUEE NEXTBASE NBDVR-101 HD', 'CAMERA_EMBARQUEE_NEXTBASE_NBDVR-101_HD.png', 'Angle de vue 120, sortie audio AV et microphone integre.', 11, 89.99, 3, sysdate()),
(null, 'CAMERA DE RECUL + ECRAN BEEPER RW037-P', 'CAMERA_DE_RECUL_+_ECRAN_BEEPER_RW037-P.png', 'Angle de vue 150 horizontale.', 12, 89.99, 3, sysdate()),

-- Haut-parleurs
(null, 'PIONEER Ts-13020 I', 'PIONEER_Ts-13020_I.png', 'Diametre de 13 cm et puissance de 130 Watts.', 13, 22.99, 4, sysdate()),
(null, 'FOCAL 130 AC', 'FOCAL_130_AC.png', 'Diametre de 13 cm et puissance de 100 Watts.', 14, 89.99, 4, sysdate()),
(null, 'MTX T6S652', 'MTX_T6S652.png', 'Diametre de 16.5 cmd et puissance de 400 Watts.', 15, 129.99, 4, sysdate()),
(null, 'FOCAL PS 165 F3', 'FOCAL_PS_165_F3.png', 'Diametre de 16.5cm et puissance de 160 Watts.', 16, 399, 4, sysdate()),

-- Kit mains-libre
(null, 'SUPERTOOTH BUDDY NOIR', 'SUPERTOOTH_BUDDY_NOIR.png', 'Connexion simultanee de 2 telephones, reconnexion automatique au telephone.', 17, 35.99, 5, sysdate()),
(null, 'PARROT NEO 2 HD', 'PARROT_NEO_2_HD.png', 'Connexion simultanee de 2 telephones, applications smartphones dediee avec fonction exclusives', 18, 79.99, 5, sysdate()),
(null, 'PARROT MKI9200', 'PARROT_MKI9200.png', 'Diffusion vocale et musicale sur les hauts-parleurs, telecommande sans fil positionnable au volant, connexion simultanee de 2 telephones.', 19, 249, 5, sysdate()),
(null, 'PARROT MKI9000', 'PARROT_MKI9000.png', 'Diffusion vocale et musicale sur les hauts-parleurs, connexion simultanee de 2 telephones, conversation de qualite grace aux douvles microphones.', 20, 169.99, 5, sysdate()),

-- Amplificateur
(null, 'MTX RFL4001D', 'MTX_RFL4001D.png', 'Puissance maximale de 12 000 Watts, dimensions en cm : 20.4 x 62.6 x 5.9', 21, 999, 6, sysdate()),
(null, 'JBL GX-A3001', 'JBL_GX-A3001.png', 'Puissance maximale de 415 Watts, dimensions en cm : 10.8 x 33.6 x 25', 22, 149.99, 6, sysdate()),
(null, 'MTX TR275', 'MTX_TR275.png', 'Puissance de 660 Watts, dimensions en cm : 14.2 x 13.4 x 5.1', 23, 275, 6, sysdate()),
(null, 'CALIBEER CA75.2', 'CALIBEER_CA75.2.png', 'Puissance maximale de 150 Watts, dimensions en cm : 3.8 x 7.8 x 10', 24, 42.99, 6, sysdate());

Create or replace view vproduit (idproduit, nomproduit, imageproduit, descriptionproduit, qteproduit, prixproduit, libelle, date_ajout) as
select p.idproduit, p.nomproduit, p.imageproduit, p.descriptionproduit, p.qteproduit, p.prixproduit, t.libelle, date_format(date_ajout, '%d/%m/%Y %H:%i')
from produit p, type t
where p.idtype = t.idtype
group by idproduit;

/* Triggers qui vérifient que le prix du produit ne soit pas en-dessous de 0 (prix<0) */
Drop trigger if exists verifPrixInsert;
Delimiter //
Create trigger verifPrixInsert
Before insert on produit
For each row
Begin
if new.prixProduit <= 0
then signal sqlstate '45000'
set message_text = 'Le prix ne doit pas être inferieur a 0';
end if ;
End //
Delimiter ;

Drop trigger if exists verifPrixUpdate;
Delimiter //
Create trigger verifPrixUpdate
Before update on produit
For each row
Begin
if new.prixProduit <= 0
then signal sqlstate '45000'
set message_text = 'Le prix ne doit pas être inferieur a 0';
end if ;
End //
Delimiter ;

Create table admin (
idadmin int(11) not null auto_increment,
email varchar(50) UNIQUE,
mdp varchar(50),
droit int not null default 0,
primary key (idadmin)
) ENGINE=InnoDB, CHARSET=utf8;

Drop trigger if exists modifierMdp;
Delimiter //
Create trigger modifierMdp
Before insert on admin
For each row
Begin
set new.mdp = sha1(new.mdp);
End //
Delimiter ;

Insert into admin values (null, 'admin@gmail.com', '123', 1);

Create table BDD (
nom_bdd varchar(60) not null,
nb_views int,
nb_triggers int,
nb_procedures int,
nb_functions int,
primary key (nom_bdd)
) ENGINE=InnoDB;

Drop procedure if exists statsbdd;
Delimiter //
Create procedure statsbdd(nomBdd varchar(60))
Begin
declare nbview, nbtrigger, nbprocedure, nbfunction int;

select count(*) into nbview 
from information_schema.views
where TABLE_SCHEMA = nomBdd;

select count(*) into nbtrigger
from information_schema.triggers
where TRIGGER_SCHEMA = nomBdd;

select count(*) into nbprocedure
from information_schema.ROUTINES
where ROUTINE_SCHEMA = nomBdd
and ROUTINE_TYPE = 'procedure';

select count(*) into nbfunction
from information_schema.ROUTINES
where ROUTINE_SCHEMA = nomBdd
and ROUTINE_TYPE = 'function';

insert into BDD values (nomBdd, nbview, nbtrigger, nbprocedure, nbfunction);
End //
Delimiter ;

Select * from BDD;

Create or replace view vstatsproduits as
SELECT
ifnull(nomproduit, 'TOTAL') nomproduit,
SUM(IF(libelle='Autoradio', prixproduit, "")) AS 'autoradio',
SUM(IF(libelle='GPS', prixproduit, "")) AS 'gps',
SUM(IF(libelle='Aide à la conduite', prixproduit, "")) AS 'aide_a_la_conduite',
SUM(IF(libelle='Haut-parleurs', prixproduit, "")) AS 'haut_parleurs',
SUM(IF(libelle='Kit mains-libre', prixproduit, "")) AS 'kit_mains_libre',
SUM(IF(libelle='Amplificateur', prixproduit, "")) AS 'amplificateurs'
FROM vproduit
GROUP BY nomproduit with rollup;

Select * from vstatsproduits;

Create table question (
idquestion int(11) not null auto_increment,
enonce longtext,
primary key (idquestion)
) ENGINE=InnoDB, CHARSET=utf8;

Insert into question values
(null, "Quelle est la personnalité historique que vous préférez ?"),
(null, "Quel est votre acteur, musicien ou artiste favori ?"),
(null, "Dans quelle ville se sont rencontrés vos parents ?"),
(null, "Quel est le nom de famille de votre professeur d'enfance préféré ?");

Create table reponse (
idreponse int(11) not null auto_increment,
idquestion int(11) not null,
reponse text,
idclient int(11) not null,
primary key (idreponse),
foreign key (idquestion) references question (idquestion)
on update cascade
on delete cascade,
foreign key (idclient) references client (idclient)
on update cascade
on delete cascade
) ENGINE=InnoDB, CHARSET=utf8;

Insert into reponse values
(null, 2, 'Tom Hanks', 1),
(null, 3, 'Paris', 2),
(null, 1, 'Napoléon', 3);

Create or replace view mesQuestions(idreponse, idquestion, enonce, reponse, idclient, client, email)
as select r.idreponse, q.idquestion, q.enonce, r.reponse, c.idclient, c.nom, c.email
from reponse r inner join question q
on r.idquestion = q.idquestion
inner join client c
on r.idclient = c.idclient
group by r.idreponse;

select * from mesQuestions;

Drop procedure if exists insertReponse;
Delimiter //
Create procedure insertReponse(in p_enonce longtext, in p_reponse text, in p_email varchar(50), in p_mdp varchar(255))
Begin
declare p_idquestion int(11);
declare p_idclient int(11);

select idquestion into p_idquestion
from question
where enonce = p_enonce;

select idclient into p_idclient
from client
where email = p_email and mdp = sha1(p_mdp);

insert into reponse values (null, p_idquestion, p_reponse, p_idclient);
End //
Delimiter ;

Create or replace view TP (libelle, nomproduit) as
select t.libelle, p.nomproduit
from type t, produit p
where t.idtype = p.idtype
order by t.libelle;

call statsbdd('stage');

select * from BDD;

show tables;

-- select timediff(deconnexion, connexion) as temps_session from client where idclient = 4;

Select count(*) as nbproduit
From produit p, type t
Where p.idtype = t.idtype;

Create or replace view nbProduitCat (categorie, nbproduit)
as select t.libelle, count(p.idproduit)
from produit p, type t
where p.idtype = t.idtype
group by t.libelle;

select * from nbProduitCat;

select count(*) from produit;

Insert into produit values (null, 'TOKAI LAR-15Baaaa', 'TOKAI_LAR-15Baaa.png', 'Telephonie mains-libre via Bluetooth.', 22, 19.99, 1, sysdate());

/*Modification apporté par Moustapha le plus fort du monde*/
Drop procedure if exists updateSalle;
Delimiter //
Create procedure updateSalle(in p_idsalle int, in p_batiment varchar(30), in p_nom varchar(10))
Begin
update salle set nom = p_nom, batiment = p_batiment
where idsalle = p_idsalle;
End //
Delimiter ;

/*Modification apporté par Moustapha le plus fort du monde*/
Drop procedure if exists deleteSalle;
Delimiter //
Create procedure deleteSalle(in p_idsalle int)
Begin
delete from salle where idsalle = p_idsalle;
End //
Delimiter ;

/*Modification apporté par Moustapha le plus fort du monde*/
Drop procedure if exists insertSalle;
Delimiter //
Create procedure insertSalle(in p_batiment varchar(10), in p_nom varchar(10))
Begin
insert into salle (batiment, nom) values (p_batiment, p_nom);
End //
Delimiter ;

/*Modifier apporté par Moustapha le plus fort du monde*/
Drop procedure if exists updateIntervention;
Delimiter //
Create procedure updateIntervention(in p_idintervention int, in p_responsable varchar(50), in p_email varchar(100), in p_date_intervention date, in p_classe varchar(30), in p_nom_salle varchar(10), in p_heure time, in p_etat varchar(50))
Begin
update intervention set responsable = p_responsable, email = p_email, date_intervention = p_date_intervention, classe = p_classe, nom_salle = p_nom_salle, heure = p_heure, etat = p_etat
where idintervention = p_idintervention;
End //
Delimiter ;

/*Modifier apporté par Moustapha le plus fort du monde*/
Drop procedure if exists insertIntervention;
Delimiter //
Create procedure insertIntervention(in p_responsable varchar(50), in p_email varchar(100), in p_date_intervention date, in p_classe varchar(30), in p_nom_salle varchar(10), in p_heure time, in p_nom_inter varchar(50), p_prenom_inter varchar(50), p_organisme varchar(100), p_presentation_ca varchar(10), p_date_presentation date, p_infos varchar(500), p_lieu_repas varchar(50), p_payeur varchar(50), p_besoin_parking varchar(10), p_infos2 varchar(500), p_type_intervention varchar(50), p_date_transmission date, p_responsable_form varchar(50))
Begin
insert into intervention (responsable, email, date_intervention, classe, nom_salle, heure, nom_inter, prenom_inter, organisme, presentation_ca, date_presentation, infos, lieu_repas, payeur, besoin_parking, infos2, type_intervention, date_transmission, responsable_form) values (p_responsable, p_email, p_date_intervention, p_classe, p_nom_salle, p_heure, p_nom_inter, p_prenom_inter, p_organisme, p_presentation_ca, p_date_presentation, p_infos, p_lieu_repas, p_payeur, p_besoin_parking, p_infos2, p_type_intervention, p_date_transmission, p_responsable_form);
End //
Delimiter ;