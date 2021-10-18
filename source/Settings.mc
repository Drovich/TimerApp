using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Application.Storage;

// set of permanently stored values
//


class Settings
{
	static var PREP_TIME = 30;
	static var REST_TIME = 10;
	static var WORK_TIME = 20;
	static var NUM_ROUNDS = 8;
	static var NUM_LAP = 4;
	static var HEART_WORK_GOAL = 150;
	static var HEART_REST_GOAL = 130;
	static var SPEED_WORK_GOAL = 12;
	static var SPEED_REST_GOAL = 8;
	static var isRecorded = false;
	static var goal = :heartRate;
	static var version = 1;
	static var buzzMode = :normal;
	
	static var HEART_VAR = 0.1;
	static var SPEED_VAR = 0.1;
	
	
	static var TimerValue = 40;
	static var IsTimerValueUpdated = false;
	static var IsLapValueUpdated = false;
	static var IsRoundsValueUpdated = false;
	static var IsPrepValueUpdated = false;
	static var IsRestValueUpdated = false;
	static var IsHeartWorkValueUpdated = false;
	static var IsHeartRestValueUpdated = false;
	static var IsSpeedWorkValueUpdated = false;
	static var IsSpeedRestValueUpdated = false;
	static var IsWorkValueUpdated = false;
	static var IsRecordedValueUpdated = false;
	static var IsVersionUpdated = false; 
	
	
	static var DimColor = Gfx.COLOR_LT_GRAY;
	static var ForegroundColor = Gfx.COLOR_WHITE;
	static var BackgroundColor = Gfx.COLOR_BLACK;
	
	static var IsWhiteBackground = false;

	static function LoadSettings(version)
	{
//		if (version<1 || version>11){version =1;}
//		SetVersion(App.getApp().getProperty("version"));
		
		
		//SetTimerValue(App.getApp().getProperty("timerValue"));
		//SetPrepValue(App.getApp().getProperty("timerValue"));
		SetBackground(App.getApp().getProperty("isWhiteBackground"));
		SetIsRecorded(App.getApp().getProperty("isRecorded"));
		
		SetPrepValue(App.getApp().getProperty("prepTime"+version));
		SetRestValue(App.getApp().getProperty("restTime"+version));
		SetWorkValue(App.getApp().getProperty("workTime"+version));
		SetHeartWorkValue(App.getApp().getProperty("HeartWork"+version));
		SetHeartRestValue(App.getApp().getProperty("HeartRest"+version));
		SetSpeedWorkValue(App.getApp().getProperty("SpeedWork"+version));
		SetSpeedRestValue(App.getApp().getProperty("SpeedRest"+version));
		SetRoundsValue(App.getApp().getProperty("NumRound"+version));
		SetLapValue(App.getApp().getProperty("NumLap"+version));
		

	}

	static function SaveSettings(version)
	{
//		if (version<1 || version>11){version =1;}
		App.getApp().setProperty("version",version);
		
		App.getApp().setProperty("isWhiteBackground", IsWhiteBackground);
		App.getApp().setProperty("timerValue", TimerValue);
		App.getApp().setProperty("isRecorded", isRecorded);
		
		
		App.getApp().setProperty("prepTime"+version, PREP_TIME);
		App.getApp().setProperty("restTime"+version, REST_TIME);
		App.getApp().setProperty("workTime"+version, WORK_TIME);
		App.getApp().setProperty("HeartWork"+version, HEART_WORK_GOAL);
		App.getApp().setProperty("HeartRest"+version, HEART_REST_GOAL);
		App.getApp().setProperty("SpeedWork"+version, SPEED_WORK_GOAL);
		App.getApp().setProperty("SpeedRest"+version, SPEED_REST_GOAL);
		App.getApp().setProperty("NumRound"+version, NUM_ROUNDS);
		App.getApp().setProperty("NumLap"+version, NUM_LAP);
		
		
		
	}

	static function SetBackground(isWhiteBackground)
	{
		IsWhiteBackground = (isWhiteBackground == null) ? false : isWhiteBackground;
        ForegroundColor = isWhiteBackground ? Gfx.COLOR_BLACK : Gfx.COLOR_WHITE;
        BackgroundColor = isWhiteBackground ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK;
        DimColor = isWhiteBackground ? Gfx.COLOR_DK_GRAY : Gfx.COLOR_LT_GRAY;
	}
	

	
	static function GetTimerValue()
	{
		IsTimerValueUpdated = false; 
		return TimerValue;
	}
	static function SetTimerValue(value)
	{
		TimerValue = (value == null) ? 300 : value;
		IsTimerValueUpdated = true;
	}
	
