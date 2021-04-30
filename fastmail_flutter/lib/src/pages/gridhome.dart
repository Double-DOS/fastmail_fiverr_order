//import 'package:fastmail_flutter/src/bloc/hyperlink.dart';
import 'package:fastmail_flutter/src/pages/horizontal_list_menuapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_pro/carousel_pro.dart';

class GridHomePage extends StatefulWidget {
  @override
  _GridHomePageState createState() => _GridHomePageState();
}

class _GridHomePageState extends State<GridHomePage> {
  final List<String> _listItem = [
    //'./assets/images/Cotizador.png',
    //'./assets/images/CotizadorCR.png',
    './assets/images/Cuenta.png',
    './assets/images/Tracking.png',
    './assets/images/Notify.png',
    './assets/images/Facebook.png',
    './assets/images/Whatsapp.png',
    './assets/images/Phone.png',
    //'./assets/images/MiniCarga.png',
    //'./assets/images/EnLinea.png',
  ];

  /*final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        //color: Color.fromRGBO(255, 255, 255, 0.05)),
        color: Color.fromRGBO(29, 62, 97, 1)),
  );*/

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(29, 62, 97, 1),
      appBar: AppBar(
        // toolbarHeight: 150, // Set this height
        backgroundColor: Color.fromRGBO(21, 41, 66, 1),
        //elevation: 0,
        //leading: Icon(Icons.menu),
        title: Text("Inicio"),
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(29, 62, 97, 1)),
              accountName: new Text(rcvdData['name']),
              accountEmail: new Text(rcvdData['email']),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            new ListTile(
              title: new Text('Perfil'),
              trailing: new Icon(Icons.person),
              onTap: () => Navigator.pushNamed(context, 'account'),
            ),
            new ListTile(
              title: new Text('Visítanos'),
              trailing: new Icon(Icons.mail),
              onTap: () => Navigator.pushNamed(context, 'account'),
            ),
            new ListTile(
              title: new Text('Salir'),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          // padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 245,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(20),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  color: Color.fromRGBO(21, 41, 66, 1),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _image_carousel(),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'Cotizadores',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            //backgroundColor:
                            //Color.fromRGBO(21, 41, 68, 1).withOpacity(0.2),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Cotizador_List(),
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //circulo,

                  /*Stack(
                    children: <Widget>[
                      
                      /*Container(
                        width: double.infinity,
                        height: 235,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/Recuerda2.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.4),
                                    Colors.black.withOpacity(.2),
                                  ])),
                        ),
                      ),*/
                    ],
                  ),*/
                  /*SizedBox(
                    height: 100,
                  ),*/
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _listItem
                        .map(
                          (item) => InkWell(
                              splashColor: Colors.white,
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(item),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onTap: () async {
                                if (item == "./assets/images/Cotizador.png") {
                                  Navigator.pushNamed(context, 'cotizador',
                                      arguments: {
                                        "codigo": rcvdData["codigo"],
                                        "tipocliente": rcvdData["tipocliente"]
                                      });
                                } else if (item ==
                                    "./assets/images/CotizadorCR.png") {
                                  Navigator.pushNamed(context, 'cotizadorCR');
                                } else if (item ==
                                    "./assets/images/Tracking.png") {
                                  Navigator.pushNamed(context, 'listpackages',
                                      arguments: {
                                        "codigo": rcvdData["codigo"],
                                      });
                                } else if (item ==
                                    "./assets/images/Cuenta.png") {
                                  Navigator.pushNamed(context, 'account',
                                      arguments: {
                                        "codigo": rcvdData["codigo"]
                                      });
                                } else if (item ==
                                    "./assets/images/MiniCarga.png") {
                                  Navigator.pushNamed(context, 'minicarga');
                                } else if (item ==
                                    "./assets/images/EnLinea.png") {
                                  Navigator.pushNamed(context, 'pidelinea');
                                } else if (item ==
                                    "./assets/images/Facebook.png") {
                                  if (await canLaunch(
                                      "https://www.facebook.com/fastmailgt/")) {
                                    await launch(
                                        "https://www.facebook.com/fastmailgt/");
                                  }
                                } else if (item ==
                                    "./assets/images/Whatsapp.png") {
                                  var whatsappUrl =
                                      "whatsapp://send?phone=+50242440319";
                                  await canLaunch(whatsappUrl)
                                      ? launch(whatsappUrl)
                                      : launch(
                                          "https://play.google.com/store/apps/details?id=com.whatsapp&hl=es_GT&gl=US");
                                } else if (item ==
                                    "./assets/images/Phone.png") {
                                  launch("tel:+50222464646");
                                }
                              }
                              // _onTappedCard(context, item.toString());
                              //},
                              ),
                        )
                        .toList(),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image_carousel() {
    return Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.fill,
        //borderRadius: true,
        ///borderRadius: BorderRadiusDirectional.all(20),
        //borderRadius: BorderRadius.circular(100.0),
        images: [
          AssetImage('assets/images/homecustomwall/slide1fm.png'),
          AssetImage('assets/images/homecustomwall/slide2fm.JPG'),
          AssetImage('assets/images/homecustomwall/slide3fm.JPG'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        //indicatorBgPadding: 12.0,

        //dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.lightBlue,
        //indicatorBgPadding: 5.0,

        dotBgColor: Colors.blue.withOpacity(0.2),
        borderRadius: true,
        //moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,

        /*overlayShadow: true,
        overlayShadowColors: Colors.white,
        overlayShadowSize: 0.7,*/
      ),
    );
  }

  /* void _onTappedCard(BuildContext context, String item) {
    print(item.contains("Cotizador"));
    if (item == "./assets/images/Cotizador.png") {
      Navigator.pushNamed(context, 'cotizador');
    } else if (item == "./assets/images/Cuenta.png") {
      Navigator.pushNamed(context, 'account');
    } else if (item == "./assets/images/Facebook.png") {
      Hyperlink('https://guimgonzalez.business/', 'Awesome website!');
    } else if (item == "./assets/images/Whatsapp.png") {
    } else if (item == "./assets/images/Facebook.png") {}
  }*/
}
