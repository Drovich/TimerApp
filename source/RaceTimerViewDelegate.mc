using Toybox.WatchUi as Ui;

class RaceTimerViewDelegate extends Ui.BehaviorDelegate 
{
    hidden var _raceTimerView;
    
    function initialize(raceTimerView) 
    {
        BehaviorDelegate.initialize();
        _raceTimerView = raceTimerView;
    }    
    
    function onMenu() 
    {
        Ui.popView(Ui.SLIDE_RIGHT);
        return true;
    }
    
    function onNextPage()
    {
    	_raceTimerView.SubOneSec();
    	return true;
    }
    
    function onPreviousPage()
    {
    	_raceTimerView.AddOneSec();
    	return true;
    }
    
    function onBack()
    {
    	_raceTimerView.DownToMinute();
    	return true;
    }
}