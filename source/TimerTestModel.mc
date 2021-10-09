using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class Model{

	var NUM_LAP = 3;
	var isRecorded = false;
	var PREP_TIME = 3;
	var REST_TIME = 3;
	var WORK_TIME = 3;
	var NUM_ROUNDS = 3;
	var HEART_WORK_GOAL = 150;
	var HEART_REST_GOAL = 130;
	var TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
	const HAS_TONES = Attention has :playTone;


	var heartRate = 60;
	var speed = 10;
	var counter = PREP_TIME;
	var counterBis =PREP_TIME;
	var round = 0;
	var started = false;
	var currentRound = 0;
	var phase = :prep;
	var done = false;

	var session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TRAINING, :subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, :name => "Tabata"});

	hidden var refreshTimer = new Timer.Timer();
	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE,Sensor.SENSOR_FOOTPOD]);
	

	function initialize(){	
	
	}

	function update(){	
		NUM_LAP = Settings.GetLapValue();
		PREP_TIME = Settings.GetPrepValue();
		REST_TIME = Settings.GetRestValue();
		WORK_TIME = Settings.GetWorkValue();
		NUM_ROUNDS = Settings.GetRoundsValue();
		HEART_WORK_GOAL = Settings.GetHeartWorkValue();
		HEART_REST_GOAL = Settings.GetHeartRestValue();
		isRecorded = Settings.isRecorded;
		TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
		if (phase == :prep) {
			counterBis = PREP_TIME;
		} else if (phase == :work) {
			counterBis = WORK_TIME;
		}else if (phase == :rest) {
			counterBis = REST_TIME;
		}

	}
	function start(){
		
		started = true;
		counter = PREP_TIME;
		TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
		if(isRecorded==true){
			session.start();
		}		
		/*System.println(isRecorded);*/
		Sensor.enableSensorEvents(method(:onSensor));
		refreshTimer.start(method(:refresh), 1000, true);
		startBuzz();
		Ui.requestUpdate();
	}
	
	function onSensor(sensorInfo) {
		if (sensorInfo.heartRate == null){
		} else {
    	heartRate = sensorInfo.heartRate;
    	}/*speed = sensorInfo.speed * 3.6;*/
}

	function refresh(){
		buzzHandler(counter);
		if (counter > 1){
			counter--;	
		} else {
			if (round == TOTAL_ROUNDS){
						finishUp();
						//stopBuzz();
			} else if (phase == :prep) {
				
				phase = :work;
				counter = WORK_TIME;
				round++;
				currentRound++;
				//intervalBuzz();
			} else if (phase == :work) {
				phase = :rest;
				counter = REST_TIME;
				//intervalBuzz();
			} else if (phase == :rest) {
			
				if (currentRound == NUM_ROUNDS){
					phase = :prep;
					counter = PREP_TIME;
					currentRound=0;
					//intervalBuzz();
				} else {
						phase = :work;
						counter = WORK_TIME;
						round++;
						currentRound++;
						//intervalBuzz();
				}
			}
		}
		Ui.requestUpdate();
	}
	
	function finishUp() {
		done = true;
		started = false;
		
		/*System.println(isRecorded);*/
		if(isRecorded==true){
			session.stop();
			session.save();
		}		
		refreshTimer.stop();
	}
	
	function buzzHandler(counter){
		if (counter == 1){
			if (round == TOTAL_ROUNDS){
				stopBuzz();
			}else {
				intervalBuzz();
			}
		} else if (buzzCondition(counter)){
			preBuzz();
		}
	}
		
	function buzzCondition(counter){	
	if (	(phase == :prep && counter == PREP_TIME/2+1) || 
			(phase == :work && counter == WORK_TIME/2+1) ||
			(phase == :rest && counter == REST_TIME/2+1) ||
			(counter < 5)
		){return true;}
		else {return false;}
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
	
	function preBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(250);
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