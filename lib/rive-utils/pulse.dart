import 'dart:async' as async;
import 'package:rive_native/rive_native.dart';

void trigger(StateMachine sm, String name){
  sm.trigger(name)?.fire();
}

async.Timer repeat_until_timeout({
  required Function fnToRepeat,
  required int intervalMs,
  required int durationMs}){
  var startTime = DateTime.now().millisecond;
  return async.Timer.periodic(Duration(milliseconds: intervalMs), (timer){
    var elapsedTime = DateTime.now().millisecond - startTime;
    if(elapsedTime >= durationMs) {
      timer.cancel();
    }
    fnToRepeat();
  });
}

async.Timer repeat_forever({
  required Function fnToRepeat,
  required int intervalMs}){
  return async.Timer.periodic(Duration(milliseconds: intervalMs), (timer){
    fnToRepeat();
  });
}

class CallPeriodicallyResumable{
  late async.Timer timer;
  int intervalMs;
  int durationMs = 0;
  Function fnToRepeat;
  CallPeriodicallyResumable({required this.fnToRepeat, required this.intervalMs}){
    timer = repeat_forever(fnToRepeat: fnToRepeat, intervalMs: intervalMs);
  }
  CallPeriodicallyResumable.repeatUntilTimeout({required this.fnToRepeat, required this.intervalMs}){
    timer = repeat_until_timeout(fnToRepeat: fnToRepeat, intervalMs: intervalMs, durationMs: durationMs);
  }
  pause(){
    timer.cancel();
  }
  resume(){
    if(durationMs == 0){
      timer = repeat_forever(fnToRepeat: fnToRepeat, intervalMs: intervalMs);
    } else{
      timer = repeat_until_timeout(fnToRepeat: fnToRepeat, intervalMs: intervalMs, durationMs: durationMs);
    }
  }
  replaceFn(Function f){
    this.pause();
    this.fnToRepeat = f;
    this.resume();
  }
  replaceInterval(int newIntervalMs){
    this.pause();
    this.intervalMs = newIntervalMs;
    this.resume();
  }
  replaceDuration(int newDurationMs){
    this.pause();
    this.durationMs = newDurationMs;
    this.resume();
  }
  replaceAll(Function f, int newIntervalMs, int newDurationMs){
    this.pause();
    this.fnToRepeat = f;
    this.intervalMs = newIntervalMs;
    this.durationMs = newDurationMs;
    this.resume();
  }
}

main(){
  // CallPeriodicallyResumable(fnToRepeat: (){}, intervalMs: 100).replaceAll(f, newIntervalMs, newDurationMs)
}
