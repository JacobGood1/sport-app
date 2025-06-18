import 'package:cljd_sport_app/dart-widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:rive_native/rive_native.dart' as rive;
import 'dart:async';
import 'rive_player.dart';

class RocketShip extends StatefulWidget {
  final bool initiallyPlaying;
  final GlobalKey<_RocketShipState> _stateKey = GlobalKey<_RocketShipState>();

  RocketShip({Key? key, this.initiallyPlaying = false}) : super(key: key);

  /// Tracks if the animation is playing by whether controller is active
  bool get isPlaying => _stateKey.currentState?.isPlaying ?? false;

  @override
  _RocketShipState createState() => _RocketShipState();
}

class _RocketShipState extends State<RocketShip> {
  /// Animation playing state
  bool _isPlaying = false;
  
  /// Tracks if the animation is playing
  bool get isPlaying => _isPlaying;

  late rive.StateMachine _state;

  late rive.Artboard _arty;
  late rive.ViewModelInstance _vmInst;
  
  /// Painter for the Rive animation

  @override
  void initState() {
    super.initState();
    _isPlaying = widget.initiallyPlaying;
    _initRive();
  }

  /// Toggles between play and pause animation states
  void _setStateMachine(rive.StateMachine state) {
    this._state = state;
  }
  void _setArtboard(rive.Artboard arty) {
    print('art');
    this._arty = arty;

  }
  void _setViewModelInstance(rive.ViewModelInstance view) {
    print('view');
    this._vmInst = view;
    this._arty.bindViewModelInstance(this._vmInst);
  }

  Future<void> _initRive() async {
    // Initialize Rive if not already initialized



  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while the animation is being loaded



    RivePlayer kek = RivePlayer(
        asset: "assets/animations/rocket-ship.riv",
        artboardName: "Artboard",
        // fit: rive.Fit.layout,
        // layoutScaleFactor: 1,
        stateMachineName: "State Machine 1",
        autoBind: true,
        withStateMachine: _setStateMachine,
        withViewModelInstance: _setViewModelInstance,
        withArtboard: _setArtboard,
        );
   

    RiveExampleApp.isRiveRender = true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 500,
          height: 500,
          child:   kek      ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            rive.TriggerInput? trig = _state.trigger('Trigger 1');
            trig?.fire();
            print(this._arty);
            //TODO hot reloading stops the animation for some reason
            // Could not find a View Model linked to Artboard Artboard.
          },
          icon: Icon(isPlaying ? Icons.flight_land : Icons.flight_takeoff),
          label: Text(isPlaying ? 'Land Rocket' : 'Launch Rocket'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
  }
}

void main() async {
  // Example of using the RocketShip widget with initiallyPlaying set to true
  WidgetsFlutterBinding.ensureInitialized();
  await rive.RiveNative.init();
  final rocketShip = RocketShip(initiallyPlaying: true);
  // Example of how to access the isPlaying property from outside
  // This would typically be used after the widget is built and the state is initialized
  Future.delayed(Duration(seconds: 1), () {
    print('Is rocket playing? ${rocketShip.isPlaying}');
  });

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Rocket Animation')),
      body: Center(child: rocketShip),
    ),
  ));
}