<style type="text/css">
.stroke {
  	-webkit-text-stroke-width: 2px;
  	-moz-text-stroke-width: 2px;
  	-webkit-text-stroke-color: #111827;
  	-moz-text-stroke-color: #111827;
  	color: transparent;
}

.shadow {
  	text-shadow: 6px 6px #db2777;
}

.stroke-shadow {
  	color: whitesmoke;
}

.halftone {
  	position: relative;
}

.halftone:after {
  	content: "Hello";
  	background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAMAAAADCAYAAABWKLW/AAAAHElEQVQYV2NUVFT8f//+fUYGBgYGMAEDcA5IBQCKJQVmn76DhAAAAABJRU5ErkJggg==") repeat;
  	font-size: medium;
  	letter-spacing: 6px;
  	left: calc(50% + 6px);
  	position: absolute;
  	top: calc(50% + 6px);
  	transform: translate(-50%, -50%);
  	z-index: -1;
  	-webkit-text-stroke-width: 0;
  	-moz-text-stroke-width: 0;
  	-webkit-background-clip: text;
  	-moz-background-clip: text;
  	background-clip: text;
  	-webkit-text-fill-color: transparent;
  	-moz-text-fill-color: transparent;
}

.halftone-color:after {
  	background-color: #db2777;
}

body p.stroke-shadow {
  	font-size: 55px;
  	font-weight: bold;
  	letter-spacing: 3px;
  	margin: 0;
}

body .grid {
  	grid-gap: 5vw;
  	grid-template-columns: 1fr;
}
h1{
	font-size: 40px;
	text-align: auto;
}

</style>

<div class="container mt-4">
	<div class="row d-flex justify-content-center">
		<div class="col-auto">
			<div class="card" style="background: linear-gradient(to bottom right, #4bafd5, #2a9cc8);">
				<div class="card-header">
					<div class="grid">
  						<p class="stroke-shadow">Animation - intervenants Externes</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container reveal mt-4 mb-5">
	<div class="row align-items-center" style="background-color: #E0FFFF; border-radius:.25rem;">
		<div class="col-lg-5 mx-auto">
			<br>
			<h1 class="reveal-1" style="margin-bottom: 1.5rem!important;">
				Vous voici à l'endroit pour soumettre une demande pour faire venir un intervenant externe au lycée !
			</h1>
			<br>
		</div>
	</div>
</div>