import 'package:linkup/app/repositories/login_repository.dart';

class LoginController {
  LoginRepository _repository;
  LoginController() {
    _repository = LoginRepository();
  }

  Future<bool> login(String email, String senha) async {
    return await _repository.login(email, senha);
  }
}
