<!DOCTYPE html>
<html Lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Affichage</title>
        <link rel="stylesheet" href="../assets/css/main.css">
        <link rel="stylesheet" href="assets/css/affichage.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script>
            function getDateDuJour() {
            var date = new Date();
            var jour = date.getDate();
            var mois = date.getMonth() + 1; // Note : Les mois sont indexés à partir de zéro
            var annee = date.getFullYear();

            // Formatage de la date
            var dateFormatee = jour + '/' + mois + '/' + annee;

            return dateFormatee;
            }

            function getDateDuJourMoins() {
            var date = new Date();
            var jour = date.getDate() - 1;
            var mois = date.getMonth() + 1; // Note : Les mois sont indexés à partir de zéro
            var annee = date.getFullYear();

            // Formatage de la date
            var dateFormatee = jour + '/' + mois + '/' + annee;

            return dateFormatee;
            }

            function getDateDuJourPlus() {
            var date = new Date();
            var jour = date.getDate() + 1;
            var mois = date.getMonth() + 1; // Note : Les mois sont indexés à partir de zéro
            var annee = date.getFullYear();

            // Formatage de la date
            var dateFormatee = jour + '/' + mois + '/' + annee;

            return dateFormatee;
            }

            function submitForm() {
                document.getElementById("dateForm").submit();
            }

            function getDateAffichage() {
                var dateElement = document.getElementById("date_affichage").value;
                const maDate = dateElement.split("-");
                var annee = maDate[0];
                var mois = maDate[1];
                var jour = maDate[2];

                var dateFormatee = jour + '/' + mois + '/' + annee;

                return dateFormatee;
            }



        </script>
        <style>
            .intervention-cell {
                padding: 5px;
            }

            .intervention-cell-color {
                background-color: #00b8ff;
                border-radius: 0;
            }

            .empty-cell {
                padding: 10px;
            }

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
            <h1>Planning des interventions prévues pour cette journée</h1>
        </header>
        <br>
        <br>
        <br>
        <div class="container mt-4">
            <table border="1" width="100%" height="100%">
                <thead>
                    <tr>
                        <th colspan="13" style='text-align: center;'>Intervention(s) du <span id="date"></span></th>
                    </tr>
                </thead>
                <tbody>
                <form id="dateForm" action="affichage" method ="post">
                    <?php 
                        //Appel de la fonction qui recupère les interventions par jour 
                        $currentDateTime = isset($date_affichage) ? $date_affichage : new DateTime('now');
                    ?>

                    <div class="form-group col-md-6">
    
                        <label for="date_affichage" class="a1">Date choisie :</label>
                        <input type="date" class="form-control" name ="date_affichage" value="<?= $currentDateTime ?>" id="date_affichage" onchange="submitForm();" required>

                    </div>


                </form>

                <form method ="post" action ="profil_intervenant">

                    <tr>
                        <th style='text-align: center;'>Intervention(s)</th>
                        <?php for ($i = 8; $i < 20; $i++){
                                    echo "<td style='text-align: center;'>$i h</td>";
                        } ?>
                    </tr>

                    <?php 
                    //Gestion de l'affichage des intervenants
                    if (!empty($lesInterventions)) {
                        foreach ($lesInterventions as $uneIntervention) {

                                $date_int = !empty($uneIntervention['date_intervention']) ? $uneIntervention['date_intervention'] : 0;
                                $timestamp = strtotime($date_int);
                                $timestamp1 = strtotime($currentDateTime);
                                $heure_debut = substr($uneIntervention['heure_debut'], 0, 5);
                                $heure_fin = !empty($uneIntervention['heure_fin']) ? substr($uneIntervention['heure_fin'], 0, 5) : null;
                                if ($timestamp == $timestamp1 && $uneIntervention['etat'] == "Valider") {
                                echo "<tr>";
                                echo "<td style='width: 370px;'>";
                                echo "<input type='hidden' name='idintervention' value='".$uneIntervention['idintervention'].".'>";
                                echo "<button type='submit' name='Modifier' class='btn btn-primary' style='border-radius: 0;   width: 100%; height: 100%;' title='Plus de détails  width: 100%;
                                height: 100%;' >Intervention de ".$uneIntervention['nom_inter']." ".$uneIntervention['prenom_inter']."<br> pour ".$uneIntervention['responsable']." le ".$uneIntervention['date_intervention']." de ".$heure_debut." à ".$heure_fin."</button>";
                                echo "</td>";
                                for ($i = 8; $i < 20; $i++){
                                    $cellClass = ($i >= (int)$heure_debut && $i < (int)$heure_fin) ? 'intervention-cell intervention-cell-color' : 'intervention-cell';
                                    echo "<td class='$cellClass'></td>";
                                } 
                            
                        echo "</tr>";
                            }
                            else {
                                echo "<tr>";
                                echo "<td></td>";
                                for ($i = 8; $i < 20; $i++){
                                    echo "<td class='empty-cell'></td>";
                                }
                                echo "</tr>";
                            }
                    }

                    

                
                    }
                    else {
                        echo "<tr>";
                        echo "<td></td>";
                        for ($i = 8; $i < 20; $i++){
                            echo "<td class='empty-cell'></td>";
                        }
                        echo "</tr>";
                    }
                    ?>
                </form>
                </tbody>
            </table>
        </div>

        <script>

            
            // Utilisation de la fonction pour obtenir la date du jour
            var dateDuJour = getDateAffichage();

            // Affichage de la date dans l'élément avec l'id "date"
            document.getElementById("date").innerHTML = dateDuJour;
        </script>
    </body>
</html>
