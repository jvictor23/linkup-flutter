import 'package:linkup/app/Models/usuario.dart';
import 'package:linkup/app/repositories/cadastrar_repository.dart';

class CadastrarController {
  CadastrarRepository _repository;

  CadastrarController() {
    _repository = CadastrarRepository();
  }

  Future<bool> cadastrarInvestidor(Usuario usuario) async {
    return await _repository.cadastrarInvestidor(usuario);
  }

  Future<bool> cadastrarStarTup(Usuario usuario) async {
    return await _repository.cadastrarStartup(usuario);
  }
}
