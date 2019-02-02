extends Control

func _process(delta):
	$Speed.text = "Speed: %d km/h" % g.speed
	$Altitude.text = "Altitude: %d m" % g.altitude
