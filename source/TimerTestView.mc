using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimerTestView extends Ui.View {

  	var model;
	hidden var _setTimerView;
	hidden var _setTimerDelegate;
	static var heartGoal;
	var heartVar;
	
	function initialize(mdl) {
		model = mdl;
		View.initialize();
		heartGoal = Settings.HEART_GOAL;
		heartVar = Settings.HEART_VAR;

	  }
	  
  function SetupHeartGoal(heartGoalValue) {
 	heartGoal = heartGoalValue;
 }

  function onUpdate(dc) {
 	heartGoal = Settings.HEART_GOAL;
  	setupDisplay(dc, model.phase);
  	if (model.done){
  		Ui.switchToView(new DoneView(), new DoneDelegate(), Ui.SLIDE_IMMEDIATE);
  	} else {
  		largeText(timerString(), dc);
    	bottomText( "" +  model.currentRound + "/" + model.NUM_ROUNDS + " | " + "" + model.round + "/" + model.TOTAL_ROUNDS, dc);
    	if (model.phase == :prep) {
    		topText("" + heartGoal + " | PREP | " + model.heartRate + "", dc);
    	}
    	if (model.phase == :rest) {
    		topText("" + heartGoal + " | REST | " + model.heartRate + "", dc);
    	}
      if (model.phase == :work) {
    		topText("" + heartGoal + " | GO | " + model.heartRate + "", dc);
    	}
  	}
  }

  function setupDisplay(dc, phase){
  	if (phase == :work) {
  		if(heartGoal-heartGoal*heartVar > model.heartRate){
  			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
  		} else if (model.heartRate > heartGoal-heartGoal*heartVar){
  			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_WHITE);
  		} else { 
  			dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_WHITE);
  	}
  	} else if (phase == :rest) {
	  	if(heartGoal-3*heartGoal*heartVar > model.heartRate){
	  			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
	  	}  else if (model.heartRate > heartGoal-heartGoal*heartVar){
  			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
  		} else { 
  			dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
  		}
  	}else {
  		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
  	}
    dc.clear();
  }

  function topText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function bottomText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.8, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_NUMBER_THAI_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function timerString(){
    return "0:" + model.counter.format("%02d");
  }
}