<?php

if (isset($_SESSION['idclient']) && isset($_SESSION['role']) && $_SESSION['role'] == "admin") {

	// action...

	require_once("vue/vue_admin.php");

} else {
	header('Location: /filelec/');
}

?>