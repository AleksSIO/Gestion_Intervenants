<link rel="stylesheet" href="assets/css/affichage.css">

<div class="container mt-4">
    <div class="row d-flex justify-content-center">
        <div class="col-auto">
            <br>
            <br>
            <h1>Listes des Interventions</h1>
            <br>
        </div>
    </div>
</div>

<div class="modal-footer justify-content-center">
    <div class="d-flex">
        <a href="intervention?action=ajouter" class="btn color-green btn-danger">
            Ajouter une Intervention
        </a>
    </div>
</div>

<?php if (isset($erreur)) { ?>
<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-auto">
			<div class="alert alert-secondary alert-dismissible fade show" role="alert">
  				<strong><?= $erreur; ?></strong>
  				<form method="post" action="">
  					<button type="submit" name="Refesh" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  				</form>
			</div>
		</div>
	</div>
</div>
<?php } ?>

<?php if (isset($message)) { ?>
<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-auto">
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
  				<strong><?= $message; ?></strong>
  				<form method="post" action="">
  					<button type="submit" name="Refesh" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  				</form>
			</div>
		</div>
	</div>
</div>
<?php } ?>	
                                
       <!-- <table border = 1 width="100%" height="100%"> -->

<div class="container mt-4 table-responsive">
    <table class="table table-bordered">
        <thead class="table-primary" style='text-align: center;'>
            <tr>
                <th>
                    <p class="card-text">
                        <b> Date de l'intervention  </b>
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Heure de début  </b>
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Heure de fin  </b>
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Responsable </b>
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Classe ou groupe concerné  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Nom de la salle  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Nom de l'intervenant  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b>Prénom de l'intervenant  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Organisme  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Date de la présentation au CA  </b>
                    </p>
                </th>
            </tr>
        </thead>
        <tbody>

            <?php foreach ($lesInterventions as $uneIntervention) { 
                $date_intervention = date('d/m/Y', strtotime($uneIntervention['date_intervention']));
                $date_presentation = date('d/m/Y', strtotime($uneIntervention['date_presentation']));
                $date_transmission = date('d/m/Y', strtotime($uneIntervention['date_transmission']));
                ?>	
                
                <tr>
                    <td>
                        <p class="card-text">
                            <?= $date_intervention; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= substr($uneIntervention['heure_debut'], 0, 5); ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= substr($uneIntervention['heure_fin'], 0, 5); ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['responsable']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['classe']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['nom_salle']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['nom_inter']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['prenom_inter']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $uneIntervention['organisme']; ?>
                        </p>
                    </td>

                    <td>
                        <p class="card-text">
                            <?= $date_presentation; ?>
                        </p>
                    </td>

                    <td>
                        <a href="intervention?action=edit&idintervention=<?= $uneIntervention['idintervention']; ?>" class="btn btn-primary text-light me-2">
                            Modifier l'état de l'intervention
                        </a>
                    </td>

                    <td>
                        <a href="intervention?action=show&idintervention=<?= $uneIntervention['idintervention']; ?>" class="btn btn-info text-light me-2 detailsInterv"> 
                            Détails de l'intevention
                        </a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    const selected = document.querySelector(".selected");
    const optionsContainer = document.querySelector(".options-container");
    const searchBox = document.querySelector(".search-box input");
    const optionsList = document.querySelectorAll(".option");

    selected.addEventListener("click", () => {
        optionsContainer.classList.toggle("active");
        searchBox.value = "";
        filterList("");
        if (optionsContainer.classList.contains("active")) {
            searchBox.focus();
        }
    });

    optionsList.forEach(o => {
        o.addEventListener("click", () => {
            selected.innerHTML = o.querySelector("label").innerHTML;
            optionsContainer.classList.remove("active");
        });
    });

    searchBox.addEventListener("keyup", function(e) {
        filterList(e.target.value);
    });

    const filterList = searchTerm => {
        searchTerm = searchTerm.toLowerCase();
        optionsList.forEach(option => {
            let label = option.firstElementChild.nextElementSibling.innerText.toLowerCase();
            if (label.indexOf(searchTerm) != -1) {
                option.style.display = "block";
            } else {
                option.style.display = "none";
            }
        });
    };
</script>