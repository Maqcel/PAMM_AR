import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';
import 'screens/opening_screen.dart';

//**
//? W funnkcji main rozpoczynamy program od zainicjalizowania połączenia
//? z naszą bazą w chmurze, biblioteka korzysta z natywnych rozwiązań stąd,
//? musimy upewnić się, ze aplikacja będzie działać poprawnie.
// */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//*
//? Tworzymy główny widget aplikacji w którym inicjujemy zastosowane w tym
//? projekcie rozwiązanie do zarządzania stanem i danymi, czyli provider.
//? Rozwiązanie opiera się na wykorzystaniu streamów danych wysyłanych z Firebase
//? odnośnie autoryzacji uzytkownika.
//*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthProvider>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR-PAMM',
        home: OpeningScreen(),
      ),
    );
  }
}
