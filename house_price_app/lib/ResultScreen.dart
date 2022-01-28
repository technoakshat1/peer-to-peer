//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './Bloc/PredictionCubit.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen(this.cubit);

  PredictionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
      ),
      body: BlocBuilder(
        bloc: cubit,
        builder: (ctx, state) {
          return Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Confidence: ${state['prediction'].conf}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Prediction: ${state['prediction'].prediction}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Prediction High: ${state['prediction'].predictionHigh}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Prediction Low: ${state['prediction'].predictionLow}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
