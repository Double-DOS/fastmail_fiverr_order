class PushNotification {
  String body;
  String title;
  DateTime time;

  PushNotification({this.body, this.title, this.time});
}

class Contact {
  String name;
  String avatarUrl;
  String id;

  Contact({this.name, this.avatarUrl, this.id});

  factory Contact.fromJson(Map<String, dynamic> parsedJson) {
    return Contact(
        id: parsedJson['id'],
        avatarUrl: parsedJson['avatar'],
        name: parsedJson['name']);
  }
}
