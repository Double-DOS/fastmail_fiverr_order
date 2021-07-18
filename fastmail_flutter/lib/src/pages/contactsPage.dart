import 'package:fastmail_flutter/src/models/pushNotificationModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(29, 62, 97, 1),
        appBar: AppBar(
          // toolbarHeight: 150, // Set this height
          backgroundColor: Color.fromRGBO(21, 41, 66, 1),
          //elevation: 0,
          //leading: Icon(Icons.menu),
          title: Text("Contacts"),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Contact>>(
          future: _callListApi(),
          initialData: <Contact>[],
          builder: (BuildContext context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, index) {
                    return Divider(
                      height: 15,
                      color: Colors.blue,
                    );
                  },
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].avatarUrl),
                      ),
                    );
                  }),
            );
          },
        )));
  }
}

Future<List<Contact>> _callListApi() async {
  var httpClient = http.Client();
  var apiUrl = Uri.parse(
      'https://almandado.com.gt/app/selectquerys_get.php?identificador=CARTERACLIENTES&idcliente=1000');
  var apiRespnse = await httpClient.get(apiUrl);

  return parseContacts(apiRespnse.body);
}

List<Contact> parseContacts(String responseBody) {
  var parsed = convert.json.decode(responseBody);
  List<Map<String, dynamic>> contactList =
      new List<Map<String, dynamic>>.from(parsed);
  return contactList.map((item) => Contact.fromJson(item)).toList();
}
