<?php

$unControleur->setTable("intervention");
$lesInterventions = $unControleur->selectAll("*");

$interventionsParPage = 8;

$interventionsTotales = $unControleur->getIdInterventions();

$pagesTotales = ceil($interventionsTotales / $interventionsParPage);


if (isset($_GET['p']) and !empty($_GET['p']) and $_GET['p'] > 0) {
	$_GET['p'] = intval($_GET['p']);
	$pageCourante = $_GET['p'];
} else {
	$pageCourante = 1;
}

//Gestion de la pagination des pages suivantes et précédente
$pagePrecedente = $pageCourante - 1;
$pageSuivante = $pageCourante + 1;
$depart = ($pageCourante-1) * $interventionsParPage;
//Au niveau du contrôleur on se positionne au niveau de la table intervention
$unControleur->setTable("intervention");

//Fonction pour récuperer l'ensemble des informations de la listes des salles
$lesInterventions = $unControleur->selectAllInterventions($depart, $interventionsParPage);

//Ce bloque est accessible une fois qu'on est authentifier et permet de gérer la fonctionnalités Ajouter, Modifier, Supprimer
if (isset($_SESSION['idclient']))
{
	$uneIntervention = null;

	$unControleur->setTable("intervention");


	if(isset($_GET['action']) && isset($_GET['idintervention']))
	{
		$action = $_GET['action'];
		$idintervention = $_GET['idintervention'];
		$where = array("idintervention"=>$idintervention);
		switch($action)
		{
			case 'edit':
				$uneIntervention = $unControleur->selectWhere($where ,"*");
		}
	}

    
	if(isset($_POST['Modifier']) || isset($_POST['Refuser']))
	{
        

		$unControleur->setTable("intervention");
		if(isset($_SESSION['idclient']))
		{
			echo "Id intevention : ".$_POST['idintervention'];
			echo " Responsable : ".$_POST['responsable'];
			echo " email : ".$_POST['email'];
            
            if(isset($_POST['Modifier']))
            {
                $etat = "Valider";
            }

            if(isset($_POST['Refuser']))
            {
                $etat = "Refusé";
            }

			$tab = array(
				"idintervention"=>$_POST['idintervention'],
				"responsable"=>$_POST['responsable'],
				"email"=>$_POST['email'],
                "date_intervention"=>$_POST['date_intervention'],
                "classe"=>$_POST['classe'],
                "nom_salle"=>$_POST['nom_salle'],
                "heure"=>$_POST['heure'],
                "etat"=>$etat
                

			);
			$unControleur->appelProc("updateIntervention", $tab);
		}
	}

	if (isset($_GET['Supprimer']))
	{

		$unControleur->setTable("intervention");
		$idsalle = $_GET['idsalle'];
		$where = array("idsalle"=>$idsalle);
		$uneSalle = $unControleur->selectWhere($where, "idsalle");
		if ($uneSalle)
		{
			$tab = array("idsalle"=>$idsalle);
			$unControleur->appelProc("deleteSalle", $tab);
			echo '<script language="javascript">document.location.replace("deconnexion");</script>';
		}
	}

	if(isset($_POST['Ajouter']))
	{
		
		$unControleur->setTable("intervention");
		if(isset($_SESSION['idclient']))
		{
			echo " - responsable ".$_POST['responsable'];
            echo " - email ".$_POST['email'];
            echo " - date_intervention ".$_POST['date_intervention'];
            echo " - classe ".$_POST['classe'];
            echo " - nom_salle ".$_POST['nom_salle'];
            echo " - heure ".$_POST['heure'];
            echo " - nom_inter ".$_POST['nom_inter'];
            echo " - prenom_inter ".$_POST['prenom_inter'];
            echo " - organisme ".$_POST['organisme'];
            echo " - presentation_ca ".$_POST['presentation_ca'];
            echo " - date_presentation ".$_POST['date_presentation'];
            echo " - infos ".$_POST['infos'];
            echo " - lieu_repas ".$_POST['lieu_repas'];
            echo " - payeur ".$_POST['payeur'];
            echo " - besoin_parking ".$_POST['besoin_parking'];
            echo " - infos2 ".$_POST['infos2'];
            echo " - type_intervention ".$_POST['type_intervention'];
            echo " - date_transmission ".$_POST['date_transmission'];
            echo " - responsable_form ".$_POST['responsable_form'];
            
            if(empty($_POST['date_presentation']))
            {
                echo " nulllll ";
                $date_presentation = '1900-01-01';
            }
            else
            {
                echo " présent ";
                $date_presentation = $_POST['date_presentation'];
            }
                
            

			$tab = array(
				"responsable"=>$_POST['responsable'],
				"email"=>$_POST['email'],
                "date_intervention"=>$_POST['date_intervention'],
                "classe"=>$_POST['classe'],
                "nom_salle"=>$_POST['nom_salle'],
                "heure"=>$_POST['heure'],
                "nom_inter"=>$_POST['nom_inter'],
                "prenom_inter"=>$_POST['prenom_inter'],
                "organisme"=>$_POST['organisme'],
                "presentation_ca"=>$_POST['presentation_ca'],
                "date_presentation"=>$date_presentation,
                "infos"=>$_POST['infos'],
                "lieu_repas"=>$_POST['lieu_repas'],
                "payeur"=>$_POST['payeur'],
                "besoin_parking"=>$_POST['besoin_parking'],
                "infos2"=>$_POST['infos2'],
                "type_intervention"=>$_POST['type_intervention'],
                "date_transmission"=>$_POST['date_transmission'],
                "responsable_form"=>$_POST['responsable_form']
                
			);
			$unControleur->appelProc("insertIntervention", $tab);
		}
	}



}


if(isset($_GET['action']) || isset($_GET['idintervention']))
{
    

	require_once("vue/intervention_modif.php");
}
else
{
    
	require_once("vue/intervention_admin.php");
}





?>



