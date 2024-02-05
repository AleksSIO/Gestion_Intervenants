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
                                
        <table border = 1 width="100%" height="100%">

        <thead>
            <tr>
                <th>
                    <p class="card-text">
                        <b>Id Intervention </b>
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Responsable </b>
                    </p>
                </th>
                <th>
                    <p class="card-text">
                        <b> E-mail  </b>
                    </p>
                </th>

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
                        <b> Présentation au CA  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Date de la présentation au CA  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Précision à ajouter  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Lieu où l'intervenant mange  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Pris en charge financièrement par  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b> Précision à ajouter  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b>Précision à ajouter  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b>Type d'intervention  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b>Date de transmission  </b>  
                    </p>
                </th>

                <th>
                    <p class="card-text">
                        <b>Responsable de formation  </b>  
                    </p>
                </th>
            </tr>
        </thead>

        <tbody>

            </tbody>

                <?php foreach ($lesInterventions as $uneIntervention) { ?>	

                    <tr>
                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['idintervention']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['responsable']; ?>
                            </p>
                        </td>
                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['email']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['date_intervention']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['heure_debut']; ?>
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
                                <?= $uneIntervention['nom_salle']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['date_presentation']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['infos']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['lieu_repas']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['payeur']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['besoin_parking']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['infos2']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['type_intervention']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['date_transmission']; ?>
                            </p>
                        </td>

                        <td>
                            <p class="card-text">
                                <?= $uneIntervention['responsable_form']; ?>
                            </p>
                        </td>

                        <td>
                            <a href="intervention?action=edit&idintervention=<?= $uneIntervention['idintervention']; ?>" class="btn btn-primary text-light me-2">
                                Modifier l'état de l'intervention
                            </a>
                        </td>

                    </tr>
                <?php } ?>
            </tbody>
        </table>

        <div class="modal-footer justify-content-center">
            <div class="d-flex">
                <a href="intervention?action=ajouter" class="btn color-green btn-danger">
                    Ajouter une Intervention
                </a>
            </div>
        </div>
						



                            
		<div class="d-flex justify-content-center mt-4 mb-5">
            <div class="d-flex justify-content-center mt-4 mb-4">
                <ul class="ul-pagination reveal-2">
                    <?php if ($pageCourante <= 1) { ?>
                    <li style="margin-top: 1vh;">
                        <a href="javascript:void(0)" style="cursor: default;">Précédent</a>
                    </li>
                    <?php } else { ?>
                    <li style="margin-top: 1vh;">
                        <a href="intervention?p=<?= $pagePrecedente; ?>" class="text-primary">Précédent</a>
                    </li>
                    <?php } ?>
                    <?php for ($i=1; $i<=$pagesTotales; $i++) { ?>
                    <?php if ($i == $pageCourante) { ?>
                    <li class="pageNumber active" style="margin-top: 1vh;">
                        <a href="intervention?p=<?= $i; ?>"><?= $i; ?></a>
                    </li>
                    <?php } else { ?>
                    <li class="pageNumber" style="margin-top: 1vh;">
                        <a href="intervention?p=<?= $i; ?>"><?= $i; ?></a>
                    </li>
                    <?php } ?>
                    <?php } ?>
                    <?php if ($pageCourante >= $pagesTotales) { ?>
                    <li style="margin-top: 1vh;">
                        <a href="javascript:void(0)" style="margin-right: 1.7rem!important; cursor: default;">Suivant</a>
                    </li>
                    <?php } else { ?>
                    <li style="margin-top: 1vh;">
                        <a href="intervention?p=<?= $pageSuivante; ?>" class="text-primary" style="margin-right: 1.7rem!important;">Suivant</a>
                    </li>
                    <?php } ?>
                </ul>
            </div>
            </nav>
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