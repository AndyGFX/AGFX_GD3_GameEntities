extends Sprite


# ------------------------------------------------------------------------------
# Prepared FADE effect for DASH
# ------------------------------------------------------------------------------
func _ready():
	$TweenAlpha.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),0.6, Tween.TRANS_SINE,Tween.EASE_OUT)
	$TweenAlpha.connect("tween_completed",self,"OnTweenCompleted")
	$TweenAlpha.start()

# ------------------------------------------------------------------------------
# Remove effect when is done
# ------------------------------------------------------------------------------
func OnTweenCompleted(obj,key):
	self.queue_free()
	
