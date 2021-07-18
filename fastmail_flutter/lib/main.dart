import 'package:fastmail_flutter/src/bloc/provider.dart';
import 'package:fastmail_flutter/src/config/service_firestore.dart';
import 'package:fastmail_flutter/src/pages/contactsPage.dart';
import 'package:fastmail_flutter/src/pages/gridhome.dart';
import 'package:fastmail_flutter/src/pages/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fastmail_flutter/src/pages/pushNotificationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
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
    );
  }
}