	static function GetVersion()
	{
		IsVersionUpdated = false; 
		return version;
	}
	static function SetVersion(value)
	{
		version = (value == null) ? 1 : value;
		IsVersionUpdated = true;
	}
	
	static function GetLapValue()
	{
		IsLapValueUpdated = false; 
		return NUM_LAP;
	}
	static function SetLapValue(value)
	{
		NUM_LAP = (value == null) ? 5 : value;
		IsLapValueUpdated = true;
	}
	
	static function GetRoundsValue()
	{
		IsRoundsValueUpdated = false; 
		return NUM_ROUNDS;
	}
	static function SetRoundsValue(value)
	{
		NUM_ROUNDS = (value == null) ? 5 : value;
		IsRoundsValueUpdated = true;
	}
	
	static function GetPrepValue()
	{
		IsPrepValueUpdated = false; 
		return PREP_TIME;
	}
	static function SetPrepValue(value)
	{
		PREP_TIME =  (value == null) ? 5 : value;
		IsPrepValueUpdated = true;
	}

	static function GetWorkValue()
	{
		IsWorkValueUpdated = false; 
		return WORK_TIME;
	}
	static function SetWorkValue(value)
	{
		WORK_TIME = (value == null) ? 5 : value;
		IsWorkValueUpdated = true;
	}
	
	static function GetRestValue()
	{
		IsRestValueUpdated = false; 
		return REST_TIME;
	}
	static function SetRestValue(value)
	{
		REST_TIME = (value == null) ? 5 : value;
		IsRestValueUpdated = true;
	}
	
	static function GetHeartWorkValue()
	{
		IsHeartWorkValueUpdated = false; 
		return HEART_WORK_GOAL;
	}
	static function SetHeartWorkValue(value)
	{
		HEART_WORK_GOAL = (value == null) ? 150 : value;
		IsHeartWorkValueUpdated = true;
	}
	
	static function GetHeartRestValue()
	{
		IsHeartRestValueUpdated = false; 
		return HEART_REST_GOAL;
	}
	static function SetHeartRestValue(value)
	{
		HEART_REST_GOAL = (value == null) ? 150 : value;
		IsHeartRestValueUpdated = true;
	}
	
	static function GetSpeedWorkValue()
	{
		IsSpeedWorkValueUpdated = false; 
		return SPEED_WORK_GOAL;
	}
	static function SetSpeedWorkValue(value)
	{
		SPEED_WORK_GOAL = (value == null) ? 15 : value;
		IsSpeedWorkValueUpdated = true;
	}
	
	static function GetSpeedRestValue()
	{
		IsSpeedRestValueUpdated = false; 
		return SPEED_REST_GOAL;
	}
	static function SetSpeedRestValue(value)
	{
		SPEED_REST_GOAL = (value == null) ? 8 : value;
		IsSpeedRestValueUpdated = true;
	}
	
	static function GetIsRecorded()
	{
		IsRecordedValueUpdated = false; 
		return isRecorded;
	}
	static function SetIsRecorded(value)
	{
		isRecorded = (value == null) ? false : value;
	}
	
