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
  //List<MdlPackList> _packagess;
  StreamController<List> _streamController = StreamController<List>();
  Timer _timer;
  //Future<List<MdlPackList>> __paquetes;
  //static var _keyValidationForm = GlobalKey<FormState>();
  /*TextEditingController _textEditValor = TextEditingController();
  TextEditingController _textEditPeso = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();*/

  String _titleProgress;

  @override
  void initState() {
    super.initState();
    getDataPack();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) => getDataPack());
    //_packagess = [];
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  Future getDataPack() async {
    //var url = 'https://milk-white-reveille.000webhostapp.com/get.php';
    //http.Response response = await http.get(url);

    String url = Api.baseUrl + Api.queryselects;
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "GETLISTPACKAGES",
      "codpais": "502",
      "codigo": codigofm,
    });
    List data = json.decode(response.body);
    //Add your data to stream
    _streamController.add(data);
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  /*Future finalgetPackages() async {
    String url = Api.baseUrl + Api.queryselects;
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "GETLISTPACKAGES",
      "codpais": "502",
      "codigo": codigofm,
    });
    print('getEmployees Response: ${response.body}');
    return json.decode(response.body);
  }*/

  /*static Future<List<MdlPackList>> getPackages() async {
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
  }*/

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

  /*_getListPackages() {
    _showProgress('Cargando Paquetes...');
    getPackages().then((paquetess) {
      setState(() {
        _packagess = paquetess;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${_packagess}");
    });
  }*/

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
          child: StreamBuilder<List>(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return ListView(
                  children: [
                    for (Map document in snapshot.data)
                      ListTile(
                        title: Text(document['Articulo']),
                        subtitle: Text(document['Articulo']),
                      ),
                  ],
                );
              return Text('Loading...');
            },
          )

          /*FutureBuilder(
            future: finalgetPackages(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return ListTile(
                          title: Text(list[0]['Articulo']),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )*/
          ),
    );
  }
}
