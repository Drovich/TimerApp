using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class TimerTestApp extends App.AppBase {

  var model;

  function initialize() {
    AppBase.initialize();
  }

  function getInitialView() {
  	model = new Model();
    return [ new TimerTestView(model), new TimerTestDelegate(model) ];
  }

  function onStop() {
    if (model.session.isRecording()) {
      var result = model.session.stop() && model.session.discard();
    }
  }

}