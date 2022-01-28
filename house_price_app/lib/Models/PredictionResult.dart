// @dart=2.9

import 'package:flutter/foundation.dart';

class PredictionResult {
  PredictionResult({
    @required this.prediction,
    @required this.conf,
    @required this.predictionHigh,
    @required this.predictionLow,
  });
  int conf = 0;
  double prediction;
  double predictionHigh;
  double predictionLow;

  @override
  String toString() {
    return "\nPrediction: " +
        prediction.toString() +
        "\nConfidence: " +
        conf.toString() +
        "\nPrediction_High: " +
        predictionHigh.toString() +
        "\nPrediction_Low: " +
        predictionLow.toString();
  }
}
