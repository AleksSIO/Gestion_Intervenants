<div class="container mt-4">
    <div class="row d-flex justify-content-center">
        <div class="col-auto">
            <a href="#" class="btn btn-light">Listes des Salles</a>
        </div>
    </div>
</div>

<div class="modal-footer justify-content-center">
    <div class="d-flex">
        <a href="salle?action=ajouter" class="btn color-green btn-danger">
            Ajouter une salle
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

<div class="container mt-4">
	<?php foreach ($lesSalles as $uneSalle) { ?>
		<div class="col-lg-7 mb-2">
			<div class="card animate__animated animate__zoomIn">
				<div class="card-body text-center">
					<div class="card-footer">

						<div class="d-flex justify-content-center">
                            <?php if(!isset($_GET['action']) || !isset($_GET['idsalle'])) { ?>
                                <div class="card-body">

                                    <p class="card-text">
                                        <b>Id Salle : </b><?= $uneSalle['idsalle']; ?>
                                    </p>
                                    <p class="card-text">
                                        <b>Bâtiment : </b><?= $uneSalle['batiment']; ?>
                                    </p>
                                    <p class="card-text">
                                        <b>Nom : </b><?= $uneSalle['nom']; ?>
                                    </p>

                                    <div class="card-footer">
                                        <div class="d-flex justify-content-center">
                                            <a href="salle?action=edit&idsalle=<?= $uneSalle['idsalle']; ?>" class="btn btn-primary text-light me-2">
                                                Modifier la salle
                                            </a>

                                            <a href="salle?Supprimer=supp&idsalle=<?= $uneSalle['idsalle']; ?>" onclick="return(confirm('Voulez-vous vraiment supprimer la salle ?'));" class="btn btn-danger text-light">
                                                Supprimer la salle
                                            </a>
                                        </div>
                                    </div>  

                                </div>
                            <?php } ?>
						</div>
					</div>
				</div>
			</div>
		</div>
	<?php } ?>


                            
		<div class="d-flex justify-content-center mt-4 mb-5">
            <div class="d-flex justify-content-center mt-4 mb-4">
                <ul class="ul-pagination reveal-2">
                    <?php if ($pageCourante <= 1) { ?>
                    <li style="margin-top: 1vh;">
                        <a href="javascript:void(0)" style="cursor: default;">Précédent</a>
                    </li>
                    <?php } else { ?>
                    <li style="margin-top: 1vh;">
                        <a href="salle?p=<?= $pagePrecedente; ?>" class="text-primary">Précédent</a>
                    </li>
                    <?php } ?>
                    <?php for ($i=1; $i<=$pagesTotales; $i++) { ?>
                    <?php if ($i == $pageCourante) { ?>
                    <li class="pageNumber active" style="margin-top: 1vh;">
                        <a href="salle?p=<?= $i; ?>"><?= $i; ?></a>
                    </li>
                    <?php } else { ?>
                    <li class="pageNumber" style="margin-top: 1vh;">
                        <a href="salle?p=<?= $i; ?>"><?= $i; ?></a>
                    </li>
                    <?php } ?>
                    <?php } ?>
                    <?php if ($pageCourante >= $pagesTotales) { ?>
                    <li style="margin-top: 1vh;">
                        <a href="javascript:void(0)" style="margin-right: 1.7rem!important; cursor: default;">Suivant</a>
                    </li>
                    <?php } else { ?>
                    <li style="margin-top: 1vh;">
                        <a href="salle?p=<?= $pageSuivante; ?>" class="text-primary" style="margin-right: 1.7rem!important;">Suivant</a>
                    </li>
                    <?php } ?>
                </ul>
            </div>
            </nav>
        </div>

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