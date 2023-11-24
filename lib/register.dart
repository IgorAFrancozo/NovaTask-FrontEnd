import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://localhost:8080/registro";

  Future save() async {
    var res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'login': user.login, 'password': user.senha}),
    );
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao registrar usuário. Tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 750,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(65, 146, 233, 1.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(1, 5))
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text("Registro",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(text: user.login),
                        onChanged: (val) {
                          user.login = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Login vazio';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                        decoration: const InputDecoration(
                            errorStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      Container(
                        height: 8,
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Senha",
                          style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: TextEditingController(text: user.senha),
                        onChanged: (val) {
                          user.senha = val;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Senha vazio';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        decoration: InputDecoration(
                            errorStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      Container(
                        height: 8,
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Já possui conta ?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 90,
                width: 90,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      save();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Color.fromRGBO(65, 146, 233, 1.0),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
