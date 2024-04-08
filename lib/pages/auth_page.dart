import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop/components/auth_form.dart';
import 'package:shop/utils/app_routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(215, 117, 255, 0.5),
            Color.fromRGBO(255, 188, 117, 0.9)
          ])),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0), //cascade operator
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2))
                        ]),
                    child: const Text(
                      'Loja do Bug',
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Anton',
                          color: Colors.white),
                    ),
                  ),
                  const AuthForm(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                      },
                      child: const Text('Esqueci a senha')),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                          text: TextSpan(
                              text: 'Ao se cadastrar você concorda com nossos ',
                              style: const TextStyle(color: Colors.white),
                              children: [
                            TextSpan(
                                text: 'Termos de uso',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                      .pushNamed(AppRoutes
                                          .termsOfUse) //print('cliclou nos termos de uso'),
                                ),
                            const TextSpan(text: ' e '),
                            TextSpan(
                                text: 'Política de privacidade',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                      .pushNamed(AppRoutes.policyPrivacy)
                                // print('cliclou na política de privacidade'),
                                //modular ou navigator.route para pagina de politicas
                                ),
                          ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
// Exemplo usado para explicar o cascade operator
// void main() {
//   List<int> a = [1, 2, 3];
//   a.add(4);
//   a.add(5);
//   a.add(6);

//   // cascade operator!
//   a..add(7)..add(8)..add(9);

//   print(a);
// }

//productgriditem
//assets