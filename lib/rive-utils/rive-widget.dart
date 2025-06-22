import 'rive_player.dart';
import 'package:rive_native/rive_native.dart' as rive;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void _withArtboard(rive.Artboard artboard){
  // artboard.
}
void _withStateMachine(rive.StateMachine stateMachine){
  // rive.Fit.
  // stateMachine.
}
void _withViewModelInstance(rive.ViewModelInstance viewModelInstance){
  // viewModelInstance.trigger(path).trigger()
}

RiveWidget make_rive_widget({
  required double width,
  required double height,
  required String assetName,
  required artboardName,
  required stateMachineName,
  hitTestBehavior = rive.RiveHitTestBehavior.opaque,
  cursor = MouseCursor.defer,
  fit = rive.Fit.contain,
  alignment = Alignment.center,
  layoutScaleFactor = 1.0,
  autoBind = true
}){
  return RiveWidget(
    width: width,
    height: height,
    assetName: "assets/animations/${assetName}.riv",
    artboardName: artboardName,
    stateMachineName: stateMachineName,
    hitTestBehavior: hitTestBehavior,
    cursor: cursor,
    fit: fit,
    alignment: alignment,
    layoutScaleFactor: layoutScaleFactor,
    autoBind: true,
  );
}

// call this in the main method before creating any widgets
void initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await rive.RiveNative.init();
}

class RiveWidget extends StatefulWidget {
  final String assetName;
  final String artboardName;
  final String stateMachineName;
  final rive.RiveHitTestBehavior hitTestBehavior;
  final MouseCursor cursor;
  final rive.Fit fit;
  final Alignment alignment;
  final double layoutScaleFactor;
  final bool autoBind;
  final double width;
  final double height;
  late rive.StateMachine machine;
  late rive.Artboard artboard;
  late rive.ViewModelInstance viewModelInstance;


  RiveWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.assetName,
    required this.artboardName,
    required this.stateMachineName,
    this.hitTestBehavior = rive.RiveHitTestBehavior.opaque,
    this.cursor = MouseCursor.defer,
    this.fit = rive.Fit.contain,
    this.alignment = Alignment.center,
    this.layoutScaleFactor = 1.0,
    this.autoBind = true
  }) : super(key: key);

  @override
  State<RiveWidget> createState() => _RiveWidgetState();

  void fire(String name){
    machine.trigger(name)?.fire();
  }

}

class _RiveWidgetState extends State<RiveWidget> {

  void _handleArtboard(rive.Artboard board) {
    widget.artboard = board;
  }

  void _handleStateMachine(rive.StateMachine machine) {
    widget.machine = machine;
  }

  void _handleViewModelInstance(rive.ViewModelInstance instance) {
    widget.viewModelInstance = instance;
  }

  @override
  Widget build(BuildContext context) {
    return

      Container(
        width: widget.width,
        height: widget.height,
        child:
          RivePlayer(
          asset: "assets/animations/${widget.assetName}.riv",
          artboardName: widget.artboardName,
          stateMachineName: widget.stateMachineName,
          hitTestBehavior: widget.hitTestBehavior,
          cursor: widget.cursor,
          fit: widget.fit,
          alignment: widget.alignment,
          layoutScaleFactor: widget.layoutScaleFactor,
          withArtboard: _handleArtboard,
          withStateMachine: _handleStateMachine,
          withViewModelInstance: _handleViewModelInstance,
          autoBind: widget.autoBind,
              ),
      );
  }
}