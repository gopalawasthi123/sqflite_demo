import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'DataBaseHelper.dart';

class additem extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AddItemPage();
  }

}

class AddItemPage extends State<additem>{
  final myController = TextEditingController();
  void GetTextFromInput(BuildContext context){
    setState(() {
      Navigator.of(context).pop({'selection': myController.text});
      SnackBar(content: Text(myController.text));
        Map<String,dynamic> map = {

          DataBaseHelper.columnname : myController.text,
        };

      var x = DataBaseHelper.instance.insert(map);


    });
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("AddItem"),
      ),
      body: SendResponse(myController),
      floatingActionButton: FloatingActionButton(onPressed: () => GetTextFromInput(context)),
    );
  }



}

Widget SendResponse(TextEditingController mycontroller) {
  return Center(
    child: TextField(
      controller: mycontroller,
    ),
  );
}