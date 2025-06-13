import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RocketShip extends StatefulWidget {
  final bool initiallyPlaying;
  final GlobalKey<_RocketShipState> _stateKey = GlobalKey<_RocketShipState>();
  late RiveAnimationController _controller;
  RocketShip({Key? key, this.initiallyPlaying = false}) : super();

  /// Tracks if the animation is playing by whether controller is active
  bool get isPlaying => _stateKey.currentState?.isPlaying ?? false;

  @override
  _RocketShipState createState() => _RocketShipState();
}

class _RocketShipState extends State<RocketShip> {
  /// Controller for playback
  late RiveAnimationController _controller;

  /// Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
    _controller.isActive = widget.initiallyPlaying;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          child: RiveAnimation.network(
            'assets/animations/rocket_ship.riv',
            controllers: [_controller],
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _togglePlay,
          icon: Icon(isPlaying ? Icons.flight_land : Icons.flight_takeoff ),
          label: Text(isPlaying ? 'Land Crocket' : 'Launch Rocket'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
    //   MaterialApp(
    //   home: Scaffold(
    //       appBar: AppBar(title: Text('Rocket Animation')),
    //       body: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               width: 300,
    //               height: 300,
    //               child: RiveAnimation.network(
    //                 'assets/animations/rocket_ship.riv',
    //                 controllers: [_controller],
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             ElevatedButton.icon(
    //               onPressed: _togglePlay,
    //               icon: Icon(isPlaying ? Icons.flight_takeoff : Icons.flight_land ),
    //               label: Text(isPlaying ? 'Land Rocket' : 'Launch Rocket'),
    //               style: ElevatedButton.styleFrom(
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: 20,
    //                   vertical: 15,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    // );
  }
}



void main() {
  // Example of using the RocketShip widget with initiallyPlaying set to true
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
