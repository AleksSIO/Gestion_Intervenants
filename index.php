<?php session_start();
require_once("controleur/config_bdd.php");
require_once("controleur/controleur.class.php");
$unControleur = new Controleur($hostname, $database, $username, $password);
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Gestion des intervenants</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="https://static.wixstatic.com/media/be4e46_99f4b18d5b0a4802959f8ea664f81878~mv2.png/v1/fill/w_103,h_71,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/be4e46_99f4b18d5b0a4802959f8ea664f81878~mv2.png" />
    <!-- FICHIERS CSS -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="assets/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/scroll.animate.css">
    <link rel="stylesheet" type="text/css" href="assets/zoombox/zoombox.css">
    <link rel="stylesheet" type="text/css" href="assets/css/navbar.css">
    <link rel="stylesheet" type="text/css" href="assets/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="assets/css/searchBar.css">
    <link rel="stylesheet" type="text/css" href="assets/css/selectedBox.css">
    <link rel="stylesheet" type="text/css" href="assets/css/footer.css">
    <link rel="stylesheet" type="text/css" href="assets/css/animate.min.css">
    <script src="assets/js/fontawesome.js"></script>
    <!-- BOX COOKIES -->
    <link rel="stylesheet" type="text/css" href="https://cdn.wpcc.io/lib/1.0.2/cookieconsent.min.css"/>
    <script src="https://cdn.wpcc.io/lib/1.0.2/cookieconsent.min.js" defer></script>
    <!-- / BOX COOKIES -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <?php if (isset($_GET['page']) && $_GET['page'] == "connexion") { ?>
        <link rel="stylesheet" type="text/css" href="assets/css/util.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main.css">
    <?php } elseif (isset($_GET['page']) && $_GET['page'] == "inscription-particulier") { ?>
        <link rel="stylesheet" type="text/css" href="assets/css/util.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main.css">
        <link rel="stylesheet" type="text/css" href="assets/css/inscription.css">
    <?php } elseif (isset($_GET['page']) && $_GET['page'] == "inscription-professionnel") { ?>
        <link rel="stylesheet" type="text/css" href="assets/css/util.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main.css">
        <link rel="stylesheet" type="text/css" href="assets/css/inscription.css">
    <?php } elseif (isset($_SESSION['idclient'])) { ?>
        <link rel="stylesheet" type="text/css" href="assets/css/navbar.css">
    <?php } ?>
    <!-- / FICHIERS CSS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
</head>
<body style="background-image: url(assets/images/bg.jpg); background-position: center center; background-repeat: no-repeat; background-attachment: fixed; background-size: cover;">

<!-- MENU DE NAVIGATION -->
<nav id="navbar">
    <div class="logo">
        <img src="https://cdn-idf.opendigitaleducation.com/assets/themes/monlycee/img/illustrations/logo.png" alt="Logo monlycée.net">
    </div>
    <label for="btn" class="icon">
        <span class="fa fa-bars"></span>
    </label>
    <input type="checkbox" id="btn">
    <ul>
        <li><a href="home">Accueil</a></li>
    <?php if (!isset($_SESSION['idclient'])) { ?>
        <li><a href="connexion" class="text-info">CONNEXION</a></li>
        <li><a href="inscription" style="color: #00FF00;">INSCRIPTION</a></li>
    <?php } else { ?>
        <li><a href="affichage">Planning des interventions</a></li>
        <li><a href="salle" style="color: #00FFFF;">Salle</a></li>
        <li><a href="intervention" style="color: #00FFFF;">Intervention</a></li>
        <li><a href="profil" style="color: #00FFFF;">Profil</a></li>
        <li><a href="deconnexion" style="color: #FF0000;"><i class="bi bi-power fs-5"></i></a></li>
    <?php } ?>
    </ul>
</nav>
<!-- / MENU DE NAVIGATION -->

<?php

if (isset($_GET['page'])) {
    $page = $_GET['page'];
} else {
    $page = "home";
}
switch ($page) {
    case "home" :
        require_once("home.php");
        break;
    case "rgpd" :
        require_once("vue/rgpd.php");
        break;
    case "connexion" :
        if (!isset($_SESSION['idclient'])) {
            require_once("gestion_connexion.php");
        } else {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "salle" :
        if(isset($_SESSION['idclient']))
        {
            require_once("gestion_salle.php");
        }
        else
        {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "intervention" :
        if($_SESSION['role'] == "admin")
        {
            require_once("gestion_intervention_admin.php");
        }
        elseif($_SESSION['role'] == "client")
        {
            require_once("gestion_intervention.php");
        } else {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "inscription" :
        if (!isset($_SESSION['idclient'])) {
            require_once("gestion_inscription.php");
        } else {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "inscription-administratif" :
        if (!isset($_SESSION['idclient'])) {
            require_once("gestion_inscription_administratif.php");
        } else {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "inscription-enseignant" :
        if (!isset($_SESSION['idclient'])) {
            require_once("gestion_inscription_enseignant.php");
        } else {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "profil" :
        if (isset($_SESSION['idclient'])) {
            require_once("gestion_profil.php");
        } else {
            header('Location: connexion');
        }
        break;
    case "recuperation-mdp" :
        require_once("gestion_mdp.php");
        break;
    case "deconnexion" :
        $unControleur->setTable("client");
        $tab = array("connexion"=>date('Y-m-d H:i:s', strtotime("+2 hour")));
        $where = array("idclient"=>$_SESSION['idclient']);
        $unControleur->update($tab, $where);
        unset($_SESSION);
        session_destroy();
        header('Location: connexion');
        break;
    case "admin" : 
        require_once("gestion_admin.php");
        break;
    case "affichage" :
        if(isset($_SESSION['idclient']))
        {
            require_once("gestion_affichage.php");
        }
        else
        {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    case "profil_intervenant" :
        if(isset($_SESSION['idclient']))
        {
            require_once("gestion_profil_intervenant.php");
        }
        else
        {
            header('Location: /Gestion_Intervenants/');
        }
        break;
    default :
        require_once("404.php");
    
}

?>

<!-- FICHIERS JAVASCRIPT -->
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/scroll.animate.js"></script>
<script src="assets/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="assets/zoombox/zoombox.js"></script>
<!-- / FICHIERS JAVASCRIPT -->

<!-- ZOOMBOX (Image d'accueil) -->
<script type="text/javascript">
    $(function () {
        $('a.zoombox').zoombox();
    })(jQuery);
</script>
<!-- / ZOOMBOX -->

<script>
    $('.icon').click(function () {
        $('span').toggleClass("cancel");
    });
</script>

</body>
</html>
