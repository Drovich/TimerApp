using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimerTestView extends Ui.View {

  	var model;
	hidden var _setTimerView;
	hidden var _setTimerDelegate;
	static var heartWorkGoal;
	static var heartRestGoal;
	static var speedWorkGoal;
	static var speedRestGoal;
	
	var heartVar;
	var speedVar;
	
	function initialize(mdl) {
		model = mdl;
		View.initialize();
		heartWorkGoal = Settings.HEART_WORK_GOAL;
		heartRestGoal = Settings.HEART_REST_GOAL;
		heartVar = Settings.HEART_VAR;
		speedWorkGoal = Settings.SPEED_WORK_GOAL;
		speedRestGoal = Settings.SPEED_REST_GOAL;
		speedVar = Settings.SPEED_VAR;
	  }
	  

  function onUpdate(dc) {
  	model.update();
 	heartWorkGoal = model.HEART_WORK_GOAL;
 	heartRestGoal = model.HEART_REST_GOAL;
 	speedWorkGoal = model.SPEED_WORK_GOAL;
 	speedRestGoal = model.SPEED_REST_GOAL;
 	
  	setupDisplay(dc, model.phase);
  	if (model.done){
  		Ui.switchToView(new DoneView(), new DoneDelegate(), Ui.SLIDE_IMMEDIATE);
  	} else {
  		largeText(timerString(), dc);
    	bottomText( "" +  model.currentRound + "/" + model.NUM_ROUNDS + " | " + "" + model.round + "/" + model.TOTAL_ROUNDS, dc);

	    if (model.goal == :speed){
    		if (model.phase == :goal){
    			topText("Goal : Speed " , dc);
    		}
			if (model.phase == :prep) {
    			topText("" + speedRestGoal + " |PREP| " + model.speed.format("%02.1f") + "", dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + speedRestGoal + " |REST| " + model.speed.format("%02.1f") + "", dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + speedWorkGoal + " |GO| " + model.speed.format("%02.1f") + "", dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + speedWorkGoal + " |ROUND| " + model.speed.format("%02.1f") + "", dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + speedWorkGoal + " |LAP| " + model.speed.format("%2.1f") + "", dc);
	    	}
	      	if (model.phase == :workSpeed) {
	    		topText("" + speedWorkGoal + " |W HR| " + model.speed.format("%2.1f") + "", dc);
	    	}
	    	if (model.phase == :restSpeed) {
	    		topText("" + speedRestGoal + " |R HR| " + model.speed.format("%2.1f") + "", dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + speedWorkGoal + " |Work"+model.version + "| " + model.speed.format("%2.1f") + "" , dc);
			}
		}else if (model.goal == :heartRate){
			if (model.phase == :goal){	
				topText("Goal : Heart " , dc);
			}
			if (model.phase == :prep) {
    			topText("" + heartRestGoal + " |PREP| " + model.heartRate + "", dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + heartRestGoal + " |REST| " + model.heartRate + "", dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + heartWorkGoal + " |GO| " + model.heartRate + "", dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + heartWorkGoal + " |ROUND| " + model.heartRate + "", dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + heartWorkGoal + " |LAP| " + model.heartRate + "", dc);
	    	}
	      	if (model.phase == :workHeart) {
	    		topText("" + heartWorkGoal + " |W HR| " + model.heartRate + "", dc);
	    	}
	    	if (model.phase == :restHeart) {
	    		topText("" + heartRestGoal + " |R HR| " + model.heartRate + "", dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + heartWorkGoal + " |Work"+model.version + "| " + model.heartRate + "" , dc);
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
 	if (model.heartRate == null){
 		model.heartRate=100;
 	}
 	if (model.goal == :heartRate){
	  	if (phase == :work) {
	  		if(model.heartRate < heartWorkGoal-heartWorkGoal*heartVar ){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
	  		} else if (model.heartRate > heartWorkGoal+heartWorkGoal*heartVar){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
	  		} else { 
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
	  	}
	  	} else if (phase == :rest) {
		  	if(model.heartRate < heartRestGoal-2*heartRestGoal*heartVar ){
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
		  	}  else if (model.heartRate > heartRestGoal+heartRestGoal*heartVar){
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
		  		if(model.speed < speedWorkGoal-speedWorkGoal*speedVar ){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
		  		} else if (model.speed > speedWorkGoal+speedWorkGoal*speedVar){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
		  		} else { 
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
		  	}
		  	} else if (phase == :rest) {
			  	if(model.speed < speedRestGoal-2*speedRestGoal*speedVar ){
			  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
			  	}  else if (model.speed > speedRestGoal+speedRestGoal*speedVar){
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

  function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_NUMBER_THAI_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
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