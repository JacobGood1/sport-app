import 'rive_player.dart';
import 'package:rive_native/rive_native.dart' as rive;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

RivePlayer make_rive_widget({
  required String assetName,
  required String artboardName,
  required stateMachineName,
  hitTestBehavior = rive.RiveHitTestBehavior.opaque,
  cursor = MouseCursor.defer,
  fit = rive.Fit.contain,
  alignment = Alignment.center,
  layoutScaleFactor = 1.0,
  withArtboard,
  withStateMachine,
  withViewModelInstance,
  assetLoader,
  autoBind = true
}){
  return RivePlayer(
    asset: "assets/animations/${assetName}.riv",
    artboardName: artboardName,
    fit: rive.Fit.layout,
    layoutScaleFactor: 1,
    stateMachineName: "State Machine 1",
    autoBind: true,
    withArtboard: withArtboard,
    withStateMachine: withStateMachine,
    withViewModelInstance: withViewModelInstance,
  );
}

