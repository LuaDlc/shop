import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  void _submit() {}
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um email valido';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.visiblePassword,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe um senha valido';
                }
                return null;
              },
            ),
            if (_authMode == AuthMode.signup)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: _authMode == AuthMode.login
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return 'Senhas nao conferem';
                        }
                        return null;
                      },
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 8)),
                child:
                    Text(_authMode == AuthMode.login ? 'ENTRAR' : 'REGISTRAR'))
          ],
        )),
      ),
    );
  }
}
