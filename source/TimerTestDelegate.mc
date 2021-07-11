using Toybox.WatchUi as Ui;

class TimerTestDelegate extends Ui.InputDelegate {

	hidden var model;
	hidden var started = false;

  function initialize(mdl) {
  	model = mdl;
    InputDelegate.initialize();
  }

	function onKey(evt) {
		if(evt.getKey() == Ui.KEY_ENTER && !started) {
		Settings.SetLapValue(4);
		Settings.SetRoundsValue(5);
		Settings.SetPrepValue(2);
		Settings.SetRestValue(2);
		Settings.SetWorkValue(2);
		
  		model.start();
			started = true;
			return true;
		} else {
			return InputDelegate.onKey(evt);
		}
	}
}