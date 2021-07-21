import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';
import 'package:fastmail_flutter/src/pages/contactsTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> selectedContacts = [];

  void onSelectContact(Contact contact) {
    final isSelected = selectedContacts.contains(contact);
    setState(() {
      isSelected
          ? selectedContacts.remove(contact)
          : selectedContacts.add(contact);
    });
  }

  void submitContactList() {
    print(selectedContacts);
  }

  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = Provider.of<List<Contact>>(context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(29, 62, 97, 1),
        appBar: AppBar(
          // toolbarHeight: 150, // Set this height
          backgroundColor: Color.fromRGBO(21, 41, 66, 1),
          //elevation: 0,
          //leading: Icon(Icons.menu),
          title: Text("Contacts"),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  child: Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    separatorBuilder: (BuildContext context, index) {
                      return Divider(
                        height: 15,
                        color: Colors.blue,
                      );
                    },
                    itemBuilder: (BuildContext context, index) {
                      final isSelected =
                          selectedContacts.contains(contacts[index]);
                      return ContactListTile(
                        contact: contacts[index],
                        isSelected: isSelected,
                        onSelectedContact: onSelectContact,
                      );
                    }),
              )),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: ElevatedButton(
                  onPressed: () => submitContactList(),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: Size.fromHeight(40),
                      primary: Colors.white),
                  child: Text(
                    'Select ${selectedContacts.length} Contact(s)',
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
