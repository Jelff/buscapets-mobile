import 'package:flutter/material.dart';
import 'package:buscapets/pages/data_base/bd_sqflite.dart';
import 'package:flutter/gestures.dart';
import 'package:buscapets/widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  late final dbHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = dbHelper();
  }

  void login() async {
    String email = emailController.text;
    String senha = senhaController.text;

    var usuario = await _dbHelper.loginUsuario(email, senha);
    if (usuario != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login falhou, tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF9DC247),
            ),
          ),
          Positioned(
            top: 4,
            left: 10,
            child: Image.asset(
              'assets/images/dogo.png',
              width: MediaQuery.of(context).size.width * 1.2,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 250),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 40),
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF575757),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        buildInputField(
                          labelText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        buildInputField(
                          labelText: 'Senha',
                          controller: senhaController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF424242),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: login,
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Não tem uma conta?',
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: ' Cadastre-se',
                                  style: const TextStyle(
                                    color: Color(0xFF575757),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
