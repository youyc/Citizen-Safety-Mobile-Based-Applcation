import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project1/global_value.dart';
import 'package:quick_actions/quick_actions.dart';
import '../database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Language_Selection_Screen extends StatefulWidget {
  @override
  _Language_Selection_ScreenState createState() =>
      _Language_Selection_ScreenState();
}

class _Language_Selection_ScreenState extends State<Language_Selection_Screen> {
  GlobalState _global_key = GlobalState.instance;
  DB _db = DB.instance;
  final QuickActions _quickActions = QuickActions();
  String _username;
  String _password;

  Directory _directory;

  void _get_storage_directory() async {
    _directory = await getExternalStorageDirectory();
    print(_directory.path);
    String newPath = "";
    List<String> folders = _directory.path.split("/");
    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    //safety001 for image
    newPath = newPath + "/safety001";
    _directory = Directory(newPath);
    _global_key.directory = _directory;
    print(_directory.path);
  }

  void _set_language(String language_code, String country_code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Text(
              'Do you confirm want to use this language in this application?'),
          actions: [
            FlatButton(
              onPressed: () {
                //_global_value.language = language_code;
                //print(_global_value.language);
                setState(() {
                  EasyLocalization.of(context).locale =
                      Locale(language_code, country_code);
                });
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed("/LoginAccountScreen");
              },
              child: Text('Confirm'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_storage_directory();
    _db.retrieve_useraccount();

    Future.delayed(
      Duration(seconds: 2),
      () {
        if (_global_key.user_list_local.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed("/HomeScreen");
          _global_key.language_index = 0;
          // print(_global_key.user_list_local[0].identification_photo);
        }
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      _quickActions.initialize(
        (String shortcut) {
          print(shortcut);
          if (shortcut != null && _global_key.user_list_local.isNotEmpty) {
            if (shortcut == 'Emergency Message') {
              _global_key.navigation_bar_index = 0;
              _global_key.quick_action_index = 0;
              print(shortcut);
              Navigator.of(context).pushReplacementNamed("/HomeScreen");
            } else if (shortcut == 'Live Location') {
              _global_key.navigation_bar_index = 1;
              _global_key.quick_action_index = 1;
              Navigator.of(context).pushReplacementNamed("/LocationScreen");
            } else if (shortcut == 'Scream Alarm') {
              _global_key.navigation_bar_index = 0;
              _global_key.quick_action_index = 2;
              Navigator.of(context).pushReplacementNamed("/HomeScreen");
            }
          }
        },
      );
    });

    _quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'Live Location',
        localizedTitle: 'Live Location',
      ),
      ShortcutItem(
        type: 'Emergency Message',
        localizedTitle: 'Emergency Message',
      ),
      ShortcutItem(
        type: 'Scream Alarm',
        localizedTitle: 'Scream Alarm',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Card(
            elevation: 20,
            shape: Border.all(width: 0.3),
            shadowColor: Colors.deepOrange,
            color: Colors.yellow[50],
            child: Container(
              height: 300,
              width: 300,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
                      child: Text(
                        'Select the language you want to use in the application',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      elevation: 5,
                      color: Colors.orangeAccent[100],
                      minWidth: 120,
                      onPressed: () {
                        String language_code = 'en';
                        String country_code = 'US';
                        _set_language(language_code, country_code);
                        _global_key.language_index = 0;
                      },
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    MaterialButton(
                      elevation: 5,
                      color: Colors.orangeAccent[100],
                      minWidth: 120,
                      onPressed: () {
                        String language_code = 'ms';
                        String country_code = 'MY';
                        _set_language(language_code, country_code);
                        _global_key.language_index = 1;
                      },
                      child: Text(
                        "Malay",
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        'Language can be changed afterward in the application',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
