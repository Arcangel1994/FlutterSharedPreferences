import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _controller_key = TextEditingController();
  final _controller_data = TextEditingController();

  String text_to_show;

  Widget CheckText() {
    if (text_to_show != null) {
      return Text('$text_to_show');
    }
    return Text('');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preferences'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller_key,
              decoration: InputDecoration(hintText: 'Enter key'),
            ),
            TextField(
              controller: _controller_data,
              decoration: InputDecoration(hintText: 'Enter data'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Guardar Datos'),
                    onPressed: () =>
                        saveData(_controller_key.text, _controller_data.text),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Traer Datos'),
                    onPressed: () => showData(_controller_key.text),
                  ),
                ),
              ],
            ),
            CheckText(),
          ],
        ),
      ),
    );
  }

  saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);

    Fluttertoast.showToast(msg: 'Saved data!', toastLength: Toast.LENGTH_SHORT);
  }

  showData(String key) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      text_to_show = prefs.getString(key);
    });
  }
}
