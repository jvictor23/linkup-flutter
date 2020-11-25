import 'package:linkup/app/Models/post.dart';

abstract class IHomeRepository {
  Future<List<Post>> getPerfis();
}
