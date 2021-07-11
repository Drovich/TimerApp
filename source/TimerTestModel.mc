using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class Model{

	var NUM_LAP = 3;
	var PREP_TIME = 3;
	var REST_TIME = 3;
	var WORK_TIME = 3;
	var NUM_ROUNDS = 3;
	var TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
	const HAS_TONES = Attention has :playTone;


	var counter = PREP_TIME;
	var round = 0;
	var currentRound = 0;
	var phase = :prep;
	var done = false;
	var session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TRAINING, :subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, :name => "Tabata"});

	hidden var refreshTimer = new Timer.Timer();
	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);

	function initialize(){	
	}

	function start(){
		NUM_LAP = Settings.GetLapValue();
		PREP_TIME = Settings.GetPrepValue();
		REST_TIME = Settings.GetRestValue();
		WORK_TIME = Settings.GetWorkValue();
		NUM_ROUNDS = Settings.GetRoundsValue();
		counter = PREP_TIME;
		TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
	
		refreshTimer.start(method(:refresh), 1000, true);
		startBuzz();
		Ui.requestUpdate();
	}

	function refresh(){
		if (counter > 1){
			counter--;
		} else {
			if (round == TOTAL_ROUNDS){
						finishUp();
						stopBuzz();
			} else if (phase == :prep) {
				session.start();
				phase = :work;
				counter = WORK_TIME;
				round++;
				currentRound++;
				intervalBuzz();
			} else if (phase == :work) {
				phase = :rest;
				counter = REST_TIME;
				intervalBuzz();
			}else if (phase == :rest) {
			
				if (currentRound == NUM_ROUNDS){
					phase = :prep;
					counter = PREP_TIME;
					currentRound=0;
					intervalBuzz();
				} else {
						phase = :work;
						counter = WORK_TIME;
						round++;
						currentRound++;
						intervalBuzz();
				}
			}
		}
		Ui.requestUpdate();
	}

	function finishUp() {
		done = true;
		session.stop();
		session.save();
		refreshTimer.stop();
	}

	function startBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1500);
	}

	function stopBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1500);
	}

	function intervalBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1000);
	}

	function vibrate(duration){
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
		Attention.vibrate( vibrateData );
	}

	function beep(tone){
		Attention.playTone(tone);
		return true;
	}
}