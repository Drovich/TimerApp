using Toybox.Graphics as Gfx;
using Toybox.Application as App;

// set of permanently stored values
//
class Settings
{

	static var NUM_LAP = 4;
	static var PREP_TIME = 30;
	static var REST_TIME = 10;
	static var WORK_TIME = 20;
	static var NUM_ROUNDS = 8;
	static var HEART_WORK_GOAL = 150;
	static var HEART_REST_GOAL = 130;
	static var isRecorded = false;
	
	static var HEART_VAR = 0.1;
	
	
	static var TimerValue = 300;
	static var IsTimerValueUpdated = false;
	static var IsLapValueUpdated = false;
	static var IsRoundsValueUpdated = false;
	static var IsPrepValueUpdated = false;
	static var IsRestValueUpdated = false;
	static var IsHeartWorkValueUpdated = false;
	static var IsHeartRestValueUpdated = false;
	static var IsWorkValueUpdated = false;
	static var IsRecordedValueUpdated = false;
	
	
	static var DimColor = Gfx.COLOR_LT_GRAY;
	static var ForegroundColor = Gfx.COLOR_WHITE;
	static var BackgroundColor = Gfx.COLOR_BLACK;
	
	static var IsAutoRecording = false;
	static var IsWhiteBackground = false;

	static var CurrentRoute = null;
	static var WpEpsilon = 100;

	static function LoadSettings()
	{
		SetAutoRecording(App.getApp().getProperty("IsAutoRecording"));
		SetTimerValue(App.getApp().getProperty("timerValue"));
		SetBackground(App.getApp().getProperty("isWhiteBackground"));
		WpEpsilon = App.getApp().getProperty("wpEpsilon");
		CurrentRoute = App.getApp().getProperty("CurrentRoute");
	}

	static function SaveSettings()
	{
		App.getApp().setProperty("isWhiteBackground", IsWhiteBackground);
		App.getApp().setProperty("timerValue", TimerValue);
		App.getApp().setProperty("IsAutoRecording", IsAutoRecording);
		
		App.getApp().setProperty("CurrentRoute", CurrentRoute);
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
		PREP_TIME = (value == null) ? 5 : value;
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
	
	static function GetIsRecorded()
	{
		IsRecordedValueUpdated = false; 
		return isRecorded;
	}
	

	static function SetAutoRecording(isAutoRecording)
	{
		IsAutoRecording = (isAutoRecording == null) ? false : isAutoRecording;
	}
	
	static function Increment(phase,count){
		var quotient = 5*(count/6);
		if (quotient == 0){quotient = 1;}
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
		HEART_WORK_GOAL=HEART_WORK_GOAL+quotient;
	}
		if (phase == :restHeart) {
		HEART_REST_GOAL=HEART_REST_GOAL+quotient;
    	}
    	if (phase == :isRecord) {
			if(isRecorded==true){isRecorded=false;
			}else{isRecorded=true;}
	    }
	}
	
		static function Decrement(phase,count){
		var quotient = 5*(count/6);
		if (quotient == 0){quotient = 1;}
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
			if(NUM_LAP>quotient){NUM_LAP=NUM_LAP-quotient;}
		}
		if (phase == :rounds) {
			if(NUM_ROUNDS>quotient){NUM_ROUNDS=NUM_ROUNDS-quotient;}
		}
		if (phase == :workHeart) {
			if(HEART_WORK_GOAL>40+quotient){HEART_WORK_GOAL=HEART_WORK_GOAL-quotient;}
		}
		if (phase == :restHeart) {
			if(HEART_REST_GOAL>30+quotient){HEART_REST_GOAL=HEART_REST_GOAL-quotient;}
	    }
	    if (phase == :isRecord) {
			if(isRecorded==true){isRecorded=false;
			}else{isRecorded=true;}
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
		
	}
}