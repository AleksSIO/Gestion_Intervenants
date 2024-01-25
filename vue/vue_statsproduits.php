<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-center">
        <div class="col-auto">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">
                        Nombre de produits total pour toutes les catégories : <?= $produitsTotal; ?>
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-center">
        <div class="col-auto">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">
                        Nombre de produits par catégorie
                    </h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-dark table-striped text-center">
                            <thead>
                                <tr>
                                    <th scope="col">Catégorie</th>
                                    <th scope="col">NB Produits</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($lesProduits as $unProduit) { ?>
                                <tr>
                                    <td><?= $unProduit['categorie']; ?></td>
                                    <td><?= $unProduit['nbproduit']; ?></td>
                                </tr>
                            <?php } ?> 
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mt-4 mb-5">
    <div class="row d-flex justify-content-center">
        <div class="col-auto">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">Graphique : Nombre de produits par catégories</h3>
                </div>
                <div class="card-body">
                    <canvas id="myChart" width="400" height="400"></canvas>
                    <script>
                    const ctx = document.getElementById('myChart').getContext('2d');
                    const myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: ['Autoradio', 'GPS', 'Aide à la conduite', 'Hauts-parleurs', 'Kit mains-libre', 'Amplificateur'],
                            datasets: [{
                                data: [4, 4, 4, 4, 4, 4],
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mt-4 mb-5">
    <div class="row d-flex justify-content-center">
        <div class="col-auto">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">Graphique : Nombre de produits par catégories</h3>
                </div>
                <div class="card-body">
                    <canvas id="myChart" width="400" height="400"></canvas>
                    <script>
                    const ctx = document.getElementById('myChart').getContext('2d');
                    const myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: [
                            <?php foreach ($lesProduits as $unProduit) { ?>
                            <?= json_encode($unProduit['categorie']) ?>,
                            <?php } ?>
                            ],
                            datasets: [{
                                data: [
                                <?php foreach ($lesProduits as $unProduit) { ?>
                                <?= $unProduit['nbproduit']; ?>,
                                <?php } ?>
                                ],
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>