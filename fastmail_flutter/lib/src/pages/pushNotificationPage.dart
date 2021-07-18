import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastmail_flutter/src/config/service_firestore.dart';
import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';
import 'package:flutter/material.dart';

class PushNotificationPage extends StatefulWidget {
  @override
  _PushNotificationPageState createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();

    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 62, 97, 1),
      appBar: AppBar(
        // toolbarHeight: 150, // Set this height
        backgroundColor: Color.fromRGBO(21, 41, 66, 1),
        //elevation: 0,
        //leading: Icon(Icons.menu),
        title: Text("Notifications"),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pushNotification')
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            print('object');
            return Center(
                child: Text(
              'No Notifications!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ));
          } else {
            List<PushNotification> pushes =
                snapshot.data.docs.map(_pushFromSnapshot).toList();
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, index) {
                  return Divider(
                    height: 15,
                    color: Colors.blue,
                  );
                },
                itemBuilder: (BuildContext context, index) {
                  PushNotification push = pushes[index];
                  return ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    title: Text(
                      push.title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      push.body,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                itemCount: pushes.length,
              ),
            );
          }
        },
      )),
    );
  }
}

PushNotification _pushFromSnapshot(snapshot) {
  PushNotification pusher = PushNotification(
      body: snapshot.data()["body"],
      title: snapshot.data()["title"],
      time: snapshot.data()["time"].toDate());
  return pusher;
}
