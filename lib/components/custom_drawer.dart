import 'package:flutter/material.dart';
import 'package:new_ar/provider/auth_provider.dart';
import 'package:new_ar/screens/ar_url_screen.dart';
import 'package:new_ar/screens/opening_screen.dart';
import 'package:provider/provider.dart';

//**
//? Menu boczne odpowiedzialne za przejście do ekranu w którym mozemy sprawdzic
//? obraz z wlasnego urla, oraz mamy mozliwość wylogowania się z aplikacji.
// */

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('My place!'),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ArFromUrlScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.map_outlined,
              color: Colors.black,
              size: 35,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('Log out'),
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OpeningScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
