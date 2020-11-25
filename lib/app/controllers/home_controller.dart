import 'package:linkup/app/Models/post.dart';
import 'package:linkup/app/repositories/home_repository.dart';

class HomeController {
  HomeRepository _repository;
  HomeController() {
    _repository = HomeRepository();
  }

  Future<List<Post>> getPerfis() {
    return _repository.getPerfis();
  }
}
