using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as Fit;
using Toybox.Timer as T;

class RaceTimerView extends Ui.View 
{
    hidden var _gpsWrapper;
    hidden var _cruiseView;
    hidden var _raceTimerViewDc;
	hidden var _timer; 
	hidden var _timerValue = 0;
	hidden var _isTimerRun = false;

    function initialize(gpsWrapper, cruiseView, raceTimerViewDc) 
    {
        View.initialize();
        _gpsWrapper = gpsWrapper;
        _cruiseView = cruiseView;
        _raceTimerViewDc = raceTimerViewDc;
        _timer = new T.Timer();
    }

	// SetUp timer on show to update every second
    //
    function onShow() 
    {
//    	_timer.start(method(:onTimerUpdate), 1000, true);
//    	if (_timerValue <= 0 || Settings.IsTimerValueUpdated)
//    	{
//    		_timerValue = Settings.GetTimerValue();
//    	}
    }

    // Stop timer then hide
    //
    function onHide() 
    {
    	_isTimerRun =false;
        _timer.stop();
    }

    
    function AddOneSec()
    {
    	_timerValue += 1;
    	Ui.requestUpdate();
    }
    
    function SubOneSec()
    {
    	_timerValue -= 1;
    	Ui.requestUpdate();
    }
    
    function DownToMinute()
    {
    	_timerValue = _timerValue.toLong() / 60 * 60;
    	Ui.requestUpdate();
    }
}