	static function Increment(phase,count){
		var quotient = 5*(count/11);
		if (quotient == 0){quotient = 1;}
		if (phase == :version) {
			if(version>10){version=1;}else{version=version+1;}
	    }else{
		if (phase == :prep) {
			PREP_TIME=PREP_TIME+quotient;
    	}
    	if (phase == :rest) {
    		REST_TIME=REST_TIME+quotient;
    	}
     	if (phase == :work) {
    		WORK_TIME=WORK_TIME+quotient;
    	}
		if (phase == :lap) {
			NUM_LAP=NUM_LAP+quotient;
		}
		if (phase == :rounds) {
			NUM_ROUNDS=NUM_ROUNDS+quotient;
		}
		if (phase == :workHeart) {
			if(HEART_WORK_GOAL<200-quotient){HEART_WORK_GOAL=HEART_WORK_GOAL+quotient;
			}else{HEART_WORK_GOAL=200;}
		}
		if (phase == :restHeart) {
			if(HEART_REST_GOAL<160-quotient){HEART_REST_GOAL=HEART_REST_GOAL+quotient;
			}else{HEART_REST_GOAL=160;}
    	}
    	if (phase == :workSpeed) {
			if(SPEED_WORK_GOAL<60-quotient){SPEED_WORK_GOAL=SPEED_WORK_GOAL+quotient;
			}else{SPEED_WORK_GOAL=60;}
		}
		if (phase == :restSpeed) {
			if(SPEED_REST_GOAL<30-quotient){SPEED_REST_GOAL=SPEED_REST_GOAL+quotient;
			}else{SPEED_REST_GOAL=30;}
    	}
    	if (phase == :isRecord) {
			if(isRecorded==true){isRecorded=false;
			}else{isRecorded=true;}
	    }
	    if (phase == :goal) {
			if(goal==:speed){goal=:heartRate;
			}else if (goal == :heartRate) {goal=:speed;}
	    }
	    if (phase == :buzz) {
			if(buzzMode==:vibrate){buzzMode=:none;
			}else if (buzzMode == :none) {buzzMode=:silent;
			}else if (buzzMode == :silent) {buzzMode=:normal;
			}else if (buzzMode == :normal) {buzzMode=:vibrate;
			}
	    }
	    SaveSettings(version);
	    }
	}
	
		static function Decrement(phase,count){
		var quotient = 5*(count/11);
		if (quotient == 0){quotient = 1;}
		if (phase == :version) {
			if(version<1){version=11;}else{version=version-1;}
	    }else{
		if (phase == :prep) {
    		if(PREP_TIME>quotient){PREP_TIME=PREP_TIME-quotient;}
    	}
    	if (phase == :rest) {
    		if(REST_TIME>quotient){REST_TIME=REST_TIME-quotient;}
    	}
     	if (phase == :work) {
    		if(WORK_TIME>quotient){WORK_TIME=WORK_TIME-quotient;}
    	}
		if (phase == :lap) {
			if(NUM_LAP>quotient){NUM_LAP=NUM_LAP-quotient;}else{NUM_LAP=1;}
		}
		if (phase == :rounds) {
			if(NUM_ROUNDS>quotient){NUM_ROUNDS=NUM_ROUNDS-quotient;}else{NUM_ROUNDS=1;}
		}
		if (phase == :workHeart) {
			if(HEART_WORK_GOAL>40+quotient){HEART_WORK_GOAL=HEART_WORK_GOAL-quotient;
			}else{HEART_WORK_GOAL=40;}
		}
		if (phase == :restHeart) {
			if(HEART_REST_GOAL>30+quotient){HEART_REST_GOAL=HEART_REST_GOAL-quotient;
			}else{HEART_REST_GOAL=30;}
	    }
	    if (phase == :workSpeed) {
			if(SPEED_WORK_GOAL>quotient){SPEED_WORK_GOAL=SPEED_WORK_GOAL-quotient;
			}else{SPEED_WORK_GOAL=1;}
		}
		if (phase == :restSpeed) {
			if(SPEED_REST_GOAL>quotient-1){SPEED_REST_GOAL=SPEED_REST_GOAL-quotient;
			}else{SPEED_REST_GOAL=0;}
	    }
	    
	    if (phase == :isRecord) {
			if(isRecorded==true){isRecorded=false;
			}else{isRecorded=true;}
	    }
	    if (phase == :goal) {
			if(goal==:speed){goal=:heartRate;
			}else if (goal == :heartRate) {goal=:speed;}
	    }
	    if (phase == :buzz) {
			if(buzzMode==:vibrate){buzzMode=:normal;
			}else if (buzzMode == :normal) {buzzMode=:silent;
			}else if (buzzMode == :silent) {buzzMode=:none;
			}else if (buzzMode == :none) {buzzMode=:vibrate;
			}
	    }
	    SaveSettings(version);
	    }
	}
	
	static function SetTimerParameter(lap,rounds,prep,work,rest,heart)
	{
		Settings.SetLapValue(lap);
		Settings.SetRoundsValue(rounds);
		Settings.SetPrepValue(prep);
		Settings.SetRestValue(work);
		Settings.SetWorkValue(rest);
		Settings.SetHeartWorkValue(heart);
		LoadSettings();
	}
}