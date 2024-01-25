<?php

$unControleur->setTable("salle");
$lesSalles = $unControleur->selectAll("*");




$sallesParPage = 5;

$sallesTotales = $unControleur->getIdSalle();

$pagesTotales = ceil($sallesTotales / $sallesParPage);


if (isset($_GET['p']) and !empty($_GET['p']) and $_GET['p'] > 0) {
	$_GET['p'] = intval($_GET['p']);
	$pageCourante = $_GET['p'];
} else {
	$pageCourante = 1;
}

//Gestion de la pagination des pages suivantes et précédente
$pagePrecedente = $pageCourante - 1;
$pageSuivante = $pageCourante + 1;
$depart = ($pageCourante-1) * $sallesParPage;
//Au niveau du contrôleur on se positionne au niveau de la table salle
$unControleur->setTable("salle");

//Fonction pour récuperer l'ensemble des informations de la listes des salles
$lesSalles = $unControleur->selectAllSalles($depart, $sallesParPage);

//Ce bloque s'active lorsque que l'on a clique sur le boutton validé
if (isset($_POST['Valider'])) {
	$batiments = $_POST['bâtiment'];
	$tab = array("batiments");
	$lesSalles = $unControleur->selectSearch($mot, $tab);
}

//Ce bloque est accessible une fois qu'on est at=uthentifier et permet de gérer les fonctionnalités Ajouter, Modifier, Supprimer
if (isset($_SESSION['idclient']))
{
	$uneSalle = null;

	$unControleur->setTable("salle");


	if(isset($_GET['action']) && isset($_GET['idsalle']))
	{
		$action = $_GET['action'];
		$idsalle = $_GET['idsalle'];
		$where = array("idsalle"=>$idsalle);
		switch($action)
		{
			case 'edit':
				$uneSalle = $unControleur->selectWhere("*", $where);
		}
	}

	if(isset($_POST['Modifier']))
	{
		$unControleur->setTable("salle");
		if(isset($_SESSION['idclient']))
		{
			echo "Idsalle : ".$_POST['idsalle'];
			echo " Batiment : ".$_POST['batiment'];
			echo " Nom : ".$_POST['nom'];
			$tab = array(
				"idsalle"=>$_POST['idsalle'],
				"batiment"=>$_POST['batiment'],
				"nom"=>$_POST['nom']
			);
			$unControleur->appelProc("updateSalle", $tab);
		}
	}

	if (isset($_GET['Supprimer']))
	{

		$unControleur->setTable("salle");
		$idsalle = $_GET['idsalle'];
		$where = array("idsalle"=>$idsalle);
		$uneSalle = $unControleur->selectWhere("idsalle", $where);
		if ($uneSalle)
		{
			$tab = array("idsalle"=>$idsalle);
			$unControleur->appelProc("deleteSalle", $tab);
			echo '<script language="javascript">document.location.replace("deconnexion");</script>';
		}
	}

	if(isset($_POST['Ajouter']))
	{
		echo "passage 2";
		$unControleur->setTable("salle");
		if(isset($_SESSION['idclient']))
		{
			/*echo "Batiment : ".$_POST['batiment'];
			echo "Nom : ".$_POST['nom'];*/
			$tab = array(
				"batiment"=>$_POST['batiment'],
				"nom"=>$_POST['nom']
			);
			$unControleur->appelProc("insertSalle", $tab);
		}
	}



}


if(isset($_GET['action']) || isset($_GET['idsalle']))
{

	require_once("vue/salle_modif.php");
}
else
{
	require_once("vue/salle.php");
}




?>


