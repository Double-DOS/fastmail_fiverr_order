import 'package:fastmail_flutter/src/bloc/provider.dart' as fProvider;
import 'package:fastmail_flutter/src/config/service_firestore.dart';
import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';
import 'package:fastmail_flutter/src/pages/contactsPage.dart';
import 'package:fastmail_flutter/src/pages/gridhome.dart';
import 'package:fastmail_flutter/src/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:fastmail_flutter/src/pages/pushNotificationPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      print(message.toString());
      if (message.notification != null) {
        DatabaseService().addNotification(
          time: DateTime.now(),
          body: message.notification.body,
          title: message.notification.title,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.toString());
      if (message.notification != null) {
        DatabaseService().addNotification(
          time: DateTime.now(),
          body: message.notification.body,
          title: message.notification.title,
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(
        (message) => backgroundHandler(message));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: <Contact>[],
      value: _callListApi().asStream(),
      child: fProvider.Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FastMail Center',
          initialRoute: 'login',
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'homegrid': (BuildContext context) => GridHomePage(),
            'notifications': (BuildContext context) => PushNotificationPage(),
            'contacts': (BuildContext context) => ContactsPage()
          },
          theme: ThemeData(primaryColor: Colors.blue),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

//for when app is in background
Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    DatabaseService().addNotification(
      time: DateTime.now(),
      body: message.notification.body,
      title: message.notification.title,
    );
  }
}

Future<List<Contact>> _callListApi() async {
  var httpClient = http.Client();
  var apiUrl = Uri.parse(
      'https://almandado.com.gt/app/selectquerys_get.php?identificador=CARTERACLIENTES&idcliente=1000');
  var apiRespnse = await httpClient.get(apiUrl);

  return _parseContacts(apiRespnse.body);
}

List<Contact> _parseContacts(String responseBody) {
  var parsed = convert.json.decode(responseBody);
  List<Map<String, dynamic>> contactList =
      new List<Map<String, dynamic>>.from(parsed);
  return contactList.map((item) => Contact.fromJson(item)).toList();
}
