import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("next Page now"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name),
            Center(
              child: TextButton(
                child: Text("Back!"),
                onPressed: () {
                  Navigator.pop(context, "hhhhhh");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
