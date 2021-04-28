import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:project1/global_value.dart';
import 'package:easy_localization/easy_localization.dart';

class Location_Screen extends StatefulWidget {
  @override
  _Location_Screen_State createState() => _Location_Screen_State();
}

class _Location_Screen_State extends State<Location_Screen> {
  GlobalState _global_key = GlobalState.instance;

  String _latitude = null;
  String _longitude = null;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(6.4676929, 100.5067673);
  LatLng _lastMapPosition = _center;
  Set<Marker> _markers = {};
  //MapType _currentMapType = MapType.normal;
  var _addressLine;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() async {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "$_lastMapPosition",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        draggable: true,
      ));
      _latitude = _lastMapPosition.latitude.toStringAsFixed(6);
      _longitude = _lastMapPosition.longitude.toStringAsFixed(6);
      _getUserLocation();
    });
  }

  //translate latitude and longitude into address
  _getUserLocation() async {
    _markers.forEach((value) async {
      final coordinates =
          Coordinates(value.position.latitude, value.position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var address = addresses.first;
      _addressLine = address.addressLine;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onAddMarkerButtonPressed();
  }

  void _show_usermanual() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "User Manual",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_instant_message();
                },
                child: Text(
                  "instant_message".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_instant_call();
                },
                child: Text(
                  "instant_call".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_scream_alarm();
                },
                child: Text(
                  "scream_alarm".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_location();
                },
                child: Text(
                  "location".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_account();
                },
                child: Text(
                  "account".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_instant_message() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("instant_message".tr().toString()),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "instant_message_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("send_emergency_message".tr().toString()),
            Text("send_emergency_message1".tr().toString()),
            Text("send_emergency_message2".tr().toString()),
            Text("send_emergency_message3".tr().toString()),
            Text("send_emergency_message4".tr().toString()),
            Text("add_emergency_message".tr().toString()),
            Text("add_emergency_message1".tr().toString()),
            Text("add_emergency_message2".tr().toString()),
            Text("add_emergency_message3".tr().toString()),
            Text("add_emergency_message4".tr().toString()),
            Text("edit_emergency_message".tr().toString()),
            Text("edit_emergency_message1".tr().toString()),
            Text("edit_emergency_message2".tr().toString()),
            Text("edit_emergency_message3".tr().toString()),
            Text("delete_emergency_message".tr().toString()),
            Text("delete_emergency_message1".tr().toString()),
            Text("delete_emergency_message2".tr().toString()),
            Text("delete_emergency_message3".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_instant_call() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Instant Call"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "instant_call_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("make_instant_call".tr().toString()),
            Text("make_instant_call1".tr().toString()),
            Text("make_instant_call2".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_scream_alarm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Scream Alarm"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "scream_alarm_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("make_scream_alarm".tr().toString()),
            Text("make_scream_alarm1".tr().toString()),
            Text("make_scream_alarm2".tr().toString()),
            Text("add_scream_alarm".tr().toString()),
            Text("add_scream_alarm1".tr().toString()),
            Text("add_scream_alarm2".tr().toString()),
            Text("delete_scream_alarm".tr().toString()),
            Text("delete_scream_alarm1".tr().toString()),
            Text("delete_scream_alarm2".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_location() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Location"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("Description:"),
            Text(
              "Location allows citizen to share live location with friends and family members when citizen wants to have safety control or during emergency.",
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("Functions: "),
            Text("1. View Location of yourself"),
            Text("- Move to Location Screen"),
            Text("- View the address and map\n"),
            Text("2. Share Live Location"),
            Text("- Move to Location Screen"),
            Text("- Press Share Live Location Button"),
            Text("- Select Sharing Targets"),
            Text("- Press Share Button"),
            Text("- Enter 123 and press Yes Button\n"),
            Text("3. View Live Location of freinds or family members"),
            Text("- Move to Location Screen"),
            Text("- Press View Live Location of Others Button"),
            Text("- View the address and map"),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_account() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Account"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "account_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("edit_personal_information".tr().toString()),
            Text("edit_personal_information1".tr().toString()),
            Text("edit_personal_information2".tr().toString()),
            Text("edit_personal_information3".tr().toString()),
            Text("edit_personal_information4".tr().toString()),
            Text("edit_emergency_contact_information".tr().toString()),
            Text("edit_emergency_contact_information1".tr().toString()),
            Text("edit_emergency_contact_information2".tr().toString()),
            Text("edit_emergency_contact_information3".tr().toString()),
            Text("edit_emergency_contact_information4".tr().toString()),
            Text("add_emergency_contact_information".tr().toString()),
            Text("add_emergency_contact_information1".tr().toString()),
            Text("add_emergency_contact_information2".tr().toString()),
            Text("add_emergency_contact_information3".tr().toString()),
            Text("add_emergency_contact_information4".tr().toString()),
            Text("delete_emergency_contact_information".tr().toString()),
            Text("delete_emergency_contact_information1".tr().toString()),
            Text("delete_emergency_contact_information2".tr().toString()),
            Text("delete_emergency_contact_information3".tr().toString()),
            Text("backup_information".tr().toString()),
            Text("backup_information1".tr().toString()),
            Text("backup_information2".tr().toString()),
            Text("backup_information3".tr().toString()),
            Text("log_out_account".tr().toString()),
            Text("log_out_account1".tr().toString()),
            Text("log_out_account2".tr().toString()),
            Text("log_out_account3".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_share_location_target() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Select Share Target",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 2",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 3",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 4",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_view_location_target() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Select View Target",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 2",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 3",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {},
                child: Text(
                  "Emergency Contact 4",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 20,
          shadowColor: Colors.green[900],
          backgroundColor: Colors.green[400],
          leading: GestureDetector(
            onTap: _show_usermanual,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.help_outline,
                size: 40,
                color: Colors.indigo[900],
                // indigoAccent[700]
              ),
            ),
          ),
          //title: Text('Material App Bar'),
        ),
        body: Container(
          height: _screen_height,
          color: Colors.green[50].withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                //         width: (_screen_width / 2) - 20,
                //         child: Column(
                //           children: [
                //             Container(
                //               height: 30,
                //               color: Colors.deepPurple,
                //               child: Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   "Latitude",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               height: 40,
                //               color: Colors.deepPurple[400],
                //               child: Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   "${_lastMapPosition.latitude.toStringAsFixed(6)}",
                //                   style: TextStyle(
                //                     fontSize: 17,
                //                     fontWeight: FontWeight.w400,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Container(
                //         margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //         width: (_screen_width / 2) - 20,
                //         child: Column(
                //           children: [
                //             Container(
                //               height: 30,
                //               color: Colors.deepPurple,
                //               child: Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   "Longitude",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               height: 40,
                //               color: Colors.deepPurple[400],
                //               child: Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   "${_lastMapPosition.longitude.toStringAsFixed(6)}",
                //                   style: TextStyle(
                //                     fontSize: 17,
                //                     fontWeight: FontWeight.w400,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Card(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  elevation: 13,
                  shape: Border.all(width: 0.2),
                  shadowColor: Colors.yellow[900],
                  color: Colors.yellow[50],
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // height: 70,
                          // width: _screen_width - 130,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Text(
                            _addressLine == null
                                ? 'Please press Location Button to refresh address'
                                : '${_addressLine}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
                  elevation: 10,
                  shape: Border.all(width: 0.4),
                  shadowColor: Colors.black,
                  color: Colors.blue[50],
                  child: Container(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: _screen_height / 1.9,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 17.0,
                              ),
                              mapType: MapType.normal,
                              markers: _markers,
                              onCameraMove: _onCameraMove,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                            child: FloatingActionButton(
                              onPressed: _show_share_location_target,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              backgroundColor: Colors.blueGrey[700],
                              child: const Icon(
                                Icons.screen_share,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(0, 75, 10, 0),
                        //     child: FloatingActionButton(
                        //       onPressed: null,
                        //       materialTapTargetSize:
                        //           MaterialTapTargetSize.padded,
                        //       backgroundColor: Colors.blueGrey[700],
                        //       child: const Icon(
                        //         Icons.screen_share,
                        //         size: 30.0,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: RaisedButton(
                      color: Colors.green[800],
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _show_view_location_target();
                      },
                      child: Text(
                        "View Others Location",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(vertical: BorderSide(width: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.green[600].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, -5), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              _build_bottom_navigation_bar_item(
                index: 0,
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _build_bottom_navigation_bar_item(
                index: 1,
                icon: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.indigo[900], fontWeight: FontWeight.bold),
                ),
              ),
              _build_bottom_navigation_bar_item(
                index: 2,
                icon: Icon(
                  Icons.person_pin,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // _build_bottom_navigation_bar_item(
              //   index: 3,
              //   icon: Icon(
              //     Icons.person_pin,
              //     size: 30,
              //   ),
              //   title: "Account",
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //customised bottom navigation bar item
  Widget _build_bottom_navigation_bar_item({int index, Icon icon, Text title}) {
    return GestureDetector(
      onTap: () => setState(
        () {
          _global_key.navigation_bar_index = index;
          //print(index); //check index
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
          } else if (index == 1) {
            setState(() {
              _onAddMarkerButtonPressed();
            });
          } else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
        },
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
        decoration: BoxDecoration(
          gradient: _global_key.navigation_bar_index == index
              ? LinearGradient(
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                    // Colors.indigo[900].withOpacity(1),
                    // Colors.indigo[900].withOpacity(1),
                  ],
                  // begin: Alignment.bottomCenter,
                  // end: Alignment.topCenter,
                ),
        ),
        child: Column(
          children: [
            icon,
            title,
          ],
        ),
      ),
    );
  }
}
