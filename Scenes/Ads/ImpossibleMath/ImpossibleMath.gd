extends Ad

var num_1;
var num_2;
var num_3;
var num_4;
var answer;

func _ready():
	num_1 = posmod(randi(), 10)
	num_2 = posmod(randi(), 10)
	num_3 = posmod(randi(), 10)
	num_4 = posmod(randi(), 10)
	answer = num_1 + (num_2 * num_3) + num_4
	$Center/Question.text = str(num_1) + " + " + str(num_2) + " * " + str(num_3) + " + " + str(num_4)

func _on_LineEdit_text_entered(new_text):
	var given = new_text.strip_edges(true, true)
	emit_signal("ad_finished", given == str(answer))
