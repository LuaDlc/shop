import 'package:flutter_test/flutter_test.dart';

class PasswordValidator {
  String? validate({String? password}) {
    if (password == null || password.isEmpty) {
      return 'A senha é obrigatoria';
    }

    if (password.length < 6) {
      return 'A senha deve conter 6 ou mais caracteres';
    }

    final alphaNumeric = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).+$');
    if (!alphaNumeric.hasMatch(password)) {
      return 'A senha deve ser alfanumerica';
    }

    return null;
  }
}

void main() {
  late PasswordValidator passwordValidator;

  setUp(() {
    passwordValidator = PasswordValidator();
  });
  group('validacao da senha', () {
    test('deve retornar uma mensagem de erro caso senha seja null', () {
      final result = passwordValidator.validate();
      expect(result, equals('A senha é obrigatoria'));
    });

    test('deve retornar uma mensagem de erro caso senha seja vazia', () {
      final result = passwordValidator.validate(password: '');
      expect(result, equals('A senha é obrigatoria'));
    });

    test('deve retornar uma mensagem de erro caso senha seja menor que 6', () {
      final result = passwordValidator.validate(password: '12345');
      expect(result, equals('A senha deve conter 6 ou mais caracteres'));
    });

    test('deve retornar uma mensagem de erro caso senha nao seja alfanumerica',
        () {
      final result = passwordValidator.validate(password: 'luanadi');
      expect(result, equals('A senha deve ser alfanumerica'));
    });

    test('deve retornar null caso senha nao seja valida', () {
      final result = passwordValidator.validate(password: 'luana123');
      expect(result, isNull);
    });
  });
}
