using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

// main menu handler
//
class MainMenuDelegate extends Ui.MenuInputDelegate 
{
    hidden var _cruiseView;
    hidden var _gpsWrapper;
    hidden var _raceTimerView;
    hidden var _lapView;
    hidden var _waypointView;
    hidden var _selectRouteView;
    
    hidden var _routeCustomMenuView;
    
    function initialize(cruiseView, raceTimerView, lapView, waypointView, selectRouteView, routeCustomMenuView, gpsWrapper) 
    {
        MenuInputDelegate.initialize();
        
        _cruiseView = cruiseView;
        _raceTimerView = raceTimerView;
        _lapView = lapView;
        _waypointView = waypointView;
        _gpsWrapper = gpsWrapper;
        _selectRouteView = selectRouteView;
        _routeCustomMenuView = routeCustomMenuView;
    }

    function onMenuItem(item) 
    {
    	if (item == :raceTimer)
    	{
    		Ui.pushView(_raceTimerView, new RaceTimerViewDelegate(_raceTimerView), Ui.SLIDE_RIGHT);
    	}    
        else if (item == :setting)
        {
            Ui.pushView(new Rez.Menus.SettingMenu(), new SettingMenuDelegate(_raceTimerView), Ui.SLIDE_LEFT);
        }
    }
}