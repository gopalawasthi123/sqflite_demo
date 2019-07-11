import 'package:flutter/material.dart';
import 'DataBaseHelper.dart';
import 'additem.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  //List<String> _todoItems = new List();
  //var x =  DataBaseHelper.instance.queryAllRows();

  @override
  _MyHomePageState createState(){
//    _getAllValues();
    return new _MyHomePageState();
  }
}

 class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoItems = new List();

  Future _addToDOListItem() async
  {
    //Future<List<Map<String,dynamic>>> a =  DataBaseHelper.instance.queryAllRows();

    Map results =  await Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> additem()));

    if(results!=null && results.containsKey('selection')){
      setState(() {

        _todoItems.add(results['selection']);
      });
    }
//  Navigator.push(context, MaterialPageRoute(builder: (context)=> additem()));

  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),

      body: FutureBuilder<List<String>>(
        future: _getAllValues(),
          builder:(BuildContext context, AsyncSnapshot<List<String>> list){
          if(list.hasData){
            return new ListView.builder(
                itemCount: list.data.length,
                itemBuilder:(context, index){
                  return ListTile(
                    title: Text(list.data[index]),
                  );

                });
          }

          }
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: _addToDOListItem,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.


    );
  }

      Widget _buildotoList() {

        return new ListView.builder(
            itemCount: _todoItems.length,
            itemBuilder:(context, index){
              return ListTile(
                title: Text(_todoItems[index]),
              );

            });
  }
   Future<List<String>> _getAllValues() async {
     var x = await DataBaseHelper.instance.queryAllRows();
     _todoItems.clear();
     _todoItems.addAll(x);
     return _todoItems;
   }

}
