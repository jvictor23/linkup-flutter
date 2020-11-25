import 'package:linkup/app/Models/usuario.dart';

abstract class ICadastrarRepository {
  Future<bool> cadastrarInvestidor(Usuario usuario);
  Future<bool> cadastrarStartup(Usuario usuario);
}
