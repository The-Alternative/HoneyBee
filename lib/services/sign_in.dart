import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();




Future<String> signInWithGoogle() async {
  // FirebaseAuth _auth =await FirebaseAuth.instance;
  print('$_auth/////////////////***************');
  print('${googleSignIn.currentUser}***************');
  print('1');
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  print('2//$googleSignInAccount');
  if(!(googleSignInAccount == null)){
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    print('3//$googleSignInAuthentication');
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print('4//$credential');

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    print('5//$authResult');
    final User user = authResult.user;
    print('6//$user');

    assert(!user.isAnonymous);
    print('7//$user');
    assert(await user.getIdToken() != null);
    print('8//$user');

    final User currentUser = await _auth.currentUser;
    print('9//$currentUser');
    assert(user.uid == currentUser.uid);
    print('10//$user');
    print('signInWithGoogle succeeded: $user');

    return 'signInWithGoogle succeeded: $user';
  }else{
    return "false";
  }



}




void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out: ");
}