<?php
//Récupération de la date sélectionné
if (isset($_SESSION['idclient']))
{
    if(isset($_POST['date_affichage']))
    {
        $date_affichage = $_POST['date_affichage'];
    }
    else
    {
        $currentDateTime = new DateTime('now');
        $date_affichage = $currentDateTime->format('Y-m-d');
    
    }
//Position dans la table intervention
$unControleur->setTable("intervention");
$count=0;
//Création de la date du jour
$date = new DateTime();
// liste de récupérations de tte les interventions par date
$where = array("date_intervention"=>$date_affichage);
$lesInterventions = $unControleur->selectWhereAll($where);

if(!empty($lesInterventions))
{
foreach ($lesInterventions as $uneIntervention) {
    $count++;
    };
}
 
}




    

    require_once("vue/affichage.php");
?>

