import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:buscapets/pages/data_base/bd_sqflite.dart';
import 'package:buscapets/widgets/custom_input_field.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController primeiroNomeController = TextEditingController();
  final TextEditingController ultimoNomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final dbHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = dbHelper();
  }

  void registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      if (senhaController.text == confirmaSenhaController.text) {
        Map<String, dynamic> usuario = {
          'primeiroNome': primeiroNomeController.text,
          'ultimoNome': ultimoNomeController.text,
          'email': emailController.text,
          'senha': senhaController.text,
        };

        await _dbHelper.salvarUsuario(usuario);
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem.')),
        );
      }
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
              color: Color(0xFF434A42),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0, ),
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                    padding: const EdgeInsets.only(left: 45, right: 45,),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 40),
                          buildInputField(
                            labelText: 'Primeiro Nome',
                            controller: primeiroNomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu primeiro nome';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          buildInputField(
                            labelText: 'Último Nome',
                            controller: ultimoNomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu último nome';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          buildInputField(
                            labelText: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Insira um email válido';
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
                              } else if (value.length < 6) {
                                return 'A senha deve ter pelo menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          buildInputField(
                            labelText: 'Confirme a Senha',
                            controller: confirmaSenhaController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, confirme sua senha';
                              } else if (value != senhaController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: registrarUsuario,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: const Color(0xFF424242),
                              ),
                              child: const Text(
                                'Cadastrar-se',
                                style: TextStyle(
                                  fontSize: 23,
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
                                text: 'Já tem uma conta?',
                                style: const TextStyle(color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: ' Entrar!',
                                    style: const TextStyle(
                                      color: Color(0xFF575757),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, '/login');
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
