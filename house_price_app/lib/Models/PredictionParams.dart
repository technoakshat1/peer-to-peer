// @dart=2.9
import 'package:flutter/foundation.dart';

class PredictionParams {
  PredictionParams({
    @required this.chas,
    @required this.conf,
    @required this.rooms,
    @required this.ptratio,
  });
  String
      chas; //** was previously bool but due to bool tostring giving un desired output that is true instead of True made string */
  String
      conf; //** was previously bool but due to bool tostring giving un desired output that is true instead of True made string */
  int rooms;
  int ptratio;
  @override
  String toString() {
    return "CONF: " + conf.toString();
  }
}
