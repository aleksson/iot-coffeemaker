// a.Cincarevic 2016

$(function () {
	console.log("Init...Brew Coffe/Tea over WiFi By a.Cincarevic");
});

function handleCooking() {
	let knapp = $('.switch-label')[0].id;
	let brewer = document.querySelector('input').value || '127.0.0.1';

	if(knapp === "off"){
		console.log("Turn off",{ brewer , knapp });
		$('.switch-label')[0].id = "on";

		return $.ajax({
			type: "GET",
			dataType: "json",
			crossDomain: true,
			url: "http://"+ brewer +"/?pin=OFF0",
			success : function(res){
				console.log("State OFF: " , res);
				
			}
		});
	}

	if(knapp === "on"){
		console.log("Turn on",{ brewer , knapp });
		$('.switch-label')[0].id = "off";

		return $.ajax({
			type: "GET",
			dataType: "json",
			crossDomain: true,
			url: "http://"+ brewer +"/?pin=ON0",
			success : function(res){
				console.log("State: ON: " , res);
				
			}
		});
	}
}