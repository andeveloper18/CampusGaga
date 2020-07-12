import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditation_app/models/User.dart';

import 'package:meditation_app/services/DatabaseService.dart';

class AuthService {

User newUser = User();
DatabaseService _databaseService = DatabaseService();


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthResult> signIn({String mEmail, String mPassword}) async {
   try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: mEmail, password: mPassword);
        FirebaseUser user = result.user;
        _databaseService.userLogged();
        if (user.isEmailVerified){ 
     return result;}
     return null;

   
   }catch(e){
     print(e.toString());
    // print(e);

     return null;
   }

  }

  Future<AuthResult> signUp({String mEmail, String mPassword ,String mUserName}) async {
     
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: mEmail, password: mPassword);
        try{
             if(result!=null){
                  FirebaseUser user = result.user;
                  newUser.userId =user.uid;
                  newUser.userName = mUserName;
                   await _databaseService.createNewUserData(newUser);
                    await user.sendEmailVerification();
                      return result;
                }
                else {
                  return null;
                }
                }catch(e){
                   print("An error occured while trying to send email verification");
                  print(e.message);
                  return null;
                }
        }
  

  

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    _databaseService.userLoggedOut();
    return _firebaseAuth.signOut();

  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

void  getForgetPassword({String mEmail}) async{
   
 await _firebaseAuth.sendPasswordResetEmail(email:mEmail );
   
}



}