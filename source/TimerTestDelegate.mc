using Toybox.WatchUi as Ui;

class TimerTestDelegate extends Ui.InputDelegate {

	hidden var model;
	hidden var started = false;
	hidden var yCoordonate;
	hidden var xCoordonate;
	hidden var decreaseCount = 0;
	hidden var increaseCount = 0;

  function initialize(mdl) {
  	model = mdl;
  	Settings.LoadSettings(model.version);
    InputDelegate.initialize();
  }

	function onKey(evt) {
		if(evt.getKey() == Ui.KEY_ENTER && !started) {
			/*Settings.SetTimerParameter(3,4,10,20,30,140); /*Lap,Rounds,Prep,Work,Rest,Heart*/
			model.phase = :prep;
  			model.start();
			started = true;
			Ui.requestUpdate();
			return true;
		} else {
			return InputDelegate.onKey(evt);
		}
	}
	
	function onTap(clickEvent) {
		yCoordonate=clickEvent.getCoordinates()[1];
		xCoordonate=clickEvent.getCoordinates()[0];
		/*System.println("Previous: " + yCoordonate);
		System.println("Next: " + xCoordonate);*/
		if(clickEvent.getType() == CLICK_TYPE_TAP && !started) {
			if (yCoordonate > 120){
				decreaseCount++;
				increaseCount=0;
				Settings.Decrement(model.phase,decreaseCount); 
				Ui.requestUpdate();
				return true;
			}else if (yCoordonate < 80){
				decreaseCount=0;
				increaseCount++;
				Settings.Increment(model.phase,increaseCount); 
				Ui.requestUpdate();
				return true;
			}else if (xCoordonate > 80){
				decreaseCount=0;
				increaseCount=0;
				if(model.phase == :prep){
					model.phase = :rest;
				}else if(model.phase == :rest){
					model.phase = :work;
				}else if(model.phase == :work){
					model.phase = :workHeart;
				}else if(model.phase == :workHeart){
					model.phase = :restHeart;
				}else if(model.phase == :restHeart){
					model.phase = :rounds;
				}else if(model.phase == :rounds){
					model.phase = :lap;
				}else if(model.phase == :lap){
					model.phase = :isRecord;
				}else if(model.phase == :isRecord){
					model.phase = :version;
				}else if(model.phase == :version){
					model.phase = :prep;
				}
			}else if (xCoordonate < 60){
				decreaseCount=0;
				increaseCount=0;
				if(model.phase == :prep){
					model.phase = :version;
				}else if(model.phase == :version){
					model.phase = :isRecord;
				}else if(model.phase == :rest){
					model.phase = :prep;
				}else if(model.phase == :work){
					model.phase = :rest;
				}else if(model.phase == :workHeart){
					model.phase = :work;
				}else if(model.phase == :restHeart){
					model.phase = :workHeart;
				}else if(model.phase == :rounds){
					model.phase = :restHeart;
				}else if(model.phase == :lap){
					model.phase = :rounds;
				}else if(model.phase == :isRecord){
					model.phase = :lap;
				}
				Ui.requestUpdate();
				return true;
			}
  			/*model.start();
			started = true;*/
			Ui.requestUpdate();
			return true;
		} else {
			return InputDelegate.onTap(clickEvent);
		}
	}
}