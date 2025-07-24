import 'package:flutter/material.dart';

class ChangeNotifierData with ChangeNotifier {
  double _espTemperature = 0;
  double _espHumidity = 0;
  double _espTerreHumidity = 0;
  double _reelTemperature = 0;
  double _reelHumidity = 0;
  bool _ledState = false;

  // Getters
  double get espTemperature => _espTemperature;
  double get espHumidity => _espHumidity;
  double get espTerreHumidity => _espTerreHumidity;
  double get reelTemperature => _reelTemperature;
  double get reelHumidity => _reelHumidity;
  bool get ledState => _ledState;

  set espTemperature(double value) {
    _espTemperature = value;
    notifyListeners(); 
  }

  set espHumidity(double value) {
    _espHumidity = value;
    notifyListeners(); 
  }

  set espTerreHumidity(double value) {
    _espTerreHumidity = value;
    notifyListeners(); 
  }

  set reelTemperature(double value) {
    _reelTemperature = value;
    notifyListeners(); 
  }

  set reelHumidity(double value) {
    _reelHumidity = value;
    notifyListeners(); 
  }

  set ledState(bool value) {
    _ledState = value;
    notifyListeners(); 
  }
}
