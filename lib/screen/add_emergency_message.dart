import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../database.dart';
import '../global_value.dart';
import 'package:flutter_sms/flutter_sms.dart';

class Add_Emergency_Message_Screen extends StatefulWidget {
  @override
  _Add_Emergency_Message_Screen_State createState() =>
      _Add_Emergency_Message_Screen_State();
}

class _Add_Emergency_Message_Screen_State
    extends State<Add_Emergency_Message_Screen> {
  TextEditingController _title_controller = TextEditingController();
  TextEditingController _content_controller = TextEditingController();
  DB _db = DB.instance;
  GlobalState _global_key = GlobalState.instance;
  String title;
  String content;

  @override
  void dispose() {
    super.dispose();
    _global_key.message_selected_index = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_global_key.message_selected_index != null) {
      _title_controller.text =
          _global_key.message_list[_global_key.message_selected_index].title;
      // _global_key.message_list[_global_key.message_selected_id].title;
      _content_controller.text =
          _global_key.message_list[_global_key.message_selected_index].content;
      // _global_key.message_list[_global_key.message_selected_id].content;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          color: Colors.purple[50],
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Card(
                color: Colors.green[50],
                shape: Border.all(width: 0.3),
                elevation: 5,
                shadowColor: Colors.black,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _global_key.message_control_index == 0
                            ? "Add Emergency Message"
                            : "Edit Emergency Message",
                        style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    _global_key.message_control_index == 1 &&
                            _global_key.message_selected_index > 1
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          title: Text(
                                            "Do you want to delete this message?",
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    _db.delete_message(
                                                      _global_key
                                                          .message_list[_global_key
                                                              .message_selected_index]
                                                          .id,
                                                      _global_key.user_list
                                                              .isNotEmpty
                                                          ? _global_key
                                                                  .user_list[0]
                                                              ["username"]
                                                          : _global_key
                                                              .user_list_local[
                                                                  0]
                                                              .username,
                                                    );
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 27,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog();
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.orange[700],
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog();
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.orange[700],
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: TextFormField(
                        controller: _title_controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontSize: 22,
                            color: Colors.lightBlue[900],
                            fontWeight: FontWeight.bold,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.blueAccent[700],
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          // border: OutlineInputBorder(
                          //     // borderRadius: BorderRadius.circular(5),
                          //     // borderSide: BorderSide(
                          //     //   width: 2,
                          //     //   color: Colors.green,
                          //     // ),
                          //     ),
                          // errorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(5),
                          //   borderSide: BorderSide(
                          //     width: 2,
                          //     color: Colors.green,
                          //   ),
                          // ),
                          // focusedErrorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(5),
                          //   borderSide: BorderSide(
                          //     width: 2,
                          //     color: Colors.green,
                          //   ),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //  borderRadius: BorderRadius.horizontal(5),
                          //  borderSide: BorderSide(
                          //   width: 2,
                          //   color: Colors.green,
                          // ),
                          //     ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: TextFormField(
                        controller: _content_controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 30,
                        // autovalidate: true,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Please fill in name'),
                        //   // EmailValidator(
                        //   //     errorText: 'Invalid username format'),
                        // ]),
                        decoration: InputDecoration(
                          hintText: 'Please write your emergency content here',
                          errorStyle: TextStyle(
                              color: Colors.blueAccent[700],
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //0 is to add new message
            if (_global_key.message_control_index == 0) {
              _db.insert_message(
                  _global_key.user_list.isNotEmpty
                      ? _global_key.user_list[0]["username"]
                      : _global_key.user_list_local[0].username,
                  _title_controller.text,
                  _content_controller.text);
              Toast.show(
                "New Emergency Message is added",
                context,
                duration: 4,
                gravity: Toast.BOTTOM,
              );
            }
            //1 is to edit message
            else if (_global_key.message_control_index == 0) {
              _db.update_message(
                  _global_key
                      .message_list[_global_key.message_selected_index].id,
                  _global_key.user_list.isNotEmpty
                      ? _global_key.user_list[0]["username"]
                      : _global_key.user_list_local[0].username,
                  _title_controller.text,
                  _content_controller.text);
              Toast.show(
                "Emergency Message is edited",
                context,
                duration: 4,
                gravity: Toast.BOTTOM,
              );
            }

            Navigator.of(context).pop();
          },
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.check,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Dialog extends StatefulWidget {
  @override
  _Dialog_State createState() => _Dialog_State();
}

class _Dialog_State extends State<Dialog> {
  List<bool> _selected_receivers = List();
  GlobalState _global_key = GlobalState.instance;

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < _global_key.emergency_contact_list.length; i++) {
      _selected_receivers.add(false);
      // print('${i}. ${_selected[i]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
      backgroundColor: Colors.grey[100],
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "Select Call Receiver",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          itemCount: _global_key.emergency_contact_list.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selected_receivers[index] = !_selected_receivers[index];
                });
              },
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                elevation: 4,
                color: _selected_receivers[index] == true
                    ? Colors.green
                    : Colors.grey[50],
                child: Container(
                  height: 25,
                  child: Text(
                    _global_key.emergency_contact_list[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
        RaisedButton(
          onPressed: () {
            List<String> recipents = [];
            for (int i = 0; i < _selected_receivers.length; i++) {
              if (_selected_receivers[i] == true) {
                recipents
                    .add(_global_key.emergency_contact_list[i].phone_number);
              }
            }
            String message = _global_key
                .message_list[_global_key.message_selected_index].content;
            _sendSMS(message, recipents);
          },
          child: Text('Confirm'),
          elevation: 5,
        ),
      ],
    );
  }
}
