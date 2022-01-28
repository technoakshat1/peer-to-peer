// @dart=2.9
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/PredictionParams.dart';
import '../Models/PredictionResult.dart';

class HttpMain {
  Uri uri = Uri.parse("https://house-price-pridictor.herokuapp.com/");
  //** for localhost:http://ip-address:PORT***/

  Future<PredictionResult> predict(PredictionParams params) async {
    Uri predictUri = Uri.parse(uri.origin + "/predict");
    print(params);
    Map body = {
      'CHAS': params.chas,
      'PTRATIO': params.ptratio.toString(),
      'CONF': params.conf,
      'RM': params.rooms.toString()
    };
    http.Response rawResult = await http.post(predictUri, body: body);
    var decodedResponse = json.decode(utf8.decode(rawResult.bodyBytes)) as Map;
    PredictionResult result = PredictionResult(
      prediction: double.parse(decodedResponse['prediction']),
      conf: int.parse(decodedResponse['confidence']),
      predictionHigh: double.parse(decodedResponse['prediction_high']),
      predictionLow: double.parse(decodedResponse['prediction_low']),
    );
    return result;
  }
}
