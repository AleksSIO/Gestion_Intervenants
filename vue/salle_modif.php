<div class="container mt-4">
    <div class="row d-flex justify-content-center">
        <div class="col-auto">
            <a href="statsproduit" class="btn btn-light">Listes des Salles</a>
        </div>
    </div>
</div>


<!-- FILTRAGE DES BATIMENTS DES SALLE -->

<!-- / FILTRAGE DES TYPES DE PRODUITS -->

<!-- PAGINATION -->

<!-- / PAGINATION -->

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


    <?php if (isset($_GET['action']) && isset($_GET['idsalle'])) { ?>

        
        <form method="post" action="salle">
                <input type="hidden" name="idsalle" value="<?= $uneSalle['idsalle']; ?>">
                <div class="mb-2">
                    <p>Bâtiments : </p>
                    <input type="text" name="batiment" class="form-control" value="<?= ($uneSalle != null ? $uneSalle['batiment'] : null); ?>">
                </div>
                <div class="mb-2">
                    <p>Nom de la salle : </p>
                    <input type="text" name="nom" class="form-control" value="<?= ($uneSalle != null ? $uneSalle['nom'] : null); ?>">
                </div>
                <div class="card-footer">
                    <div class="d-flex justify-content-center">
                        <a href="salle" class="btn btn-danger me-2">
                            Annuler
                        </a>
                        <button type="submit" name="Modifier" class="btn btn-primary">
                            Valider
                        </button>
                    </div>
                </div>
        </form>
    <?php } else { ?>

        <form method="post" action="salle">
                <input type="hidden" name="idsalle" value="">
                <div class="mb-2">
                    <p>Bâtiments : </p>
                    <input type="text" name="batiment" class="form-control" value="">
                </div>
                <div class="mb-2">
                    <p>Nom de la salle : </p>
                    <input type="text" name="nom" class="form-control" value="">
                </div>
                <div class="card-footer">
                    <div class="d-flex justify-content-center">
                        <a href="salle" class="btn btn-danger me-2">
                            Annuler
                        </a>
                        <button type="submit" name="Ajouter" class="btn btn-primary">
                            Ajouter
                        </button>
                    </div>
                </div>
        </form>




    <?php } ?>

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