import 'dart:convert';

//import 'package:dept_emp_data/Models/employeedata.dart';
import 'package:fastmail_flutter/src/models/modelPackageList.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PackagelistPage extends StatefulWidget {
  @override
  __PackagelistPageState createState() => __PackagelistPageState();
}

class __PackagelistPageState extends State<PackagelistPage> {
  List<MdlPackList> emprecord = [];

  Future<List<MdlPackList>> _getdeptemp() async {
    String url = Api.baseUrl + Api.queryselects;
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "GETLISTPACKAGES",
      "codpais": "502",
      "codigo": "53808",
    });
    if (response.statusCode == 200) {
      List paresd = jsonDecode(response.body);
      return paresd.map((emp) => MdlPackList.fromJson(emp)).toList();
    }
  }

  @override
  void initState() {
    _getdeptemp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //fromRGBO(114, 172, 188, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mis Paquetes"),
        backgroundColor: Color.fromRGBO(29, 62, 97, 1),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Color.fromRGBO(71, 121, 175, 1),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Id. Envío",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text("Descripción",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(
                      child: Text("Estado \n Paquete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(
                      child: Text("Origen",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(
                      child: Text("Fecha ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder(
                    future: _getdeptemp(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].tracking}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].descpaquete}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].estadoPack}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].origenPack}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].fechaUpdStatePack}",
                                      textAlign: TextAlign.center,
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
