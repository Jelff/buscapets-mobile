import 'package:flutter/material.dart';
import 'pages/welcome_page/welcome_page.dart';
import 'pages/login_page/login_page.dart';
import 'pages/registration_page/registration_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/data_base/bd_sqflite.dart';

void main() {
  runApp(BuscapetsApp());
}

class BuscapetsApp extends StatefulWidget {
  @override
  _BuscapetsAppState createState() => _BuscapetsAppState();
}

class _BuscapetsAppState extends State<BuscapetsApp> {
  late dbHelper _dbHelper;
  bool isFirstTime = true;
  String loggedInUser = '';

  @override
  void initState() {
    super.initState();
    _dbHelper = dbHelper();
    _checkFirstTimeUser();
  }


  Future<void> _checkFirstTimeUser() async {
    var db = await _dbHelper.db;
    List<Map<String, dynamic>> result = await db.query('usuario');
    if (result.isNotEmpty) {
      setState(() {
        isFirstTime = false;
        loggedInUser = result.first['primeiroNome'];
      });
    } else {
      setState(() {
        isFirstTime = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscapets',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isFirstTime ? '/welcome' : '/home',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/home': (context) => HomePage(nomeUsuario: loggedInUser),
      },
    );
  }
}
