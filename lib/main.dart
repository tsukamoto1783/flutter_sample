import 'package:flutter/material.dart';
import 'package:flutter_practice/main_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Flutter App",
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
        appBar: AppBar(
          title: Text("hogehoge"),
        ),

        body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.my_text,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Btn"),
                    onPressed: (){
                    // ここでなにかの処理
                      model.change_cample_text();
                    },
                  )
                ],
              ),
            );
        }),
        ),
      ),
    );
  }
}