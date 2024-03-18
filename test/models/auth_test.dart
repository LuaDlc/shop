// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shop/models/auth.dart';

// // class Auth {
// //    register({String? email, Strin? password}) {
// //     if (email == null || email.isEmpty) {
// //       return 'O email é obrigatório';
// //     }

// //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
// //     if (!emailRegex.hasMatch(email)) {
// //       return 'O email é inválido';
// //     }

// //     return null;
// //   }
// // }

// void main() {
//   late Auth validate;

//   setUp(() {
//     //funcao setup chamda toda vez que um teste é executado e vc precisa de uma instancia de uma classe
//     validate = Auth();
//   });
//   group('validacao do email', () {
//     test('deve retornar uma mensagem caso email for null', () {
//       final result = validate.login(
//         'email',
//         'password',
//       );
//       expect(result, equals('O email é obrigatório'));
//     });

//     test('deve retornar uma mensagem caso email seja vazio', () {
//       final result = validate.login(
//         'email',
//         'password',
//       );
//       expect(result, equals('O email é obrigatório'));
//     });

//     test('deve retornar uma mensagem caso email seja invalido', () {
//       final result = validate.login('email', 'password');
//       expect(result, equals('O email é inválido'));
//     });

//     test('deve retornar null caso email seja valido', () {
//       final result = validate.login('email', 'password');
//       expect(result, isNull);
//     });
//   });

//   group(' validacao do cadastro', () {
//     // late Auth validate;
//     setUp(() {
//       //funcao setup chamda toda vez que um teste é executado e vc precisa de uma instancia de uma classe
//       validate = Auth();
//     });
//     test(' deve retornar uma mensagem para um email e senha invalidos', () {
//       final result = validate.signup('luana', '123456');
//       expect(result, isA<String>());
//     });
//   });
// }
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/models/auth.dart';

class AuthMock extends Mock implements Auth {
  bool authenticateCalled = false;
  late String authenticateEmail;
  late String authenticatePassword;
  late String authenticateMethod;

  @override
  Future<void> authenticate(
      String email, String password, String method) async {
    authenticateCalled = true;
    authenticateEmail = email;
    authenticatePassword = password;
    authenticateMethod = method;
  }
}

void main() {
  late Auth validate;

  // setUp(() {
  //   validate = Auth();
  // });

  // Existing test cases...

  // group('validacao do cadastro', () {
  //   setUp(() {
  //     validate = Auth();
  //   });

  //   test('deve retornar uma mensagem para um email e senha invalidos', () {
  //     final result = validate('luana', '123456');
  //     expect(result, isA<String>());
  //   });
  // });

  group('signup', () {
    setUp(() {
      validate = Auth();
    });

    TestWidgetsFlutterBinding.ensureInitialized();

    // Existing code...

    test('deve chamar o método authenticate com os parâmetros corretos',
        () async {
      const email = 'test@example.com';
      const password = 'password';

      await validate.signup(email, password);

      expect(validate.authenticate(email, password, ' signUp'), true);
      expect(validate.email, email);
      expect(
        validate.login(email, password),
        email,
      );
      expect(validate.login(email, password), 'signUp');
    });

    // Existing code...
  });
}
