using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimerTestView extends Ui.View {

  	var model;
	hidden var _setTimerView;
	hidden var _setTimerDelegate;
	
	function initialize(mdl) {
		model = mdl;
		View.initialize();
	  }
	  

  function onUpdate(dc) {
  	model.update();
 	
  	setupDisplay(dc, model.phase);
  	if (model.done){
  		Ui.switchToView(new DoneView(), new DoneDelegate(), Ui.SLIDE_IMMEDIATE);
  	} else {
  		//largeText(timerString(), dc);
    	bottomText( "" +  model.currentRound + "/" + model.NUM_ROUNDS + " | " + "" + model.round + "/" + model.TOTAL_ROUNDS, dc);

	    if (model.goal == :speed){
    		if (model.phase == :goal){
    			topText("" + model.SPEED_WORK_GOAL + " |Goal| " + model.SPEED_REST_GOAL + "", dc);
    			largeText("Speed", dc);
    		}
			if (model.phase == :prep) {
    			topText("" + model.SPEED_REST_GOAL + " |PREP| " + model.speed.format("%02.1f") + "", dc);
    			largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + model.SPEED_REST_GOAL + " |REST| " + model.speed.format("%02.1f") + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + model.SPEED_WORK_GOAL + " |GO| " + model.speed.format("%02.1f") + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + model.SPEED_WORK_GOAL + " |ROUND| " + model.SPEED_REST_GOAL + "", dc);
	    		largeNumber(model.NUM_ROUNDS,dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + model.SPEED_WORK_GOAL + " |LAP| " + model.SPEED_REST_GOAL + "", dc);
	    		largeNumber(model.NUM_LAP,dc);
	    	}
	      	if (model.phase == :workSpeed) {
	    		topText("" + model.SPEED_WORK_GOAL + " |WSpeed| " + model.speed.format("%2.1f") + "", dc);
	    		largeNumber(model.SPEED_WORK_GOAL,dc);
	    	}
	    	if (model.phase == :restSpeed) {
	    		topText("" + model.SPEED_REST_GOAL + " |RSpeed| " + model.speed.format("%2.1f") + "", dc);
	    		largeNumber(model.SPEED_REST_GOAL,dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + model.SPEED_WORK_GOAL + " |Work| " + model.SPEED_REST_GOAL + "" , dc);
		    	largeText("Workout"+model.version,dc);
			}
			if (model.phase == :buzz){
		    	topText("" + model.SPEED_WORK_GOAL + " |Buzz| " + model.SPEED_REST_GOAL + "" , dc);
		    	if(model.buzzMode == :none){
		    		largeText("None",dc);
		    	}else if (model.buzzMode == :silent){
		    		largeText("Silent",dc);
		    	}else if (model.buzzMode == :normal){
		    		largeText("Normal",dc);
		    	}else if (model.buzzMode == :vibrate){
		    		largeText("Vibrating",dc);
		    	}
			}
		}else if (model.goal == :heartRate){
			if (model.phase == :goal){	
				topText("" + model.HEART_WORK_GOAL + " |Goal| " + model.HEART_REST_GOAL + "", dc);
    			largeText("Heart Rate", dc);
			}
			if (model.phase == :prep) {
    			topText("" + model.HEART_REST_GOAL + " |PREP| " + model.heartRate + "", dc);
    			largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + model.HEART_REST_GOAL + " |REST| " + model.heartRate + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + model.HEART_WORK_GOAL + " |GO| " + model.heartRate + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + model.HEART_WORK_GOAL + " |ROUND| " + model.HEART_REST_GOAL + "", dc);
	    		largeNumber(model.NUM_ROUNDS,dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + model.HEART_WORK_GOAL + " |LAP| " + model.HEART_REST_GOAL + "", dc);
	    		largeNumber(model.NUM_LAP,dc);
	    	}
	      	if (model.phase == :workHeart) {
	    		topText("" + model.HEART_WORK_GOAL + " |W HR| " + model.heartRate + "", dc);
	    		largeNumber(model.HEART_WORK_GOAL,dc);
	    	}
	    	if (model.phase == :restHeart) {
	    		topText("" + model.HEART_REST_GOAL + " |R HR| " + model.heartRate + "", dc);
	    		largeNumber(model.HEART_REST_GOAL,dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + model.HEART_WORK_GOAL + " |Work| " + model.HEART_REST_GOAL + "" , dc);
		    	largeText("Workout"+model.version,dc);
			}
			if (model.phase == :buzz){
		    	topText("" + model.HEART_WORK_GOAL + " |Buzz| " + model.HEART_REST_GOAL + "" , dc);
		    	if(model.buzzMode == :none){
		    		largeText("None",dc);
		    	}else if (model.buzzMode == :silent){
		    		largeText("Silent",dc);
		    	}else if (model.buzzMode == :normal){
		    		largeText("Normal",dc);
		    	}else if (model.buzzMode == :vibrate){
		    		largeText("Vibrating",dc);
		    	}
			}
			
		}
		
	   	if (model.phase == :isRecord){
		    	if (model.isRecorded == true){
		    		topText("Record True", dc);
		    	}else{
		    		topText("Record False", dc);
		    	}
	    	}
	  	}
	  }

  function setupDisplay(dc, phase){
 	if (model.heartRate == null ){
 		model.heartRate=111;
 	}
 	if (model.speed == null ){
 		model.speed=11;
 	}
 	if (model.goal == :heartRate){
	  	if (phase == :work) {
	  		if(model.heartRate < model.HEART_WORK_GOAL-model.HEART_WORK_GOAL*Settings.HEART_VAR ){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
	  		} else if (model.heartRate > model.HEART_WORK_GOAL+model.HEART_WORK_GOAL*Settings.HEART_VAR){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
	  		} else { 
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
	  	}
	  	} else if (phase == :rest) {
		  	if(model.heartRate < model.HEART_REST_GOAL-2*model.HEART_REST_GOAL*Settings.HEART_VAR ){
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
		  	}  else if (model.heartRate > model.HEART_REST_GOAL+model.HEART_REST_GOAL*Settings.HEART_VAR){
	  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_RED);
	  		} else { 
	  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_GREEN);
	  		}
	  	}else {
	  		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
	  	}
	  }
	  if (model.goal == :speed){
		  if (phase == :work) {
		  		if(model.speed < model.SPEED_WORK_GOAL-model.SPEED_WORK_GOAL*Settings.SPEED_VAR ){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
		  		} else if (model.speed > model.SPEED_WORK_GOAL+model.SPEED_WORK_GOAL*Settings.SPEED_VAR){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
		  		} else { 
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
		  	}
		  	} else if (phase == :rest) {
			  	if(model.speed < model.SPEED_REST_GOAL-2*model.SPEED_REST_GOAL*Settings.SPEED_VAR ){
			  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
			  	}  else if (model.speed > model.SPEED_REST_GOAL+model.SPEED_REST_GOAL*Settings.SPEED_VAR){
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_RED);
		  		} else { 
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_GREEN);
		  		}
		  	}else {
		  		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
		  	}
	  }
    dc.clear();
  }

  function topText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function bottomText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.8, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function largeNumber(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_NUMBER_THAI_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
  }
  
  function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function timerString(){
  var counterMin;
  var counterSec;
  	if (model.started ==true) {
  		counterMin = model.counter/60;
  		counterSec = model.counter%60;
    	return counterMin.format("%02d")+ ":" + counterSec.format("%02d");
    } else{
	    	counterMin = model.counterBis/60;
	  		counterSec = model.counterBis%60;
	    	return counterMin.format("%02d")+ ":" + counterSec.format("%02d");
   }
  }
}