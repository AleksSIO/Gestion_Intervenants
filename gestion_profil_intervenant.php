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

if (isset($_SESSION['idclient']))
{
	$uneIntervention = null;

	$unControleur->setTable("intervention");

	if(isset($_POST['idintervention']))
	{
		$idintervention = $_POST['idintervention'];
		$where = array("idintervention"=>$idintervention);
	
	    $uneIntervention = $unControleur->selectWhere("*", $where);

	}

    require_once('vue/profil_intervenant.php');
}
