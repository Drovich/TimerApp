using Toybox.Graphics as Gfx;
using Toybox.Application as App;

// set of permanently stored values
//
class Settings
{

	static var NUM_LAP = 5;
	static var PREP_TIME = 5;
	static var REST_TIME = 5;
	static var WORK_TIME = 5;
	static var NUM_ROUNDS = 5;
	static var HEART_WORK_GOAL = 150;
	static var HEART_REST_GOAL = 130;
	
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
	

	static function SetAutoRecording(isAutoRecording)
	{
		IsAutoRecording = (isAutoRecording == null) ? false : isAutoRecording;
	}
	
	static function Increment(phase){
		if (phase == :prep) {
    		PREP_TIME++;
    	}
    	if (phase == :rest) {
    		REST_TIME++;
    	}
     	if (phase == :work) {
    		WORK_TIME++;
    	}
		if (phase == :lap) {
		NUM_LAP++;
	}
		if (phase == :rounds) {
		NUM_ROUNDS++;
	}
		if (phase == :workHeart) {
		HEART_WORK_GOAL++;
	}
		if (phase == :restHeart) {
		HEART_REST_GOAL++;
    	}
	}
	
		static function Decrement(phase){
		if (phase == :prep) {
    		if(PREP_TIME>1){PREP_TIME--;}
    	}
    	if (phase == :rest) {
    		if(REST_TIME>1){REST_TIME--;}
    	}
     	if (phase == :work) {
    		if(WORK_TIME>1){WORK_TIME--;}
    	}
		if (phase == :lap) {
			if(NUM_LAP>1){NUM_LAP--;}
		}
		if (phase == :rounds) {
			if(NUM_ROUNDS>1){NUM_ROUNDS--;}
		}
		if (phase == :workHeart) {
			if(HEART_WORK_GOAL>40){HEART_WORK_GOAL--;}
		}
		if (phase == :restHeart) {
			if(HEART_REST_GOAL>30){HEART_REST_GOAL--;}
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