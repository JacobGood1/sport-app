import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

mixin RiveWidgetData {
  Artboard? _artboard;
  Artboard? get artboard => _artboard;
  set artboard(Artboard? artb) => _artboard = artb;
  // double get right => left + width;
  // set right(double value) => left = value - width;
}