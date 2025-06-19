import 'rive_player.dart';
import 'package:rive_native/rive_native.dart' as rive;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void _withArtboard(rive.Artboard artboard){}
void _withStateMachine(rive.StateMachine stateMachine){}
void _withViewModelInstance(rive.ViewModelInstance viewModelInstance){}

RivePlayer make_rive_widget({
  required String assetName,
  required artboardName,
  required stateMachineName,
  hitTestBehavior = rive.RiveHitTestBehavior.opaque,
  cursor = MouseCursor.defer,
  fit = rive.Fit.contain,
  alignment = Alignment.center,
  layoutScaleFactor = 1.0,
  withArtboard = _withArtboard,
  withStateMachine = _withStateMachine,
  withViewModelInstance = _withViewModelInstance,
  autoBind = true
}){
  return RivePlayer(
    asset: "assets/animations/${assetName}.riv",
    artboardName: artboardName,
    stateMachineName: stateMachineName,
    hitTestBehavior: hitTestBehavior,
    cursor: cursor,
    fit: fit,
    alignment: alignment,
    layoutScaleFactor: layoutScaleFactor,
    withArtboard: withArtboard,
    withStateMachine: withStateMachine,
    withViewModelInstance: withViewModelInstance,
    autoBind: true,
  );
}

// call this in the main method before creating any widgets
void initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rive.RiveNative.init();
}

