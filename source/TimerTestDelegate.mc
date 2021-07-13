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
		Settings.SetTimerParameter(3,4,10,20,30,100); /*Lap,Rounds,Prep,Work,Rest,Heart*/
		/*TimerTestView.SetupHeartGoal(100);*/
  		model.start();
			started = true;
			return true;
		} else {
			return InputDelegate.onKey(evt);
		}
	}
}