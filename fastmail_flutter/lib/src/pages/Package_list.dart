import 'package:flutter/material.dart';
import 'package:fastmail_flutter/src/models/modelPackageList.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//import 'package:fastmail_flutter/src/bloc/mybullet.dart';

class PackagelistPage extends StatefulWidget {
  @override
  final String title = 'Listado de Paquetes';
  __PackagelistPageState createState() => __PackagelistPageState();
}

class __PackagelistPageState extends State<PackagelistPage> {
  List<MdlPackList> _packagess;
  //static var _keyValidationForm = GlobalKey<FormState>();
  /*TextEditingController _textEditValor = TextEditingController();
  TextEditingController _textEditPeso = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();*/

  String _titleProgress;

  @override
  void initState() {
    _packagess = [];
    _getListPackages();
    super.initState();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  static Future<List<MdlPackList>> getPackages() async {
    try {
      String url = Api.baseUrl + Api.queryselects;
      final response = await http.post(url, headers: <String, String>{
        "Accept": "application/json"
      }, body: {
        "identificador": "GETLISTPACKAGES",
        "codpais": "502",
        "codigo": "53808",
      });
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<MdlPackList> list = parseResponse(response.body);
        return list;
      } else {
        return List<MdlPackList>();
      }
    } catch (e) {
      return List<MdlPackList>(); // return an empty list on exception/error
    }
  }

  static List<MdlPackList> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MdlPackList>((json) => MdlPackList.fromJson(json))
        .toList();
  }

  _getListPackages() {
    _showProgress('Cargando Paquetes...');
    getPackages().then((employees) {
      setState(() {
        _packagess = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        // toolbarHeight: 150, // Set this height

        backgroundColor: Colors.blue[900],
        elevation: 0,
        //leading: Icon(Icons.menu),
        title: Text("Listado Paquetes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Column(
              children: <Widget>[
                // getWidgetImageLogo(),
                _dataBody(),
                //getWidgetPriceCard(),
              ],
            )),
      ),
    );
  }

  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'TRACKING',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'PAQUETE',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'ESTADO',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text(
                'ORIGEN',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'FECHA',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          rows: _packagess
              .map(
                (paquetesmdl) => DataRow(cells: [
                  DataCell(
                    Text(paquetesmdl.tracking),
                    onTap: () {
                      /* _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedCCliente = employee;
                      setState(() {
                        _isUpdating = true;
                      });*/
                    },
                  ),
                  DataCell(
                    Text(
                      paquetesmdl.descpaquete.toUpperCase(),
                    ),
                    onTap: () {
                      /*_showValues(employee);
                      // Set the Selected employee to Update
                      _selectedCCliente = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });*/
                    },
                  ),
                  DataCell(
                    Text(
                      paquetesmdl.estadoPack.toUpperCase(),
                    ),
                    onTap: () {
                      /*_showValues(employee);
                      // Set the Selected employee to Update
                      _selectedCCliente = employee;
                      setState(() {
                        _isUpdating = true;
                      });*/
                    },
                  ),
                  DataCell(
                    Text(
                      paquetesmdl.origenPack.toUpperCase(),
                    ),
                    onTap: () {
                      /*_showValues(employee);
                      // Set the Selected employee to Update
                      _selectedCCliente = employee;
                      setState(() {
                        _isUpdating = true;
                      });*/
                    },
                  ),
                  DataCell(
                    Text(
                      paquetesmdl.fechaUpdStatePack.toUpperCase(),
                    ),
                    onTap: () {
                      /*_showValues(employee);
                      // Set the Selected employee to Update
                      _selectedCCliente = employee;
                      setState(() {
                        _isUpdating = true;
                      });*/
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.upload_file),
                    onPressed: () {
                      //_deleteEmployee(employee);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  /* Widget getWidgetRegistrationCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Cotizar',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Cotiza el envío de documentos y/o paquetes a cualquier parte del mundo bajo la modalidad de urgente o normal.',
                    style: TextStyle(fontSize: 11.0, color: Colors.blue),
                  ),
                ),
                _crearTipo(),
                _crearEnvioNormalUrgente(),
                _crearDestinoEnvio(),
                //_crearValor(),
                _crearPeso(),
                //_crearDestino(),

                //getDestino(),
                _botonCalcular()
              ],
            ),
          ),
        ),
      ),
    );
  }*/
}
