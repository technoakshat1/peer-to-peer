//@dart=2.9
import 'package:bloc/bloc.dart';
import '../API/HttpMain.dart';
import '../Models/PredictionParams.dart';
import '../Models/PredictionResult.dart';

class PredictionCubit extends Cubit<dynamic> {
  PredictionCubit() : super({'loading': false, 'prediction': null});

  void predict(PredictionParams params) async {
    emit({"loading": true});
    PredictionResult result = await HttpMain().predict(params);
    emit({"loading": false, "prediction": result});
  }
}
