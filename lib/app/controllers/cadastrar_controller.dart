import 'package:linkup/app/Models/investidor.dart';
import 'package:linkup/app/Models/startup.dart';
import 'package:linkup/app/repositories/cadastrar_repository.dart';

class CadastrarController {
  CadastrarRepository _repository;

  CadastrarController() {
    _repository = CadastrarRepository();
  }

  Future<bool> cadastrarInvestidor(Investidor investidor) async {
    return await _repository.cadastrarInvestidor(investidor);
  }

  Future<bool> cadastrarStarTup(StarTup starTup) async {
    return await _repository.cadastrarStartup(starTup);
  }
}
