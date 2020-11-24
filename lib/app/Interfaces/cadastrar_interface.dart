import 'package:linkup/app/Models/investidor.dart';
import 'package:linkup/app/Models/startup.dart';

abstract class ICadastrarRepository {
  Future<bool> cadastrarInvestidor(Investidor investidor);
  Future<bool> cadastrarStartup(StarTup starTup);
}
