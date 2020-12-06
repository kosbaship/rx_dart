import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class HomeModel {
  final StreamController<int> _numbersController = StreamController<int>.broadcast();
  Stream<int> get outNumbers => _numbersController.stream;
  Sink<int> get inNumbers => _numbersController.sink;

  void dispose (){
    _numbersController.close();
  }
}



class MyHomePage extends StatelessWidget {

  final model = HomeModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RxDart',
          style: TextStyle(
            fontSize: 25.0
        ),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ReadStreamWidget(model),
          SizedBox(
            height: 20.0,
          ),
          AddStreamWidget(model)
          ],
        ),
      ),
    );
  }
}

class AddStreamWidget extends StatelessWidget {
  const AddStreamWidget(this._model);

  final HomeModel _model;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Click Me',
        style: TextStyle(
            fontSize: 48.0
        ),),
      onPressed: () {
        _model.inNumbers.add(Random().nextInt(2000));
      }
      ,);
  }
}

class ReadStreamWidget extends StatelessWidget {
  const ReadStreamWidget(this._model);

  final HomeModel _model;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _model.outNumbers,
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData ? snapshot.data.toString() :"no Data here",
        style: TextStyle(
            fontSize: 45.0
          ),
        );
      }
    );
  }
}
