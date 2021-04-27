import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';

class Cotizador_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Cotizador_Icons(
            image_location: './assets/images/Cotizador.png',
            image_caption: 'P.O. Box',
          ),
          Cotizador_Icons(
            image_location: './assets/images/CotizadorCR.png',
            image_caption: 'Courier',
          ),
          Cotizador_Icons(
            image_location: './assets/images/MiniCarga.png',
            image_caption: 'Mini Carga',
          ),
          Cotizador_Icons(
            image_location: './assets/images/EnLinea.png',
            image_caption: 'Pidelo en Linea',
          ),
          Cotizador_Icons(
            image_location: './assets/images/EnLinea.png',
            image_caption: 'Pidelo en Linea',
          )
        ],
      ),
    );
  }
}

class Cotizador_Icons extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Cotizador_Icons({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.1),
      child: InkWell(
        /*borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(45),
          bottomLeft: Radius.circular(45),
        ),*/
        onTap: () {
          if (this.image_location == "./assets/images/Cotizador.png") {
            Navigator.pushNamed(context, 'cotizador');
          } else if (this.image_location == "./assets/images/CotizadorCR.png") {
            Navigator.pushNamed(context, 'cotizadorCR');
          } else if (this.image_location == "./assets/images/Tracking.png") {
            Navigator.pushNamed(context, 'listpackages');
          } else if (this.image_location == "./assets/images/Cuenta.png") {
            Navigator.pushNamed(context, 'account');
          } else if (this.image_location == "./assets/images/MiniCarga.png") {
            Navigator.pushNamed(context, 'minicarga');
          } else if (this.image_location == "./assets/images/EnLinea.png") {
            Navigator.pushNamed(context, 'pidelinea');
          }
        },
        child: Container(
          width: 90.0,
          color: Color.fromRGBO(21, 41, 68, 1).withOpacity(0.2),
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100,
              height: 70,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: new TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )),
          ),
          //title: Image.asset('./assets/images/Cotizador.png'),
        ),
      ),
    );
  }
}
