import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateTestPage extends StatefulWidget {
  StateTestPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _StateTestPageState createState() => _StateTestPageState();
}

class _StateTestPageState extends State<StateTestPage> {
  int _counter = 0;

  void _incrementCounter() {
    // setStateで変数を上書きし、再ビルドする
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 親Widgetから渡された変数にアクセスする
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SampleStatelessClass(
              text: 'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SampleStatelessClass extends StatelessWidget {
  final String text;

  SampleStatelessClass({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(text),
      ),
    );
  }
}
