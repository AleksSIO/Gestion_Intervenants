<?php if (isset($erreur)) { ?>
<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-auto">
			<div class="alert alert-warning alert-dismissible fade show" role="alert">
				<strong><?= $erreur; ?></strong>
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</div>
</div>
<?php } ?>



<html>

    <head>
        <link rel="stylesheet" href="assets/css/styleform.css">
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <style>
            ::-webkit-scrollbar {
                width: 8px;
                background-color: #f1f1f1; 
            }
            ::-webkit-scrollbar-track {
                background-color: #ccc;
            }
            ::-webkit-scrollbar-thumb {
                background-color: #0d6efd;
                border-radius: 10px;
            }
        </style>
    </head>

    <body>

        <header>
        <br>
        <h1>Animation - Intervenants Exterieurs</h1>
        <br>
        <br>
        </header>

        <?php if (isset($_GET['action']) && isset($_GET['idintervention'])) { ?>

            <form method ="post" action ="intervention">

                <div class="container mt-4 table-responsive" style="margin-bottom: 25px;">
                    <h2 style="color: red">Modification d'une intervention</h2>
                    <br>
                    <h2>Informations</h2>
                    <div class="form-row" id="a">

                        <input type="hidden" name="etat" value="Valider">

                        <input type="hidden" name="idintervention" value="<?= $uneIntervention['idintervention']; ?>">

                        <div class="form-group col-md-6">

                            <label for="responsable" class="a1">Responsable</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="responsable" value="<?= ($uneIntervention != null ? $uneIntervention['responsable'] : null); ?>" id="responsable" placeholder="Nom et prénom" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="email" class="a1">Email</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="email" class="form-control" name="email" value="<?= ($uneIntervention != null ? $uneIntervention['email'] : null); ?>" id="email" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="date_intervention" class="a1">Date intervention</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="date" class="form-control" name ="date_intervention" value="<?= ($uneIntervention != null ? $uneIntervention['date_intervention'] : null); ?>" id="date_intervention" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="heure_debut" class="a1">Heure de début</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="time" class="form-control" name="heure_debut" value="<?= ($uneIntervention != null ? $uneIntervention['heure_debut'] : null); ?>" id="heure_debut" placeholder="Email" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="heure_fin" class="a1">Heure de fin</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="time" class="form-control" name="heure_fin" value="<?= ($uneIntervention != null ? $uneIntervention['heure_fin'] : null); ?>" id="heure_fin" placeholder="Email" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="classe" class="a1">Classe(s) ou groupe(s) concerné(e)(s)</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="classe" value="<?= ($uneIntervention != null ? $uneIntervention['classe'] : null); ?>" id="classe" placeholder="1TSIOA" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="nom_salle" class="a1">Salle</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="nom_salle" value="<?= ($uneIntervention != null ? $uneIntervention['nom_salle'] : null); ?>" id="nom_salle" placeholder="batiment + salle" required>

                        </div>

                    </div>

                    <br>
                    <br>


                    <h2>Intervenant(s)</h2>

                    <div class="form-row" id="b">

                        <div class="form-group col-md-6">

                            <label for="nom_inter">Nom</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="nom_inter" value="<?= ($uneIntervention != null ? $uneIntervention['nom_inter'] : null); ?>" id="nom" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="prenom_inter">Prénom</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="prenom_inter" value="<?= ($uneIntervention != null ? $uneIntervention['prenom_inter'] : null); ?>" id="prenom" required>

                        </div>

                        <div class="form-group col-md-12">

                            <label for="organisme">Association // entreprise // organisme</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="organisme" value="<?= ($uneIntervention != null ? $uneIntervention['organisme'] : null); ?>" id="organisme" required>

                        </div>
                    </div>

                    <br>
                    <br>

                    <h2>Inscription dans un projet - Nature et coût de l'intervention</h2>

                    <div class="form-row" id="c">

                        <div class="form-group col-md-12">

                            <label for="presentation_ca">Le projet a-t-il été présenté au C.A ?</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="presentation_ca" value="<?= ($uneIntervention != null ? $uneIntervention['presentation_ca'] : null); ?>" id="presentation_ca" placeholder ="Oui/Non"required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="date_presentation">Si oui, quelle date ?</label>
                            <input type="date" name="date_presentation" value="<?= ($uneIntervention != null ? $uneIntervention['date_presentation'] : null); ?>" id="date_presentation">

                        </div>

                        <div class="form-group col-md-6">

                            <label for="infos">Précision à ajouter</label>
                            <input type="text" name="infos" value="<?= ($uneIntervention != null ? $uneIntervention['infos'] : null); ?>" id="infos" placeholder='"Aucune" si pas de précision'>

                        </div>
                    </div>


                    <br>
                    <br>

                    <h2>Intendance </h2>
                    <h5>Repas midi</h5><p><span style=""></span></p>

                    <div class="form-row" id="d">

                        <div class="col-md-6">Coût par personne = 6,34 €</div>
                        <br>
                        <br>
                        <div class="col-md-6">
                            <label for="lieu_repas">Lieu où l'intervenant prend son repas</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="lieu_repas" value="<?= ($uneIntervention != null ? $uneIntervention['lieu_repas'] : null); ?> "id="payeur">
                        </div>

                        <div class="col-sm-2">Pris en charge financièrement par :</div><span style="color: red;" title="Requis"><b>*</b></span>

                        <div class="form-group col-md-10">

                            <label for="payeur"></label>
                            <input type="text" class="form-control" name="payeur" value="<?= ($uneIntervention != null ? $uneIntervention['payeur'] : null); ?>" id="payeur">

                        </div>

                        <div class="col-md-6">
                            <label for="besoin_parking">besoin de parking</label><span style="color: red;" title="Requis"><b>*</b></span><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="besoin_parking" value="<?= ($uneIntervention != null ? $uneIntervention['besoin_parking'] : null); ?>" id="besoin_parking" placeholder="Oui/Non">
                        </div>

                        <div class="form-group col-md-12">

                            <label for="infos2">Précision à ajouter</label>
                            <input type="text" name="infos2" value="<?= ($uneIntervention != null ? $uneIntervention['infos2'] : null); ?>" id="infos2" placeholder='"Aucune" si pas de précision'>

                        </div>
                    </div>

                    <br>
                    <br>
                    <h2>Type d'intervention</h2>
                    <div class="form-row" id="d">
                        <div class="form-group col-md-12">
                        <label for="type_intervention">Type d'intervention</label>
                        <input type="text" class="form-control" name="type_intervention" value="<?= ($uneIntervention != null ? $uneIntervention['type_intervention'] : null); ?>" id="type_intervention" placeholder="Exécutif/Informatif">
                        </div>
                    </div>
                    <br>
                    <br>
                    <h2>Transmission</h2>
                    <div class="form-row" id="f">

                        <div class="form-group col-md-6">

                            <label for="date_transmission">Transmis le</label>
                            <input type="date" class="form-control" name="date_transmission" value="<?= ($uneIntervention != null ? $uneIntervention['date_transmission'] : null); ?>" id="date_transmission" required>

                        </div>

                        <div class="col-md-6">
                            <label for="responsable_form">à</label>
                            <input type="text" class="form-control" name="responsable_form" value="<?= ($uneIntervention != null ? $uneIntervention['responsable_form'] : null); ?>" id="responsable_form">
                        </div>


                    </div>


                    <br>
                    
                    <div class="btn-group me-2" role="group" aria-label="First group">
                        <button type="submit" name="Modifier" class="btn btn-primary">
                                Valider
                        </button>
                    </div>

                    <div class="btn-group me-2" role="group" aria-label="First group">
                        <button type="submit" name="Refuser" class="btn btn-primary">
                                Refuser
                        </button>
                    </div>
                </div> 
            </form>
            <a href="#" class="back-to-top">&#129045; Haut de page &#129045;</a>

        <?php } else { ?> <!-- Ajout intervention -->

            <form method ="post" action ="intervention">

                <div class="container mt-4 table-responsive">
                    <h2 style="color: red">Ajout d'une intervention</h2>
                    <br>
                    <h2>Informations</h2>
                    <p style="font-size: smaller;">Tous les champs marqués d'un <span style="color: red;">*</span> sont requis !</p>
                    <div class="form-row" id="a">

                        <input type="hidden" name="etat" value="">

                        <input type="hidden" name="idintervention" value="">

                        <div class="form-group col-md-6">

                            <label for="responsable" class="a1">Responsable</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="responsable" value="" id="res" placeholder="Nom et prénom" required>
                        </div>

                        <div class="form-group col-md-6">

                            <label for="email" class="a1">Email</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="email" class="form-control" name="email" value="" id="email" required>

                        </div>

                        <div class="form-group col-md-6">
                            <label for="date_intervention" class="a1">Date intervention</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="date" class="form-control" name ="date_intervention" value="" id="date" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="heure_debut" class="a1">Heure de début</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="time" class="form-control" name="heure_debut" value="" id="heure_debut" placeholder="Email" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="heure_fin" class="a1">Heure de fin</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="time" class="form-control" name="heure_fin" value="" id="heure_fin" placeholder="Email" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="classe" class="a1">Classe ou groupe concerné</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="classe" value="" id="classe" placeholder="1TSIOA" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="nom_salle" class="a1">Salle</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="nom_salle" value="" id="nom_salle" placeholder="batiment A/D202" required>

                        </div>

                    </div>

                    <br>
                    <br>


                    <h2>Intervenant(s)</h2>

                    <div class="form-row" id="b">

                        <div class="form-group col-md-6">

                            <label for="nom_inter" class="a1">Nom</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="nom_inter" value="" id="nom" required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="prenom_inter" class="a1">Prénom</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="prenom_inter" id="prenom" required>

                        </div>

                        <div class="form-group col-md-12">

                            <label for="organisme" class="a1">Association // entreprise // organisme</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="organisme" id="organisme" required>

                        </div>

                    </div>

                    <br>
                    <br>

                    <h2>Inscription dans un projet - Nature et cout de l'intervention</h2>

                    <div class="form-row" id="c">

                        <div class="form-group col-md-6">

                            <label for="presentation_ca" class="a1">Le projet a-t-il été présenté au C.A ?</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="presentation_ca" id="presentation_ca" placeholder ="Oui/Non"required>

                        </div>

                        <div class="form-group col-md-6">

                            <label for="date_presentation" class="a1">Si oui, à quelle date ?</label>
                            <input type="date" class="form-control" name="date_presentation" id="date_presentation">

                        </div>

                        <div class="form-group col-md-12">

                            <label for="infos" class="a1">Précision à ajouter </label>
                            <input type="text" class="form-control" name="infos" id="infos" placeholder='"Aucune" si rien à ajouter'>

                        </div>

                    </div>


                    <br>
                    <br>

                    <h2>Intendance </h2>
                    <h5>Repas midi</h5>

                    <div class="form-row" id="d">

                        <div class="col-md-6">Coût par personne = 6,34 €</div>

                        <div class="col-md-6">
                            <label for="lieu_repas" class="a1">Lieu où l'intervenant prend son repas</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="lieu_repas" id="payeur">
                        </div>

                        <div class="form-group col-md-10">

                            <label for="payeur" class="a1">Pris en charge financièrement par</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="payeur" id="payeur">

                        </div>

                        <div class="col-md-6">
                            <label for="besoin_parking" class="a1">besoin de parking</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="besoin_parking" id="besoin_parking" placeholder="Oui/Non">
                        </div>

                        <div class="form-group col-md-12">

                            <label for="infos2" class="a1">Précision à ajouter</label>
                            <input type="text" class="form-control" name="infos2" id="infos2" placeholder='"Aucune" si rien à ajouter'>

                        </div>

                    </div>

                    <br>
                    <br>
                    <h2>Type d'intervention</h2>
                    <div class="form-row" id="d">
                        <div class="form-group col-md-12">
                        <label for="type_intervention" class="a1">Type d'intervention</label>
                        <input type="text" class="form-control" name="type_intervention" id="type_intervention" placeholder="Exécutif/Informatif">
                        </div>
                    </div>
                    <br>
                    <br>
                    <h2>Transmission</h2>
                    <div class="form-row" id="f">

                        <div class="form-group col-md-6">

                            <label for="date_transmission" class="a1">Transmis le</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="date" class="form-control" name="date_transmission" id="date_transmission" required>

                        </div>

                        <div class="col-md-6">
                            <label for="responsable_form" class="a1">à</label><span style="color: red;" title="Requis"><b>*</b></span>
                            <input type="text" class="form-control" name="responsable_form" id="responsable_form" placeholder="Lieu">
                        </div>


                    </div>

                    <br>
                    
                    <div class="btn-group me-2" role="group" aria-label="First group">
                        <button type="submit" name="Ajouter" class="btn btn-primary">
                                Ajouter
                        </button>
                    </div>
                </div>
            </form>

            <a href="#" class="back-to-top">&#129045; Haut de page &#129045;</a>

        <?php } ?>

<script>
    window.onscroll = function() {scrollFunction()};

    function scrollFunction() {
        if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
            document.querySelector('.back-to-top').classList.add('show');
        } else {
            document.querySelector('.back-to-top').classList.remove('show');
        }
    }

    document.querySelector('.back-to-top').addEventListener('click', function(e) {
        e.preventDefault();
        document.body.scrollTop = 0; // Pour les anciens navigateurs
        document.documentElement.scrollTop = 0; // Pour les navigateurs modernes
    });
</script>