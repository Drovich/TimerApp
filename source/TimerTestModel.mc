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
	
	static var isRecorded = false;
	static var goal = :heartRate;
	static var version = 1;
	
	static var heartWorkGoal = 150;
	static var heartRestGoal = 130;
	static var heartVar = 0.1;
	var heartRate = 60;
	
	static var speedWorkGoal = 12;
	static var speedRestGoal = 8;
	static var speedVar = 0.1;
	var speed = 10;
	
	static var cadenceWorkGoal = 185;
	static var cadenceRestGoal = 170;
	static var cadenceVar = 0.1;
	var cadence = 10;
	var cadenceTracking = true;
	
		
	var TOTAL_ROUNDS = NUM_ROUNDS*NUM_LAP;
	const HAS_TONES = Attention has :playTone;

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
		
		heartWorkGoal = Settings.GetHeartWorkValue();
		heartRestGoal = Settings.GetHeartRestValue();
		heartVar = Settings.GetHeartVar();
		heartRate = Activity.getActivityInfo().currentHeartRate;	
		if (heartRate==null){heartRate=-1;}
		
		speedWorkGoal = Settings.GetSpeedWorkValue();
		speedRestGoal = Settings.GetSpeedRestValue();
		speedVar = Settings.GetSpeedVar();
		speed = Activity.getActivityInfo().currentSpeed;
		if (speed==null){speed=-1;}
		
			
		cadenceWorkGoal = Settings.GetCadenceWorkValue();
		cadenceRestGoal = Settings.GetCadenceRestValue();
		cadenceVar = Settings.GetCadenceVar();
		cadence = Activity.getActivityInfo().currentCadence;
		cadenceTracking = Settings.GetCadenceTracking();
		if (cadence==null){cadence=-1;}
		
		
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
		} else if (counter%3==0 && goalBuzzCondition() && buzzMode == :vibrate){
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
	
	if (	 	(
				goal==:speed
				&& (
						phase == :work
					&&	(
							(speed < speedWorkGoal-speedWorkGoal*speedVar)
						||	(speed > speedWorkGoal+speedWorkGoal*speedVar)
						)
					||	(speed < speedRestGoal-speedRestGoal*speedVar)
					||	(speed > speedRestGoal+speedRestGoal*speedVar)
					)
				)
				|| 
				(
				(goal==:heartRate) 
				&& ( 
						phase == :work
					&&	(
							(heartRate < heartWorkGoal-heartWorkGoal*heartVar)
						||	(heartRate > heartWorkGoal+heartWorkGoal*heartVar)
						) 
					||	(heartRate < heartRestGoal-heartRestGoal*heartVar)
					||	(heartRate > heartRestGoal+heartRestGoal*heartVar)
					) 
				)
				|| 
				(
				(goal==:cadence || cadenceTracking==true) 
				&& (
						phase == :work
					&&	(
							(cadence < cadenceWorkGoal-cadenceWorkGoal*cadenceVar)
						||	(cadence > cadenceWorkGoal+cadenceWorkGoal*cadenceVar)
						) 
					||	(cadence < cadenceRestGoal-cadenceRestGoal*cadenceVar)
					||	(cadence > cadenceRestGoal+cadenceRestGoal*cadenceVar)
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
		vibrate(200);
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