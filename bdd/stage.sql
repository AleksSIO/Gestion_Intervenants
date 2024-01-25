-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 25 jan. 2024 à 15:09
-- Version du serveur : 8.0.30
-- Version de PHP : 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `stage`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteParticulier` (IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50))   Begin
delete from particulier where tel = p_tel and email = p_email;
delete from client where tel = p_tel and email = p_email;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProfessionnel` (IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50))   Begin
delete from professionnel where tel = p_tel and email = p_email;
delete from client where tel = p_tel and email = p_email;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSalle` (IN `p_idsalle` INT)   Begin
delete from salle where idsalle = p_idsalle;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertIntervention` (IN `p_responsable` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_date_intervention` DATE, IN `p_classe` VARCHAR(30), IN `p_nom_salle` VARCHAR(10), IN `p_heure` TIME, IN `p_nom_inter` VARCHAR(50), `p_prenom_inter` VARCHAR(50), `p_organisme` VARCHAR(100), `p_presentation_ca` VARCHAR(10), `p_date_presentation` DATE, `p_infos` VARCHAR(500), `p_lieu_repas` VARCHAR(50), `p_payeur` VARCHAR(50), `p_besoin_parking` VARCHAR(10), `p_infos2` VARCHAR(500), `p_type_intervention` VARCHAR(50), `p_date_transmission` DATE, `p_responsable_form` VARCHAR(50))   Begin
insert into intervention (responsable, email, date_intervention, classe, nom_salle, heure, nom_inter, prenom_inter, organisme, presentation_ca, date_presentation, infos, lieu_repas, payeur, besoin_parking, infos2, type_intervention, date_transmission, responsable_form) values (p_responsable, p_email, p_date_intervention, p_classe, p_nom_salle, p_heure, p_nom_inter, p_prenom_inter, p_organisme, p_presentation_ca, p_date_presentation, p_infos, p_lieu_repas, p_payeur, p_besoin_parking, p_infos2, p_type_intervention, p_date_transmission, p_responsable_form);
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertParticulier` (IN `p_nom` VARCHAR(30), IN `p_prenom` VARCHAR(30), IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50), IN `p_mdp` VARCHAR(255), IN `p_adresse` VARCHAR(100), IN `p_cp` VARCHAR(5), IN `p_ville` VARCHAR(50), IN `p_pays` VARCHAR(50), IN `p_etat` ENUM("Prospect","Client actif","Client très actif"), IN `p_role` ENUM("client","admin"))   Begin
declare p_idclient int(11);
insert into client values (null, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Particulier', sysdate(), sysdate(), sysdate(), sysdate(), sysdate());
select idclient into p_idclient
from client
where tel = p_tel and email = p_email;
insert into particulier values (p_idclient, p_nom, p_prenom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Particulier', sysdate(), sysdate(), sysdate());
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertProfessionnel` (IN `p_nom` VARCHAR(30), IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50), IN `p_mdp` VARCHAR(255), IN `p_adresse` VARCHAR(100), IN `p_cp` VARCHAR(5), IN `p_ville` VARCHAR(50), IN `p_pays` VARCHAR(50), IN `p_numSIRET` VARCHAR(50), IN `p_statut` VARCHAR(30), IN `p_etat` ENUM("Prospect","Client actif","Client très actif"), IN `p_role` ENUM("client","admin"))   Begin
declare p_idclient int(11);
insert into client values (null, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_etat, p_role, 0, 0, 0, 'Professionnel', sysdate(), sysdate(), sysdate(), sysdate(), sysdate());
select idclient into p_idclient
from client
where tel = p_tel and email = p_email;
insert into professionnel values (p_idclient, p_nom, p_tel, p_email, sha1(p_mdp), p_adresse, p_cp, p_ville, p_pays, p_numSIRET, p_statut, p_etat, p_role, 0, 0, 0, 'Professionnel', sysdate(), sysdate(), sysdate());
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertReponse` (IN `p_enonce` LONGTEXT, IN `p_reponse` TEXT, IN `p_email` VARCHAR(50), IN `p_mdp` VARCHAR(255))   Begin
declare p_idquestion int(11);
declare p_idclient int(11);

select idquestion into p_idquestion
from question
where enonce = p_enonce;

select idclient into p_idclient
from client
where email = p_email and mdp = sha1(p_mdp);

insert into reponse values (null, p_idquestion, p_reponse, p_idclient);
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSalle` (IN `p_batiment` VARCHAR(10), IN `p_nom` VARCHAR(10))   Begin
insert into salle (batiment, nom) values (p_batiment, p_nom);
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `statsbdd` (`nomBdd` VARCHAR(60))   Begin
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
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateIntervention` (IN `p_idintervention` INT, IN `p_responsable` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_date_intervention` DATE, IN `p_classe` VARCHAR(30), IN `p_nom_salle` VARCHAR(10), IN `p_heure` TIME, IN `p_etat` VARCHAR(50))   Begin
update intervention set responsable = p_responsable, email = p_email, date_intervention = p_date_intervention, classe = p_classe, nom_salle = p_nom_salle, heure = p_heure, etat = p_etat
where idintervention = p_idintervention;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateParticulier` (IN `p_nom` VARCHAR(30), IN `p_prenom` VARCHAR(30), IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50), IN `p_mdp` VARCHAR(255), IN `p_adresse` VARCHAR(100), IN `p_cp` VARCHAR(5), IN `p_ville` VARCHAR(50), IN `p_pays` VARCHAR(50), IN `p_etat` ENUM("Prospect","Client actif","Client très actif"), IN `p_role` ENUM("client","admin"), IN `p_bloque` INT, IN `p_nbConnexion` INT, IN `p_date_changement_mdp` DATETIME)   Begin
update client set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
update particulier set nom = p_nom, prenom = p_prenom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProfessionnel` (IN `p_nom` VARCHAR(30), IN `p_tel` VARCHAR(10), IN `p_email` VARCHAR(50), IN `p_mdp` VARCHAR(255), IN `p_adresse` VARCHAR(100), IN `p_cp` VARCHAR(5), IN `p_ville` VARCHAR(50), IN `p_pays` VARCHAR(50), IN `p_statut` VARCHAR(30), IN `p_etat` ENUM("Prospect","Client actif","Client très actif"), IN `p_role` ENUM("client","admin"), IN `p_bloque` INT, IN `p_nbConnexion` INT, IN `p_date_changement_mdp` DATETIME)   Begin
update client set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
update professionnel set nom = p_nom, tel = p_tel, email = p_email, mdp = sha1(p_mdp), adresse = p_adresse, cp = p_cp, ville = p_ville, pays = p_pays, statut = p_statut, etat = p_etat, role = p_role, bloque = p_bloque, nbConnexion = p_nbConnexion, date_dernier_changement_mdp = p_date_changement_mdp
where tel = p_tel and email = p_email;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSalle` (IN `p_idsalle` INT, IN `p_batiment` VARCHAR(30), IN `p_nom` VARCHAR(10))   Begin
update salle set nom = p_nom, batiment = p_batiment
where idsalle = p_idsalle;
End$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `countEmailParticulier` (`newemail` VARCHAR(50)) RETURNS INT DETERMINISTIC Begin
select count(*) from particulier where email = newemail into @result;
return @result;
End$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countEmailProfessionnel` (`newemail` VARCHAR(50)) RETURNS INT DETERMINISTIC Begin
select count(*) from professionnel where email = newemail into @result;
return @result;
End$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countTelParticulier` (`newtel` VARCHAR(10)) RETURNS INT DETERMINISTIC Begin
select count(*) from particulier where tel = newtel into @result;
return @result;
End$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countTelProfessionnel` (`newtel` VARCHAR(10)) RETURNS INT DETERMINISTIC Begin
select count(*) from professionnel where tel = newtel into @result;
return @result;
End$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `idadmin` int NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(50) DEFAULT NULL,
  `droit` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`idadmin`, `email`, `mdp`, `droit`) VALUES
(1, 'admin@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1);

--
-- Déclencheurs `admin`
--
DELIMITER $$
CREATE TRIGGER `modifierMdp` BEFORE INSERT ON `admin` FOR EACH ROW Begin
set new.mdp = sha1(new.mdp);
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `bdd`
--

CREATE TABLE `bdd` (
  `nom_bdd` varchar(60) NOT NULL,
  `nb_views` int DEFAULT NULL,
  `nb_triggers` int DEFAULT NULL,
  `nb_procedures` int DEFAULT NULL,
  `nb_functions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `bdd`
--

INSERT INTO `bdd` (`nom_bdd`, `nb_views`, `nb_triggers`, `nb_procedures`, `nb_functions`) VALUES
('stage', 5, 8, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `idclient` int NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `etat` enum('Prospect','Client actif','Client très actif') DEFAULT NULL,
  `role` enum('client','admin') DEFAULT NULL,
  `nbTentatives` int NOT NULL DEFAULT '0',
  `bloque` int NOT NULL DEFAULT '0',
  `nbConnexion` int NOT NULL DEFAULT '0',
  `type` enum('Particulier','Professionnel') DEFAULT NULL,
  `date_creation_mdp` datetime DEFAULT NULL,
  `date_dernier_changement_mdp` datetime DEFAULT NULL,
  `date_creation_compte` datetime DEFAULT NULL,
  `connexion` datetime DEFAULT NULL,
  `deconnexion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`idclient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`, `nbTentatives`, `bloque`, `nbConnexion`, `type`, `date_creation_mdp`, `date_dernier_changement_mdp`, `date_creation_compte`, `connexion`, `deconnexion`) VALUES
(1, 'CLIENT1', '0353952424', 'client1.client1@gmail.com', '85202cb5e62aa20889886fb546ab5d22f8c0bd08', '3, rue de Aulnay', '93600', 'AULNAY SOUS BOISA', 'France', 'Prospect', 'client', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(2, 'CLIENT2', '0214316122', 'client2.client2@gmail.com', 'f5116ff48b50defd772a3a95b7ea1fcd1f9343e8', '15, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'client', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(3, 'ADMIN1', '0101010101', 'admin1.admin1@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin', 0, 0, 2, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-25 15:53:04', '2024-01-23 10:49:40'),
(4, 'ADMIN2', '0101010102', 'admin2.admin2@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(5, 'CLIENTPRO1', '0262560147', 'clientpro1.clientpro1@gmail.com', '45fedd7522cdf5797af7da40a2171237972c8d6b', '95, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'client', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(6, 'CLIENTPRO2', '0173212847', 'clientpro2.clientpro2@gmail.com', 'b79a0312ecc0dc9635163aa2428265157d880fb2', '88, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'client', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(7, 'SUPERADMIN', '0202020202', 'super.admin@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '61, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40');

-- --------------------------------------------------------

--
-- Structure de la table `intervention`
--

CREATE TABLE `intervention` (
  `idintervention` int NOT NULL,
  `responsable` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `date_intervention` date DEFAULT NULL,
  `classe` varchar(30) DEFAULT NULL,
  `nom_salle` varchar(10) DEFAULT NULL,
  `heure` time DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  `nom_inter` varchar(50) NOT NULL,
  `prenom_inter` varchar(50) NOT NULL,
  `organisme` varchar(100) NOT NULL,
  `presentation_ca` varchar(10) NOT NULL,
  `date_presentation` date NOT NULL,
  `infos` varchar(500) NOT NULL,
  `lieu_repas` varchar(50) NOT NULL,
  `payeur` varchar(50) NOT NULL,
  `besoin_parking` varchar(10) NOT NULL,
  `infos2` varchar(500) NOT NULL,
  `type_intervention` varchar(50) NOT NULL,
  `date_transmission` date NOT NULL,
  `responsable_form` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `mesquestions`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `mesquestions` (
`client` varchar(30)
,`email` varchar(50)
,`enonce` longtext
,`idclient` int
,`idquestion` int
,`idreponse` int
,`reponse` text
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nbproduitcat`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nbproduitcat` (
`categorie` varchar(50)
,`nbproduit` bigint
);

-- --------------------------------------------------------

--
-- Structure de la table `particulier`
--

CREATE TABLE `particulier` (
  `idclient` int NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `etat` enum('Prospect','Client actif','Client très actif') DEFAULT NULL,
  `role` enum('client','admin') DEFAULT NULL,
  `nbTentatives` int NOT NULL DEFAULT '0',
  `bloque` int NOT NULL DEFAULT '0',
  `nbConnexion` int NOT NULL DEFAULT '0',
  `type` enum('Particulier') DEFAULT NULL,
  `date_creation_mdp` datetime DEFAULT NULL,
  `date_dernier_changement_mdp` datetime DEFAULT NULL,
  `date_creation_compte` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `particulier`
--

INSERT INTO `particulier` (`idclient`, `nom`, `prenom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`, `nbTentatives`, `bloque`, `nbConnexion`, `type`, `date_creation_mdp`, `date_dernier_changement_mdp`, `date_creation_compte`) VALUES
(1, 'CLIENT1', 'CLIENT1', '0353952424', 'client1.client1@gmail.com', '85202cb5e62aa20889886fb546ab5d22f8c0bd08', '3, rue de Aulnay', '93600', 'AULNAY SOUS BOISA', 'France', 'Prospect', 'client', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(2, 'CLIENT2', 'CLIENT2', '0214316122', 'client2.client2@gmail.com', 'f5116ff48b50defd772a3a95b7ea1fcd1f9343e8', '15, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'client', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(3, 'ADMIN1', 'ADMIN1', '0101010101', 'admin1.admin1@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(4, 'ADMIN2', 'ADMIN2', '0101010102', 'admin2.admin2@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '5, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', 'Prospect', 'admin', 0, 0, 0, 'Particulier', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40');

--
-- Déclencheurs `particulier`
--
DELIMITER $$
CREATE TRIGGER `checkEmailParticulier` BEFORE INSERT ON `particulier` FOR EACH ROW Begin
if countEmailParticulier(new.email)
then signal sqlstate '45000'
set message_text = 'Email deja utilisee !';
end if ;
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `checkTelParticulier` BEFORE INSERT ON `particulier` FOR EACH ROW Begin
if countTelParticulier(new.tel)
then signal sqlstate '45000'
set message_text = 'Telephone deja utilisee !';
end if ;
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `checkTelProfessionnel` BEFORE INSERT ON `particulier` FOR EACH ROW Begin
if countTelProfessionnel(new.tel)
then signal sqlstate '45000'
set message_text = 'Telephone deja utilisee !';
end if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `idproduit` int NOT NULL,
  `nomproduit` varchar(100) NOT NULL,
  `imageproduit` varchar(255) DEFAULT NULL,
  `descriptionproduit` longtext,
  `qteproduit` int NOT NULL,
  `prixproduit` decimal(6,2) NOT NULL,
  `idtype` int NOT NULL,
  `date_ajout` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`idproduit`, `nomproduit`, `imageproduit`, `descriptionproduit`, `qteproduit`, `prixproduit`, `idtype`, `date_ajout`) VALUES
(1, 'TOKAI LAR-15B', 'TOKAI_LAR-15B.png', 'Telephonie mains-libre via Bluetooth.', 22, 19.99, 1, '2024-01-23 10:49:41'),
(2, 'PIONEER MVH-S110UB', 'PIONEER_MVH-S110UB.png', 'Controle de l autoradio a partir d un smartphone.', 25, 39.99, 1, '2024-01-23 10:49:41'),
(3, 'SONY WX-920BT', 'SONY_WX-920BT.png', 'Telephonie mains-libre via Bluetooth et commande vocale SIRI.', 30, 199.99, 1, '2024-01-23 10:49:41'),
(4, 'JVC KW-V420BT', 'JVC_KW-V420BT.png', 'Telephonie mains-libre via Bluetooth et commande vocale SIRI.', 5, 399.99, 1, '2024-01-23 10:49:41'),
(5, 'MAPPY ULTI E538', 'MAPPY_ULTI_E538.png', 'Limitation de vitesse et mode de visualisation RealView.', 3, 79.99, 2, '2024-01-23 10:49:41'),
(6, 'GARMIN DRIVE 51 LMT-S SE', 'GARMIN_DRIVE_51_LMT-S_SE.png', 'Alerte les zones de danger et carte de l Europe (15 pays) gratuits a vie', 5, 129.99, 2, '2024-01-23 10:49:41'),
(7, 'POIDS LOURD SNOOPER PL6600', 'POIDS_LOURD_SNOOPER_PL6600.png', 'Guidage pernant en compte le gabarit.', 7, 599.00, 2, '2024-01-23 10:49:41'),
(8, 'PIONEER AVIC-F88DAB', 'PIONEER_AVIC-F88DAB.png', 'Carte de l Europe (45 pays) et info trafic, compatible avec Apple Card Pay et Android Auto.', 8, 1299.00, 2, '2024-01-23 10:49:41'),
(9, 'CAMERA DE RECUL BEEPER RWEC100X-RF', 'CAMERA_DE_RECUL_BEEPER_RWEC100X-RF.png', 'Angle de vue de 140 horizontale.', 9, 199.99, 3, '2024-01-23 10:49:41'),
(10, 'CAMERA DE RECUL BEEPER RWE200X-BL', 'CAMERA_DE_RECUL_BEEPER_RWEC200X-BL.png', 'Angle de vue 140 horizontale.', 10, 359.99, 3, '2024-01-23 10:49:41'),
(11, 'CAMERA EMBARQUEE NEXTBASE NBDVR-101 HD', 'CAMERA_EMBARQUEE_NEXTBASE_NBDVR-101_HD.png', 'Angle de vue 120, sortie audio AV et microphone integre.', 11, 89.99, 3, '2024-01-23 10:49:41'),
(12, 'CAMERA DE RECUL + ECRAN BEEPER RW037-P', 'CAMERA_DE_RECUL_+_ECRAN_BEEPER_RW037-P.png', 'Angle de vue 150 horizontale.', 12, 89.99, 3, '2024-01-23 10:49:41'),
(13, 'PIONEER Ts-13020 I', 'PIONEER_Ts-13020_I.png', 'Diametre de 13 cm et puissance de 130 Watts.', 13, 22.99, 4, '2024-01-23 10:49:41'),
(14, 'FOCAL 130 AC', 'FOCAL_130_AC.png', 'Diametre de 13 cm et puissance de 100 Watts.', 14, 89.99, 4, '2024-01-23 10:49:41'),
(15, 'MTX T6S652', 'MTX_T6S652.png', 'Diametre de 16.5 cmd et puissance de 400 Watts.', 15, 129.99, 4, '2024-01-23 10:49:41'),
(16, 'FOCAL PS 165 F3', 'FOCAL_PS_165_F3.png', 'Diametre de 16.5cm et puissance de 160 Watts.', 16, 399.00, 4, '2024-01-23 10:49:41'),
(17, 'SUPERTOOTH BUDDY NOIR', 'SUPERTOOTH_BUDDY_NOIR.png', 'Connexion simultanee de 2 telephones, reconnexion automatique au telephone.', 17, 35.99, 5, '2024-01-23 10:49:41'),
(18, 'PARROT NEO 2 HD', 'PARROT_NEO_2_HD.png', 'Connexion simultanee de 2 telephones, applications smartphones dediee avec fonction exclusives', 18, 79.99, 5, '2024-01-23 10:49:41'),
(19, 'PARROT MKI9200', 'PARROT_MKI9200.png', 'Diffusion vocale et musicale sur les hauts-parleurs, telecommande sans fil positionnable au volant, connexion simultanee de 2 telephones.', 19, 249.00, 5, '2024-01-23 10:49:41'),
(20, 'PARROT MKI9000', 'PARROT_MKI9000.png', 'Diffusion vocale et musicale sur les hauts-parleurs, connexion simultanee de 2 telephones, conversation de qualite grace aux douvles microphones.', 20, 169.99, 5, '2024-01-23 10:49:41'),
(21, 'MTX RFL4001D', 'MTX_RFL4001D.png', 'Puissance maximale de 12 000 Watts, dimensions en cm : 20.4 x 62.6 x 5.9', 21, 999.00, 6, '2024-01-23 10:49:41'),
(22, 'JBL GX-A3001', 'JBL_GX-A3001.png', 'Puissance maximale de 415 Watts, dimensions en cm : 10.8 x 33.6 x 25', 22, 149.99, 6, '2024-01-23 10:49:41'),
(23, 'MTX TR275', 'MTX_TR275.png', 'Puissance de 660 Watts, dimensions en cm : 14.2 x 13.4 x 5.1', 23, 275.00, 6, '2024-01-23 10:49:41'),
(24, 'CALIBEER CA75.2', 'CALIBEER_CA75.2.png', 'Puissance maximale de 150 Watts, dimensions en cm : 3.8 x 7.8 x 10', 24, 42.99, 6, '2024-01-23 10:49:41'),
(25, 'TOKAI LAR-15Baaaa', 'TOKAI_LAR-15Baaa.png', 'Telephonie mains-libre via Bluetooth.', 22, 19.99, 1, '2024-01-23 10:49:41');

--
-- Déclencheurs `produit`
--
DELIMITER $$
CREATE TRIGGER `verifPrixInsert` BEFORE INSERT ON `produit` FOR EACH ROW Begin
if new.prixProduit <= 0
then signal sqlstate '45000'
set message_text = 'Le prix ne doit pas être inferieur a 0';
end if ;
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `verifPrixUpdate` BEFORE UPDATE ON `produit` FOR EACH ROW Begin
if new.prixProduit <= 0
then signal sqlstate '45000'
set message_text = 'Le prix ne doit pas être inferieur a 0';
end if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `professionnel`
--

CREATE TABLE `professionnel` (
  `idclient` int NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `numSIRET` varchar(50) DEFAULT NULL,
  `statut` varchar(30) DEFAULT NULL,
  `etat` enum('Prospect','Client actif','Client très actif') DEFAULT NULL,
  `role` enum('client','admin') DEFAULT NULL,
  `nbTentatives` int NOT NULL DEFAULT '0',
  `bloque` int NOT NULL DEFAULT '0',
  `nbConnexion` int NOT NULL DEFAULT '0',
  `type` enum('Professionnel') DEFAULT NULL,
  `date_creation_mdp` datetime DEFAULT NULL,
  `date_dernier_changement_mdp` datetime DEFAULT NULL,
  `date_creation_compte` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `professionnel`
--

INSERT INTO `professionnel` (`idclient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `numSIRET`, `statut`, `etat`, `role`, `nbTentatives`, `bloque`, `nbConnexion`, `type`, `date_creation_mdp`, `date_dernier_changement_mdp`, `date_creation_compte`) VALUES
(5, 'CLIENTPRO1', '0262560147', 'clientpro1.clientpro1@gmail.com', '45fedd7522cdf5797af7da40a2171237972c8d6b', '95, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'client', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(6, 'CLIENTPRO2', '0173212847', 'clientpro2.clientpro2@gmail.com', 'b79a0312ecc0dc9635163aa2428265157d880fb2', '88, rue de aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'client', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40'),
(7, 'SUPERADMIN', '0202020202', 'super.admin@gmail.com', '107d348bff437c999a9ff192adcb78cb03b8ddc6', '61, rue de Aulnay', '93600', 'AULNAY SOUS BOIS', 'France', '521 868 267 00014', 'SARL', 'Prospect', 'admin', 0, 0, 0, 'Professionnel', '2024-01-23 10:49:40', '2024-01-23 10:49:40', '2024-01-23 10:49:40');

--
-- Déclencheurs `professionnel`
--
DELIMITER $$
CREATE TRIGGER `checkEmailProfessionnel` BEFORE INSERT ON `professionnel` FOR EACH ROW Begin
if countEmailProfessionnel(new.email)
then signal sqlstate '45000'
set message_text = 'Email deja utilisee !';
end if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `idquestion` int NOT NULL,
  `enonce` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`idquestion`, `enonce`) VALUES
(1, 'Quelle est la personnalité historique que vous préférez ?'),
(2, 'Quel est votre acteur, musicien ou artiste favori ?'),
(3, 'Dans quelle ville se sont rencontrés vos parents ?'),
(4, 'Quel est le nom de famille de votre professeur d\'enfance préféré ?');

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE `reponse` (
  `idreponse` int NOT NULL,
  `idquestion` int NOT NULL,
  `reponse` text,
  `idclient` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `reponse`
--

INSERT INTO `reponse` (`idreponse`, `idquestion`, `reponse`, `idclient`) VALUES
(1, 2, 'Tom Hanks', 1),
(2, 3, 'Paris', 2),
(3, 1, 'Napoléon', 3);

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

CREATE TABLE `salle` (
  `idsalle` int NOT NULL,
  `bâtiment` varchar(2) DEFAULT NULL,
  `nom` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `tp`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `tp` (
`libelle` varchar(50)
,`nomproduit` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `idtype` int NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`idtype`, `libelle`) VALUES
(3, 'Aide a la conduite'),
(6, 'Amplificateur'),
(1, 'Autoradio'),
(2, 'GPS'),
(4, 'Haut-parleurs'),
(5, 'Kit mains-libre');

--
-- Déclencheurs `type`
--
DELIMITER $$
CREATE TRIGGER `checkTypeInsert` BEFORE INSERT ON `type` FOR EACH ROW Begin
if new.libelle = (select libelle from type where libelle = new.libelle)
then signal sqlstate '45000'
set message_text = 'Ce type est déjà enregistré !';
end if ;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vclient`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vclient` (
`adresse` varchar(100)
,`bloque` int
,`connexion` varchar(21)
,`cp` varchar(5)
,`date_creation_compte` varchar(21)
,`date_creation_mdp` varchar(21)
,`date_dernier_changement_mdp` varchar(21)
,`deconnexion` varchar(21)
,`email` varchar(50)
,`etat` enum('Prospect','Client actif','Client très actif')
,`idclient` int
,`mdp` varchar(255)
,`nbConnexion` int
,`nbTentatives` int
,`nom` varchar(30)
,`pays` varchar(50)
,`role` enum('client','admin')
,`tel` varchar(10)
,`type` enum('Particulier','Professionnel')
,`ville` varchar(50)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vproduit`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vproduit` (
`date_ajout` varchar(21)
,`descriptionproduit` longtext
,`idproduit` int
,`imageproduit` varchar(255)
,`libelle` varchar(50)
,`nomproduit` varchar(100)
,`prixproduit` decimal(6,2)
,`qteproduit` int
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vstatsproduits`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vstatsproduits` (
`aide_a_la_conduite` double
,`amplificateurs` double
,`autoradio` double
,`gps` double
,`haut_parleurs` double
,`kit_mains_libre` double
,`nomproduit` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure de la vue `mesquestions`
--
DROP TABLE IF EXISTS `mesquestions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mesquestions` (`idreponse`, `idquestion`, `enonce`, `reponse`, `idclient`, `client`, `email`) AS   select `r`.`idreponse` AS `idreponse`,`q`.`idquestion` AS `idquestion`,`q`.`enonce` AS `enonce`,`r`.`reponse` AS `reponse`,`c`.`idclient` AS `idclient`,`c`.`nom` AS `nom`,`c`.`email` AS `email` from ((`reponse` `r` join `question` `q` on((`r`.`idquestion` = `q`.`idquestion`))) join `client` `c` on((`r`.`idclient` = `c`.`idclient`))) group by `r`.`idreponse`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `nbproduitcat`
--
DROP TABLE IF EXISTS `nbproduitcat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nbproduitcat` (`categorie`, `nbproduit`) AS   select `t`.`libelle` AS `libelle`,count(`p`.`idproduit`) AS `count(p.idproduit)` from (`produit` `p` join `type` `t`) where (`p`.`idtype` = `t`.`idtype`) group by `t`.`libelle`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `tp`
--
DROP TABLE IF EXISTS `tp`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tp` (`libelle`, `nomproduit`) AS   select `t`.`libelle` AS `libelle`,`p`.`nomproduit` AS `nomproduit` from (`type` `t` join `produit` `p`) where (`t`.`idtype` = `p`.`idtype`) order by `t`.`libelle`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `vclient`
--
DROP TABLE IF EXISTS `vclient`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vclient` (`idclient`, `nom`, `tel`, `email`, `mdp`, `adresse`, `cp`, `ville`, `pays`, `etat`, `role`, `nbTentatives`, `bloque`, `nbConnexion`, `type`, `date_creation_mdp`, `date_dernier_changement_mdp`, `date_creation_compte`, `connexion`, `deconnexion`) AS   select `client`.`idclient` AS `idclient`,`client`.`nom` AS `nom`,`client`.`tel` AS `tel`,`client`.`email` AS `email`,`client`.`mdp` AS `mdp`,`client`.`adresse` AS `adresse`,`client`.`cp` AS `cp`,`client`.`ville` AS `ville`,`client`.`pays` AS `pays`,`client`.`etat` AS `etat`,`client`.`role` AS `role`,`client`.`nbTentatives` AS `nbTentatives`,`client`.`bloque` AS `bloque`,`client`.`nbConnexion` AS `nbConnexion`,`client`.`type` AS `type`,date_format(`client`.`date_creation_mdp`,'%d/%m/%Y %H:%i') AS `date_format(date_creation_mdp, '%d/%m/%Y %H:%i')`,date_format(`client`.`date_dernier_changement_mdp`,'%d/%m/%Y %H:%i') AS `date_format(date_dernier_changement_mdp, '%d/%m/%Y %H:%i')`,date_format(`client`.`date_creation_compte`,'%d/%m/%Y %H:%i') AS `date_format(date_creation_compte, '%d/%m/%Y %H:%i')`,date_format(`client`.`connexion`,'%d/%m/%Y %H:%i') AS `date_format(connexion, '%d/%m/%Y %H:%i')`,date_format(`client`.`deconnexion`,'%d/%m/%Y %H:%i') AS `date_format(deconnexion, '%d/%m/%Y %H:%i')` from `client`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `vproduit`
--
DROP TABLE IF EXISTS `vproduit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vproduit` (`idproduit`, `nomproduit`, `imageproduit`, `descriptionproduit`, `qteproduit`, `prixproduit`, `libelle`, `date_ajout`) AS   select `p`.`idproduit` AS `idproduit`,`p`.`nomproduit` AS `nomproduit`,`p`.`imageproduit` AS `imageproduit`,`p`.`descriptionproduit` AS `descriptionproduit`,`p`.`qteproduit` AS `qteproduit`,`p`.`prixproduit` AS `prixproduit`,`t`.`libelle` AS `libelle`,date_format(`p`.`date_ajout`,'%d/%m/%Y %H:%i') AS `date_format(date_ajout, '%d/%m/%Y %H:%i')` from (`produit` `p` join `type` `t`) where (`p`.`idtype` = `t`.`idtype`) group by `p`.`idproduit`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `vstatsproduits`
--
DROP TABLE IF EXISTS `vstatsproduits`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vstatsproduits`  AS SELECT ifnull(`vproduit`.`nomproduit`,'TOTAL') AS `nomproduit`, sum(if((`vproduit`.`libelle` = 'Autoradio'),`vproduit`.`prixproduit`,'')) AS `autoradio`, sum(if((`vproduit`.`libelle` = 'GPS'),`vproduit`.`prixproduit`,'')) AS `gps`, sum(if((`vproduit`.`libelle` = 'Aide à la conduite'),`vproduit`.`prixproduit`,'')) AS `aide_a_la_conduite`, sum(if((`vproduit`.`libelle` = 'Haut-parleurs'),`vproduit`.`prixproduit`,'')) AS `haut_parleurs`, sum(if((`vproduit`.`libelle` = 'Kit mains-libre'),`vproduit`.`prixproduit`,'')) AS `kit_mains_libre`, sum(if((`vproduit`.`libelle` = 'Amplificateur'),`vproduit`.`prixproduit`,'')) AS `amplificateurs` FROM `vproduit` GROUP BY `vproduit`.`nomproduit`with rollup  ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`idadmin`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `bdd`
--
ALTER TABLE `bdd`
  ADD PRIMARY KEY (`nom_bdd`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`idclient`),
  ADD UNIQUE KEY `tel` (`tel`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `intervention`
--
ALTER TABLE `intervention`
  ADD PRIMARY KEY (`idintervention`);

--
-- Index pour la table `particulier`
--
ALTER TABLE `particulier`
  ADD PRIMARY KEY (`idclient`),
  ADD UNIQUE KEY `tel` (`tel`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`idproduit`),
  ADD UNIQUE KEY `nomproduit` (`nomproduit`),
  ADD KEY `idtype` (`idtype`);

--
-- Index pour la table `professionnel`
--
ALTER TABLE `professionnel`
  ADD PRIMARY KEY (`idclient`),
  ADD UNIQUE KEY `tel` (`tel`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`idquestion`);

--
-- Index pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD PRIMARY KEY (`idreponse`),
  ADD KEY `idquestion` (`idquestion`),
  ADD KEY `idclient` (`idclient`);

--
-- Index pour la table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`idsalle`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`idtype`),
  ADD UNIQUE KEY `libelle` (`libelle`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `idadmin` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `idclient` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `intervention`
--
ALTER TABLE `intervention`
  MODIFY `idintervention` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `idproduit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `idquestion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `reponse`
--
ALTER TABLE `reponse`
  MODIFY `idreponse` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `salle`
--
ALTER TABLE `salle`
  MODIFY `idsalle` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `idtype` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `particulier`
--
ALTER TABLE `particulier`
  ADD CONSTRAINT `particulier_ibfk_1` FOREIGN KEY (`idclient`) REFERENCES `client` (`idclient`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `produit_ibfk_1` FOREIGN KEY (`idtype`) REFERENCES `type` (`idtype`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD CONSTRAINT `reponse_ibfk_1` FOREIGN KEY (`idquestion`) REFERENCES `question` (`idquestion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reponse_ibfk_2` FOREIGN KEY (`idclient`) REFERENCES `client` (`idclient`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
