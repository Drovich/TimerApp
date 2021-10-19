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
		if (model.cadenceTracking == true){
			largeTextBot("Cadence : "+model.cadence,dc);
			}
	    if (model.goal == :speed){
    		if (model.phase == :goal){
    			topText("" + model.speedWorkGoal + " |Goal| " + model.speedRestGoal + "", dc);
    			largeText("Speed", dc);
    		}
			if (model.phase == :prep) {
    			topText("" + model.speedRestGoal + " |PREP| " + model.speed.format("%02.1f") + "", dc);
    			largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + model.speedRestGoal + " |REST| " + model.speed.format("%02.1f") + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + model.speedWorkGoal + " |GO| " + model.speed.format("%02.1f") + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + model.speedWorkGoal + " |ROUND| " + model.speedRestGoal + "", dc);
	    		largeNumber(model.NUM_ROUNDS,dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + model.speedWorkGoal + " |LAP| " + model.speedRestGoal + "", dc);
	    		largeNumber(model.NUM_LAP,dc);
	    	}
	      	if (model.phase == :workSpeed) {
	    		topText("" + model.speedWorkGoal + " |WSpeed| " + model.speed.format("%2.1f") + "", dc);
	    		largeNumber(model.speedWorkGoal,dc);
	    	}
	    	if (model.phase == :restSpeed) {
	    		topText("" + model.speedRestGoal + " |RSpeed| " + model.speed.format("%2.1f") + "", dc);
	    		largeNumber(model.speedRestGoal,dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + model.speedWorkGoal + " |Work| " + model.speedRestGoal + "" , dc);
		    	largeText("Workout"+model.version,dc);
			}
			if (model.phase == :cadence){
		    	topText("" + model.cadenceWorkGoal + "|Cadence|" + model.cadenceRestGoal + "" , dc);
		    	if(model.cadenceTracking == true){
		    		largeText("Cadence Tracking",dc);
		    	}else if (model.cadenceTracking == false){
		    		largeText("No CadenceTracking",dc);
		    	}
			}
			if (model.phase == :buzz){
		    	topText("" + model.speedWorkGoal + " |Buzz| " + model.speedRestGoal + "" , dc);
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
				topText("" + model.heartWorkGoal + " |Goal| " + model.heartRestGoal + "", dc);
    			largeText("Heart Rate", dc);
			}
			if (model.phase == :prep) {
    			topText("" + model.heartRestGoal + " |PREP| " + model.heartRate + "", dc);
    			largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rest) {
	    		topText("" + model.heartRestGoal + " |REST| " + model.heartRate + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	      	if (model.phase == :work) {
	    		topText("" + model.heartWorkGoal + " |GO| " + model.heartRate + "", dc);
	    		largeNumber(timerString(), dc);
	    	}
	    	if (model.phase == :rounds) {
	    		topText("" + model.heartWorkGoal + " |ROUND| " + model.heartRestGoal + "", dc);
	    		largeNumber(model.NUM_ROUNDS,dc);
	    	}
	    	if (model.phase == :lap) {
	    		topText("" + model.heartWorkGoal + " |LAP| " + model.heartRestGoal + "", dc);
	    		largeNumber(model.NUM_LAP,dc);
	    	}
	      	if (model.phase == :workHeart) {
	    		topText("" + model.heartWorkGoal + " |W HR| " + model.heartRate + "", dc);
	    		largeNumber(model.heartWorkGoal,dc);
	    	}
	    	if (model.phase == :restHeart) {
	    		topText("" + model.heartRestGoal + " |R HR| " + model.heartRate + "", dc);
	    		largeNumber(model.heartRestGoal,dc);
	    	}
	    	if (model.phase == :version){
		    	topText("" + model.heartWorkGoal + " |Work| " + model.heartRestGoal + "" , dc);
		    	largeText("Workout"+model.version,dc);
			}
			if (model.phase == :cadence){
		    	topText("" + model.cadenceWorkGoal + "|Kdence|" + model.cadenceRestGoal + "" , dc);
		    	if(model.cadenceTracking == true){
		    		largeText("Kdence Track",dc);
		    	}else if (model.cadenceTracking == false){
		    		largeText("No KdenceTrack",dc);
		    	}
			}
			if (model.phase == :buzz){
		    	topText("" + model.heartWorkGoal + " |Buzz| " + model.heartRestGoal + "" , dc);
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
 	if (model.goal == :heartRate){
	  	if (phase == :work) {
	  		if(model.heartRate < model.heartWorkGoal-model.heartWorkGoal*model.heartVar ){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
	  		} else if (model.heartRate > model.heartWorkGoal+model.heartWorkGoal*model.heartVar){
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
	  		} else { 
	  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
	  	}
	  	} else if (phase == :rest) {
		  	if(model.heartRate < model.heartRestGoal-model.heartRestGoal*model.heartVar ){
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
		  	}  else if (model.heartRate > model.heartRestGoal+model.heartRestGoal*model.heartVar){
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
		  		if(model.speed < model.speedWorkGoal-model.speedWorkGoal*model.speedVar ){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
		  		} else if (model.speed > model.speedWorkGoal+model.speedWorkGoal*model.speedVar){
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
		  		} else { 
		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
		  	}
		  	} else if (phase == :rest) {
			  	if(model.speed < model.speedRestGoal-model.speedRestGoal*model.speedVar ){
			  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
			  	}  else if (model.speed > model.speedRestGoal+model.speedRestGoal*model.speedVar){
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_RED);
		  		} else { 
		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_GREEN);
		  		}
		  	}else {
		  		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
		  	}
	  }
//	  if (model.cadenceTracking == true){
//		  if (phase == :work) {
//		  		if(model.cadence < model.cadenceWorkGoal-model.cadenceWorkGoal*model.cadenceVar ){
//		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLUE);
//		  		} else if (model.cadence > model.cadenceWorkGoal+model.cadenceWorkGoal*model.cadenceVar){
//		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_RED);
//		  		} else { 
//		  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_DK_GREEN);
//		  	}
//		  	} else if (phase == :rest) {
//			  	if(model.cadence < model.cadenceRestGoal-model.cadenceRestGoal*model.cadenceVar ){
//			  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_DK_BLUE);
//			  	}  else if (model.cadence > model.cadenceRestGoal+model.cadenceRestGoal*model.cadenceVar){
//		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_RED);
//		  		} else { 
//		  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_GREEN);
//		  		}
//		  	}else {
//		  		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
//		  }
//	  }
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
  
  function largeTextBot(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.6, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
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