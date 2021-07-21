import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final onSelectedContact;
  ContactListTile(
      {Key key,
      @required this.contact,
      @required this.isSelected,
      @required this.onSelectedContact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = isSelected
        ? TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold)
        : TextStyle(color: Colors.white);

    return ListTile(
      onTap: () {
        onSelectedContact(contact);
      },
      title: Text(
        contact.name,
        style: textStyle,
      ),
      subtitle: Text(
        contact.id,
        style: textStyle,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(contact.avatarUrl),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              size: 26,
              color: Colors.blue[300],
            )
          : null,
    );
  }
}
