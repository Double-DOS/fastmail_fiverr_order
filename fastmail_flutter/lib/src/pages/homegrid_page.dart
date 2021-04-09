import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gridhome.dart';

class HomeGridPage extends StatefulWidget {
  @override
  HomeGridPageState createState() => new HomeGridPageState();
}

class HomeGridPageState extends State<HomeGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "¡Bienvenido, Antonio!",
                      // style: GoogleFonts.openSans(
                      //     textStyle: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Inicio",
                    ),
                  ],
                ),
                //  IconButton(
                //    alignment: Alignment.topCenter,
                //    icon: Image.asset(
                //       "assets/images/fastmail.png",
                //       width: 24,
                //     ),
                //     onPressed: () {},
                //   )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridHome()
        ],
      ),
    );
  }
}
