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

Stream<int> getNumbers() async* {
  for(int i = 1; i <= 4; i ++){
    yield i;
    await Future.delayed(Duration(seconds: 3));
  }
}


class MyHomePage extends StatelessWidget {
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
        child: StreamBuilder<int>(
          stream: getNumbers()
            .where((event) => event == 2 ),
          builder: (context, snapshot) {
            return Text(
              snapshot.hasData ? snapshot.data.toString() :"no Data here",
              style: TextStyle(
                fontSize: 50.0
              ),
            );
          }
        ),
      ),
    );
  }
}
