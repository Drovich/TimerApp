using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

// setting menu handler
//
class SettingMenuDelegate extends Ui.MenuInputDelegate 
{
    hidden var _raceTimerView;
    
    function initialize(raceTimerView) 
    {
        MenuInputDelegate.initialize();
        _raceTimerView = raceTimerView;
    }

    function onMenuItem(item) 
    {
        if (item == :setTimer)
        {
            Ui.pushView(new Rez.Menus.SetTimerMenu(), new SetTimerMenuDelegate(_raceTimerView), Ui.SLIDE_LEFT);
        } 
        else if (item == :backgroundColor)
        {
        	var backgroundMenu = new Ui.Menu(); 
        	backgroundMenu.setTitle("Background Color");
            backgroundMenu.addItem((Settings.IsWhiteBackground ? "*" : "") + " White", :white);
            backgroundMenu.addItem((Settings.IsWhiteBackground ? "" : "*") + " Black", :black);
        	Ui.pushView(backgroundMenu, new BackgroundColorMenuDelegate(), Ui.SLIDE_LEFT);
        }  
        else if (item == :isAutoStartRecording)
        {
            var autoRecordingMenu = new Ui.Menu();
            autoRecordingMenu.setTitle("Auto Recording");
            autoRecordingMenu.addItem((Settings.isRecorded ? "*" : "") + " On", :isAutoOn);
            autoRecordingMenu.addItem((Settings.isRecorded ? "" : "*") + " Off", :isAutoOff);
            Ui.pushView(autoRecordingMenu, new AutoRecordingMenuDelegate(), Ui.SLIDE_LEFT);
        }
    }
}

class BackgroundColorMenuDelegate extends Ui.MenuInputDelegate 
{
    function initialize() 
    {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) 
    {
        if (item == :white)
        {
            Settings.SetBackground(true);
        } 
        else if (item == :black)
        {
            Settings.SetBackground(false);
        }  
    }
}

class AutoRecordingMenuDelegate extends Ui.MenuInputDelegate 
{
    function initialize() 
    {
        MenuInputDelegate.initialize();
    }
    
    function onMenuItem(item) 
    {
        if (item == :isAutoOn)
        {
            Settings.SetIsRecorded(true);
        }
        else if (item == :isAutoOff)
        {
            Settings.SetIsRecorded(false);
        }
    }
}