extends Control

func _process(_delta):
	$Speed.text = "Speed: %d km/h" % g.speed
	$Altitude.text = "Altitude: %d m" % g.altitude
