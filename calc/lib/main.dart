import 'package:calc/alert.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool validate = false;
  final campo1 = new TextEditingController();
  final campo2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(25),
          child: new Form(
            key: _key,
            autovalidate: validate,
            child: buildScreen(context),            
          ),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context){
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Campo 1'),
          maxLength: 10,
          keyboardType: TextInputType.number,
          validator: validateField,
          controller: campo1,
        ), 
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Campo 2'),
          keyboardType: TextInputType.number,
          maxLength: 10,
          validator: validateField,
          controller: campo2,
        ), 
        new RaisedButton(
          onPressed: () {calcular(context, "+"); },
          child: Text('+'),
        ),
        new RaisedButton(
          onPressed: () {calcular(context, "-"); },
          child: Text('-'),
        ),
        new RaisedButton(
          onPressed: () {calcular(context, "*"); },
          child: Text('*'),
        ),
        new RaisedButton(
          onPressed: () {calcular(context, "/"); },
          child: Text('/'),
        ),
        new RaisedButton(
          onPressed: () {Navigator.pop(context); },
          child: Text('Voltar'),
        ) 
      ],
    );
  }

  String validateField(String value){
    if (value.length == 0){
      return "Informe campo!";
    }
    return null;
  }

  void calcular(BuildContext context, String operac) {
    if (_key.currentState.validate()){
      double result = 0;
      if (operac == "+"){
        result = double.parse(campo1.text) + double.parse(campo2.text);
      } else if (operac == "-"){
        result = double.parse(campo1.text) - double.parse(campo2.text);
      } else if (operac == "*"){
        result = double.parse(campo1.text) * double.parse(campo2.text);
      } else {
        if (int.parse(campo2.text) == 0){
          new Alert().showAlertDialog(context, "Impossível dividir por 0");
          return;
        }
        result = double.parse(campo1.text) / double.parse(campo2.text);
      }
      new Alert().showAlertDialog(context, "Resultado "+result.toString());
      resetCampos();
    }
  }

  void resetCampos(){
    campo1.clear();
    campo2.clear();
  }
}
