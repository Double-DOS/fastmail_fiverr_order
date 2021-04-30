import 'package:flutter/material.dart';
import 'package:fastmail_flutter/src/models/modelPackageList.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//import 'package:fastmail_flutter/src/bloc/mybullet.dart';
String codigofm = '';

class PackagelistPage extends StatefulWidget {
  @override
  final String title = 'Listado de Paquetes';
  __PackagelistPageState createState() => __PackagelistPageState();
}

class __PackagelistPageState extends State<PackagelistPage> {
  List<MdlPackList> _packagess;
  //Future<List<MdlPackList>> __paquetes;
  //static var _keyValidationForm = GlobalKey<FormState>();
  /*TextEditingController _textEditValor = TextEditingController();
  TextEditingController _textEditPeso = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();*/

  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _packagess = [];
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  static Future<List<MdlPackList>> getPackages() async {
    try {
      print(codigofm);
      String url = Api.baseUrl + Api.queryselects;
      final response = await http.post(url, headers: <String, String>{
        "Accept": "application/json"
      }, body: {
        "identificador": "GETLISTPACKAGES",
        "codpais": "502",
        "codigo": codigofm,
      });
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        /*final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<MdlPackList> paquetes = items.map<MdlPackList>((json) {
          return MdlPackList.fromJson(json);
        }).toList();

        return paquetes;*/
        //List<MdlPackList> list = json.decode(response.body);
        List<MdlPackList> list = parseResponse(response.body);
        return list;
      } else {
        //return List<MdlPackList>();
      }
    } catch (e) {
      //return List<MdlPackList>(); // return an empty list on exception/error
    }
  }

  /*static List<MdlPackList> jsonDecode(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MdlPackList>((json) => MdlPackList.fromJson(json))
        .toList();
  }*/

  static List<MdlPackList> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MdlPackList>((json) => MdlPackList.fromJson(json))
        .toList();
  }

  _getListPackages() {
    _showProgress('Cargando Paquetes...');
    getPackages().then((paquetess) {
      setState(() {
        _packagess = paquetess;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${_packagess}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;
    codigofm = rcvdData["codigo"];
    //_getListPackages();
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 62, 97, 1),
      appBar: AppBar(
        // toolbarHeight: 150, // Set this height

        backgroundColor: Color.fromRGBO(29, 62, 97, 1),
        elevation: 0,
        //leading: Icon(Icons.menu),
        title: Text("Listado de Paquetes"),
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
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'PAQUETE',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'ESTADO',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text(
                'ORIGEN',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'FECHA',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
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

          /*const <DataRow>[
            DataRow(
              /*color: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.white;
              }),*/
              cells: <DataCell>[
                DataCell(
                  Text(
                    '2689429',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                DataCell(Text(
                  'BODY WASH  AND CREAM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
                DataCell(Text(
                  'En transito a GUA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
                DataCell(Text(
                  'JEFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
                DataCell(Text(
                  '2021-02-03 11:44:16',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
              ],
            ),
          ],*/
        ),
      ),
    );
  }
}
