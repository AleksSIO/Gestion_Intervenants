<?php
//Récupération de la date sélectionné

if (isset($_SESSION['idclient']))
{
    echo "1";
    if(isset($_POST['date_affichage']))
    {
        echo "2";
        $date_affichage = $_POST['date_affichage'];
        echo "date : ".$date_affichage;
    }
    else
    {
        $currentDateTime = new DateTime('now');
        $date_affichage = $currentDateTime->format('Y-m-d');
        echo "date : ".$date_affichage;
    
    }
//Position dans la table intervention
$unControleur->setTable("intervention");
$count=0;
//Création de la date du jour
$date = new DateTime();
// liste de récupérations de tte les interventions par date
$where = array("date_intervention"=>$date_affichage);
$lesInterventions = $unControleur->selectWhere("date_intervention", $where);

foreach ($lesInterventions as $uneIntervention) {
    $count++;
    };
    

 
}




    

    require_once("vue/affichage.php");
?>

