import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RocketShip extends StatefulWidget {
  const RocketShip({Key? key}) : super(key: key);

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
  runApp(RocketShip());
}
