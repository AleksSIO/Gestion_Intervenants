<?php

$unControleur->setTable("produit");
$produitsTotal = $unControleur->count();

$unControleur->setTable("nbProduitCat");
$lesProduits = $unControleur->selectAll("*");

require_once("vue/vue_statsproduits.php");

?>


