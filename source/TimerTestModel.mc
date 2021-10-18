using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Activity as Activity;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class Model{

	static var PREP_TIME = 30;
	static var REST_TIME = 10;
	static var WORK_TIME = 20;
	static var NUM_ROUNDS = 8;
	static var NUM_LAP = 4;
	static var HEART_WORK_GOAL = 150;
	static var HEART_REST_GOAL = 130;
	static var SPEED_WORK_GOAL = 12;
	static var SPEED_REST_GOAL = 8;
	static var HEART_VAR = 0.1;
	static var SPEED_VAR = 0.1;
	static var isRecorded = false;
	static var goal = :heartRate;
	static var version = 1;
	
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
	var buzzMode = :normal;
	var done = false;

	var session = ActivityRecording.createSession({
			:sport => ActivityRecording.SPORT_RUNNING, 
			//:subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, 
			:name => "Interval Training"}
		);

	hidden var refreshTimer = new Timer.Timer();
	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE,Sensor.SENSOR_FOOTPOD]);
	

	function initialize(){	
	
	}
	
	function getSettings(){
		version = Settings.version;
		Settings.LoadSettings(version);
		NUM_LAP = Settings.GetLapValue();
		PREP_TIME = Settings.GetPrepValue();
		REST_TIME = Settings.GetRestValue();
		WORK_TIME = Settings.GetWorkValue();
		NUM_ROUNDS = Settings.GetRoundsValue();
		HEART_WORK_GOAL = Settings.GetHeartWorkValue();
		HEART_REST_GOAL = Settings.GetHeartRestValue();
		SPEED_WORK_GOAL = Settings.GetSpeedWorkValue();
		SPEED_REST_GOAL = Settings.GetSpeedRestValue();
		HEART_VAR = Settings.HEART_VAR;
		SPEED_VAR = Settings.SPEED_VAR;
		heartRate = Activity.getActivityInfo().currentHeartRate;		
		speed = Activity.getActivityInfo().currentSpeed;
		isRecorded = Settings.isRecorded;
		goal = Settings.goal;
		buzzMode = Settings.buzzMode;
		
		
		TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
	}
	
	function setTimer(phase){
		if (phase == :prep) {
			counterBis = PREP_TIME;
		} else if (phase == :work) {
			counterBis = WORK_TIME;
		}else if (phase == :rest) {
			counterBis = REST_TIME;
		}else {
			counterBis = WORK_TIME;
		}
	}

	function update(){	
		getSettings();
		setTimer(phase);
	}
	
	function start(){if (phase == :prep) {
			counterBis = PREP_TIME;
		} else if (phase == :work) {
			counterBis = WORK_TIME;
		}else if (phase == :rest) {
			counterBis = REST_TIME;
		}else {
			counterBis = WORK_TIME;
		}	
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
    	//heartRate = sensorInfo.heartRate;
    	}/*speed = sensorInfo.speed * 3.6;*/
}

	function refresh(){
		buzzHandler(counter);
		if (counter > 1){
			counter--;	
		} else {
			session.addLap();
			if (round == TOTAL_ROUNDS){
						finishUp();
			} else if (phase == :prep) {
				phase = :work;
				counter = WORK_TIME;
				round++;
				currentRound++;
			} else if (phase == :work) {
				phase = :rest;
				counter = REST_TIME;
			} else if (phase == :rest) {
			
				if (currentRound == NUM_ROUNDS){
					phase = :prep;
					counter = PREP_TIME;
					currentRound=0;
				} else {
						phase = :work;
						counter = WORK_TIME;
						round++;
						currentRound++;
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
		if(buzzMode==:none) {
		}else if (counter == 1){
			if (round == TOTAL_ROUNDS){
				stopBuzz();
			}else {
				intervalBuzz();
			}
		} else if(buzzMode==:silent){
		} else if (buzzCondition(counter)){
			preBuzz();
		} else if (counter%4==0 && goalBuzzCondition() && buzzMode == :vibrate){
			goalBuzz();
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
	
	function goalBuzzCondition(){
	
	if (	 (
				goal==:speed
				&& (
						phase == :work
					&&	(
							(speed < SPEED_WORK_GOAL-SPEED_WORK_GOAL*Settings.SPEED_VAR)
						||	(speed > SPEED_WORK_GOAL+SPEED_WORK_GOAL*Settings.SPEED_VAR)
						)
					||	(speed < SPEED_REST_GOAL-2*SPEED_REST_GOAL*Settings.SPEED_VAR)
					||	(speed > SPEED_REST_GOAL+SPEED_REST_GOAL*Settings.SPEED_VAR)
					)
				)
				|| 
				(
				(goal==:heartRate) 
				&& ( 
						phase == :work
					&&	(
							(heartRate < HEART_WORK_GOAL-HEART_WORK_GOAL*Settings.HEART_VAR)
						||	(heartRate > HEART_WORK_GOAL+HEART_WORK_GOAL*Settings.HEART_VAR)
						) 
					||	(heartRate < HEART_REST_GOAL-2*HEART_REST_GOAL*Settings.HEART_VAR)
					||	(heartRate > HEART_REST_GOAL+HEART_REST_GOAL*Settings.HEART_VAR)
					) 
			)
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
		vibrate(500);
	}
	
	function goalBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(100);
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