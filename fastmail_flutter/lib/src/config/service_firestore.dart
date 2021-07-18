import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';

FirebaseFirestore _store = FirebaseFirestore.instance;

class DatabaseService {
  final CollectionReference pushNotifications =
      _store.collection('pushNotification');

  PushNotification _pushFromSnapshot(snapshot) {
    PushNotification pusher = PushNotification(
        body: snapshot.data()["body"],
        title: snapshot.data()["title"],
        time: snapshot.data()["time"].toDate());
    print(pusher);
    print('git here');
    return pusher;
  }

  Stream<List<PushNotification>> get fetchPushNotifications {
    return pushNotifications
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_pushFromSnapshot));
  }

  Future addNotification({
    String body,
    String title,
    DateTime time,
  }) async {
    return await pushNotifications.doc().set({
      "body": body,
      "title": title,
      "time": time,
    });
  }
}
