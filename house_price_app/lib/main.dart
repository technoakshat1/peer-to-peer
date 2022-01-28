//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/PredictionCubit.dart';

import './ResultScreen.dart';
import './DefaultPageTransition.dart';
import '../Models/PredictionParams.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyHomePage(title: 'House Price Predictor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic nearToRiverVal = 'True';
  dynamic highConfidenceVal = 'False';

  int numberOfRooms = 0;
  int studentsPerTeacher = 0;

  @override
  Widget build(BuildContext context) {
    PredictionCubit cubit = PredictionCubit();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              child: const Text(
                "No. of Rooms",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            //*******************NO. OF ROOMS FORM FIELD (ROOMS IN PYTHON) *******************************//
            Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    if (value.isNotEmpty) {
                      numberOfRooms = int.parse(value);
                    }
                  })
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder()), //*BORDERED INPUT TEXT FIELD */
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Students per teacher",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            //*******************STUDENTS PER TEACHER FORM FIELD (PTRATIO IN PYTHON) *******************************//
            Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    if (value.isNotEmpty) {
                      studentsPerTeacher = int.parse(value);
                    }
                  })
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder()), //*BORDERED INPUT TEXT FIELD */
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Near to River",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            //*******************NEAR TO RIVER DROPDOWN (CHAS IN PYTHON)*****************************************//
            Container(
              margin: const EdgeInsets.all(5),
              child: DropdownButton(
                value: nearToRiverVal,
                onChanged: (dynamic n) => {
                  setState(() {
                    nearToRiverVal = n;
                  })
                },
                items: const [
                  DropdownMenuItem(
                    value: 'True',
                    child: Text("True"),
                  ),
                  DropdownMenuItem(
                    value: 'False',
                    child: Text("False"),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "High Confidence",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            //*******************HIGH CONFIDENCE (CONF IN PYTHON)*****************************************//
            Container(
              margin: const EdgeInsets.all(5),
              child: DropdownButton(
                value: highConfidenceVal,
                onChanged: (dynamic n) => {
                  setState(() {
                    highConfidenceVal = n;
                  })
                },
                items: const [
                  DropdownMenuItem(
                    value: 'True',
                    child: Text("True"),
                  ),
                  DropdownMenuItem(
                    value: 'False',
                    child: Text("False"),
                  )
                ],
              ),
            ),
            //*******************PREDICT BUTTON FOR SUBMIT*****************************************//
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              width: 200,
              child: BlocConsumer(
                bloc: cubit,
                listener: (ctx, state) {
                  if (!state['loading'] && state['prediction'] != null) {
                    DefaultPageTransition pageTransition =
                        DefaultPageTransition(ResultScreen(cubit));
                    Navigator.of(ctx).push(pageTransition.createRoute());
                  }
                },
                builder: (ctx, state) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.resolveWith(
                        (states) =>
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      PredictionParams params = PredictionParams(
                        chas: nearToRiverVal,
                        conf: highConfidenceVal,
                        rooms: numberOfRooms,
                        ptratio: studentsPerTeacher,
                      );
                      cubit.predict(params);
                    },
                    child: state['loading']
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Predict"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  } //decoration: InputDecoration(border: OutlineInputBorder()),
}
