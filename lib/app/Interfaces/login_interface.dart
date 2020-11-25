abstract class ILoginRepository {
  Future<bool> login(String email, String senha);
}
