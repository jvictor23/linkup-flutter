import 'package:linkup/app/Models/usuario.dart';
import 'package:linkup/app/repositories/home_repository.dart';

class HomeController {
  HomeRepository _repository;
  HomeController() {
    _repository = HomeRepository();
  }

  Future<List<Usuario>> getPerfis() {
    return _repository.getPerfis();
  }
}
