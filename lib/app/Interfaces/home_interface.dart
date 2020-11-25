import 'package:linkup/app/Models/usuario.dart';

abstract class IHomeRepository {
  Future<List<Usuario>> getPerfis();
}
