abstract class AuthBase {

  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<bool> forgotPassword(String email);
  Future<bool> sendEmailVerification();
  Future<bool> checkEmailVerification();
  Future<void> currentUser();
  Future<bool> isLoggedUser();
  Future<bool> signOut();

}