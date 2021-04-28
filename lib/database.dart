import 'package:project1/emergency_contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'global_value.dart';
import 'user_account.dart';
import 'message.dart';
import 'alarm.dart';

class DB {
  GlobalState _global_key = GlobalState.instance;
  static Database _db;
  // static Database _db_message;
  // static Database _db_contact;

  // make this a singleton class
  // useracount database instance
  static DB instance = DB._();
  DB._();
  // // message database instance
  // static DB instance_message = DB._message();
  // DB._message();
  // // contact database instance
  // static DB instance_contact = DB._contact();
  // DB._contact();

  //
  //
  //
  //  useraccount database functions

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initial_database();
      return _db;
    }
  }

  initial_database() async {
    // Get a location using getDatabasesPath
    var databases_path = await getDatabasesPath();
    String path = join(databases_path, 'safety_citizen.db');

    // open the database
    var db = await openDatabase(path, version: 1, onCreate: _on_create_table);
    return db;
  }

  _on_create_table(Database db, int version) async {
    await db.execute("""
        CREATE TABLE USERACCOUNT (
          ID INTEGER PRIMARY KEY,
          USERNAME TEXT, 
          PASSWORD TEXT,
          PHONE TEXT,
          EMAIL TEXT,
          NAME TEXT,
          GENDER TEXT,
          IDTYPE TEXT,
          IDNUMBER TEXT,
          IDPHOTO TEXT,
          LOGIN TEXT
        )""");
    await db.execute("""
        CREATE TABLE MESSAGE (
          ID INTEGER PRIMARY KEY,
          USERNAME TEXT,
          TITLE TEXT, 
          CONTENT TEXT
        )""");
    await db.execute("""
        CREATE TABLE EMERGENCYCONTACT (
          ID INTEGER PRIMARY KEY,
          USERNAME TEXT,
          NAME TEXT,
          PHONE TEXT, 
          RELATIONSHIP TEXT
        )""");
    await db.execute("""
        CREATE TABLE ALARM (
          ID INTEGER PRIMARY KEY,
          USERNAME TEXT,
          ALARMNAME TEXT
        )""");
    Map<String, dynamic> message1 = {
      //automatically insert ID in increament
      "USERNAME": "NULL",
      "TITLE": "House On Fire",
      "CONTENT": "Please come and help me, my house is on fire.",
    };
    Map<String, dynamic> message2 = {
      //automatically insert ID in increament
      "USERNAME": "NULL",
      "TITLE": "Emergency",
      "CONTENT":
          "I am in a danger situation. Please ask some helping hands and come to help me.",
    };
    Map<String, dynamic> alarm1 = {
      //automatically insert ID in increament
      "USERNAME": "NULL",
      "ALARMNAME": "Female Scream.mp3",
    };
    Map<String, dynamic> alarm2 = {
      //automatically insert ID in increament
      "USERNAME": "NULL",
      "ALARMNAME": "Police siren.mp3",
    };

    // do the insert and get the id of the inserted row
    await db.insert("MESSAGE", message1);
    await db.insert("MESSAGE", message2);
    await db.insert("ALARM", alarm1);
    await db.insert("ALARM", alarm2);
  }

  Future insert_useraccount(
    String username,
    String password,
    String phone_number,
    String email,
    String name,
    String gender,
    String identification_type,
    String identification_number,
    String identification_photo,
    String login,
  ) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DB.instance.db; //instance.db is getter

    List maps1 = await db.query("USERACCOUNT",
        columns: ["ID", "USERNAME", "PASSWORD"],
        where: "USERNAME = ?",
        whereArgs: [username]);

    //if account already existed in database, do nothing
    if (maps1.length > 0) {
    } else {
      // useraccount data to insert
      Map<String, dynamic> useraccount = {
        //automatically insert ID in increament
        "USERNAME": "$username",
        "PASSWORD": "$password",
        "PHONE": "$phone_number",
        "EMAIL": "$email",
        "NAME": "$name",
        "GENDER": "$gender",
        "IDTYPE": "$identification_type",
        "IDNUMBER": "$identification_number",
        "IDPHOTO": "$identification_photo",
        "LOGIN": "$login",
      };

      // do the insert and get the id of the inserted row
      int res = await db.insert("USERACCOUNT", useraccount);
      //int res display the current insert ID
      // print(res);
    }

    // show the results: print all rows in the db
    print(await db.query("USERACCOUNT"));
  }

  Future update_useraccount(
    String old_username,
    String old_password,
    // String old_phone_number,
    // String old_email,
    // String old_name,
    // String old_gender,
    // String old_identification_type,
    // String old_identification_number,
    // String old_identification_photo,
    String new_username,
    String new_password,
    String new_phone_number,
    String new_email,
    String new_name,
    String new_gender,
    String new_identification_type,
    String new_identification_number,
    String new_identification_photo,
    String new_login,
  ) async {
    Database db = await DB.instance.db;

    Map<String, dynamic> useraccount = {
      //automatically insert ID in increament
      "USERNAME": "$new_username",
      "PASSWORD": "$new_password",
      "PHONE": "$new_phone_number",
      "EMAIL": "$new_email",
      "NAME": "$new_name",
      "GENDER": "$new_gender",
      "IDTYPE": "$new_identification_type",
      "IDNUMBER": "$new_identification_number",
      "IDPHOTO": "$new_identification_photo",
      "LOGIN": "$new_login",
    };

    int res = await db.update(
      "USERACCOUNT",
      useraccount,
      where: "USERNAME = ? AND PASSWORD = ?",
      whereArgs: [old_username, old_password],
    );

    print(_global_key.password);

    if (_global_key.user_list.isNotEmpty) {
      _global_key.user_list[0]["username"] = new_username;
      _global_key.password = new_password;
      _global_key.user_list[0]["phone"] = new_phone_number;
      _global_key.user_list[0]["email"] = new_email;
      _global_key.user_list[0]["name"] = new_name;
      _global_key.user_list[0]["gender"] = new_gender;
      _global_key.user_list[0]["identification_type"] = new_identification_type;
      _global_key.user_list[0]["identification_number"] =
          new_identification_number;
      _global_key.user_list[0]["identification_photo"] =
          new_identification_photo;
    } else if (_global_key.user_list.isEmpty) {
      _global_key.user_list_local[0].username = new_username;
      _global_key.user_list_local[0].password = new_password;
      _global_key.user_list_local[0].phone_number = new_phone_number;
      _global_key.user_list_local[0].email = new_email;
      _global_key.user_list_local[0].name = new_name;
      _global_key.user_list_local[0].gender = new_gender;
      _global_key.user_list_local[0].identification_type =
          new_identification_type;
      _global_key.user_list_local[0].identification_number =
          new_identification_number;
      _global_key.user_list_local[0].identification_photo =
          new_identification_photo;
    }

    // print(user_list_local)

    print(await db.query("USERACCOUNT"));
  }

  //retrieve for local use only
  //login = 1 account will only be retreive
  Future retrieve_useraccount() async {
    Database db = await DB.instance.db; //instance.db is getter

    List maps = await db.query("USERACCOUNT",
        columns: [
          "ID",
          "USERNAME",
          "PASSWORD",
          "PHONE",
          "EMAIL",
          "NAME",
          "GENDER",
          "IDTYPE",
          "IDNUMBER",
          "IDPHOTO",
          "LOGIN",
        ],
        where: "LOGIN = ?",
        whereArgs: [1]);

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        // print(maps);
        _global_key.user_list_local.add(UserAccount.fromMap(maps[i]));
        print(_global_key.user_list_local[i].username);
        print(_global_key.user_list_local[i].password);
        print(_global_key.user_list_local[i].phone_number);
        print(_global_key.user_list_local[i].email);
        print(_global_key.user_list_local[i].name);
        print(_global_key.user_list_local[i].gender);
        print(_global_key.user_list_local[i].identification_type);
        print(_global_key.user_list_local[i].identification_number);
        print(_global_key.user_list_local[i].identification_photo);
      }
    }
  }

  //
  //
  //
  //  message database functions

  Future insert_message(String username, String title, String content) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DB.instance.db; //instance.db is getter

    // message data to insert
    Map<String, dynamic> message = {
      //automatically insert ID in increament
      "USERNAME": "$username",
      "TITLE": "$title",
      "CONTENT": "$content",
    };

    // do the insert and get the id of the inserted row
    int res = await db.insert("MESSAGE", message);
    //int res display the current insert ID
    // print(res);

    // show the results: print all rows in the db
    print(await db.query("MESSAGE"));
    retrive_message(username);
  }

  Future update_message(
      int id, String username, String title, String content) async {
    Database db = await DB.instance.db;

    Map<String, dynamic> message = {
      //automatically insert ID in increament
      "USERNAME": "$username",
      "TITLE": "$title",
      "CONTENT": "$content",
    };

    int res = await db.update(
      "MESSAGE",
      message,
      where: "ID = ? AND USERNAME = ?",
      whereArgs: [id, username],
    );

    retrive_message(username);
  }

  Future retrive_message(String username) async {
    Database db = await DB.instance.db;
    _global_key.message_list.clear();

    //convert sqflite format into UserAccount map format
    //List<Message> messages = [];
    //get all information from database
    List maps = await db.query(
      "MESSAGE",
      columns: ["ID", "TITLE", "CONTENT"],
      where: "USERNAME = ? OR USERNAME = ?",
      whereArgs: [username, "NULL"],
    );
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        _global_key.message_list.add(Message.fromMap(maps[i]));
        // print(_global_key.message_list[i].content);
      }
    }
    print(await db.query("MESSAGE"));
    print(_global_key.message_list.length);
  }

  Future delete_message(int id, String username) async {
    Database db = await DB.instance.db;
    //? is the value of whereArgs
    int res = await db.delete("MESSAGE",
        where: "ID = ? AND USERNAME = ?", whereArgs: [id, username]);
    print(await db.query("MESSAGE"));
    retrive_message(username);
  }

  //
  //
  //
  //  emergenct contact database functions

  Future insert_emergency_contact(
      String username, String name, String phone, String relationship) async {
    Database db = await DB.instance.db;

    // message data to insert
    Map<String, dynamic> emergency_contact = {
      //automatically insert ID in increament
      "USERNAME": "$username",
      "NAME": "$name",
      "PHONE": "$phone",
      "RELATIONSHIP": "$relationship",
    };

    // do the insert and get the id of the inserted row
    int res = await db.insert("EMERGENCYCONTACT", emergency_contact);
    //int res display the current insert ID
    // print(res);

    // show the results: print all rows in the db
    print(await db.query("EMERGENCYCONTACT"));
    retrive_emergency_contact(username);
  }

  Future delete_emergency_contact(
      String username, String name, String phone, String relationship) async {
    Database db = await DB.instance.db;
    //? is the value of whereArgs
    int res = await db.delete("EMERGENCYCONTACT",
        where: "USERNAME = ? AND NAME = ? AND PHONE = ? AND RELATIONSHIP = ?",
        whereArgs: [username, name, phone, relationship]);
    print(await db.query("EMERGENCYCONTACT"));
    retrive_emergency_contact(username);
  }

  Future update_emergency_contact(
      int id,
      String username,
      String old_name,
      String old_phone,
      String old_relationship,
      String new_name,
      String new_phone,
      String new_relationship) async {
    Database db = await DB.instance.db;

    Map<String, dynamic> emergency_contact = {
      "ID": "$id",
      "NAME": "$new_name",
      "PHONE": "$new_phone",
      "RELATIONSHIP": "$new_relationship",
    };

    int res = await db.update(
      "EMERGENCYCONTACT",
      emergency_contact,
      where:
          "ID = ? AND USERNAME = ? AND NAME = ? AND PHONE = ? AND RELATIONSHIP = ?",
      whereArgs: [id, username, old_name, old_phone, old_relationship],
    );
    print(await db.query("EMERGENCYCONTACT"));
    retrive_emergency_contact(username);
  }

  Future retrive_emergency_contact(String username) async {
    Database db = await DB.instance.db;
    _global_key.emergency_contact_list.clear();

    //convert sqflite format into UserAccount map format
    //List<Message> messages = [];
    //get all information from database
    List maps = await db.query(
      "EMERGENCYCONTACT",
      columns: ["ID", "NAME", "PHONE", "RELATIONSHIP"],
      where: "USERNAME = ?",
      whereArgs: [username],
    );
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        _global_key.emergency_contact_list
            .add(Emergency_Contact.fromMap(maps[i]));
        // print(_global_key.emergency_contact_list[i].name);
      }
    }
    print(await db.query("EMERGENCYCONTACT"));
  }

  //
  //
  //
  //  insert alarm database functions

  Future insert_alarm(String username, String alarm_name) async {
    Database db = await DB.instance.db;
    bool insert = true;

    Map<String, dynamic> alarm = {
      //automatically insert ID in increament
      "USERNAME": "$username",
      "ALARMNAME": "$alarm_name",
    };

    for (int i = 0; i < _global_key.alarm_list.length; i++) {
      if (_global_key.alarm_list[i].username == username &&
          _global_key.alarm_list[i].alarm_name == alarm_name) {
        print("false");
        insert = false;
      }
    }

    if (insert == true) {
      int res = await db.insert("ALARM", alarm);
      print(await db.query("ALARM"));
    }
    retrieve_alarm(username);
  }

  Future retrieve_alarm(String username) async {
    Database db = await DB.instance.db;
    _global_key.alarm_list.clear();

    List maps = await db.query(
      "ALARM",
      columns: ["USERNAME", "ALARMNAME"],
      where: "USERNAME = ? OR USERNAME = ?",
      whereArgs: [username, "NULL"],
    );

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        _global_key.alarm_list.add(Alarm.fromMap(maps[i]));
        // print(_global_key.alarm_list[i].username);
        // print(_global_key.alarm_list[i].alarm_name);
      }
    }
    print(await db.query("ALARM"));
  }

  Future delete_alarm(String username, String alarm_name) async {
    Database db = await DB.instance.db;
    int res = await db.delete("ALARM",
        where: "USERNAME = ? AND ALARMNAME = ?",
        whereArgs: [username, alarm_name]);
    print(await db.query("ALARM"));
    retrieve_alarm(username);
  }
}
