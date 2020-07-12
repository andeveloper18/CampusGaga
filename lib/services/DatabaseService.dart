import 'package:cloud_firestore/cloud_firestore.dart';
//Class to handle all the database queries and function frome one side.
import 'package:meditation_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DatabaseService {

    final _firestore = Firestore.instance;

                getSubjects() async{

                 await  _firestore.collection('quizzes').getDocuments().then((QuerySnapshot snapshot){

                    snapshot.documents.forEach((docs)=>print(docs.data));

    

                 }).catchError((e)=>print(e.toString()));
                  
            }
   

      getQuestions() async{
       await  _firestore.collection('quizzes')
       .document('G2wv7hFUkGYi1fmCYg3t')
       .collection('QNA')
       .getDocuments().then((QuerySnapshot snapshot){

        snapshot.documents.forEach((docs)=>print(docs.data));

    

                 }).catchError((e)=>print(e.toString()));              
      }

     Stream<QuerySnapshot> getTopics(String subjectName){
          var streamOfData=  _firestore
                                .collection('subjetcs')
                                .document('$subjectName')
                                .collection('topics')
                                .snapshots();
            return streamOfData;
      }
        Stream<QuerySnapshot> getTopicsBySubjectName(String subjectName){
          var streamOfData=  _firestore
                                .collection('subjetcs')
                                .document('$subjectName')
                                .collection('topics')
                                .snapshots();
            return streamOfData;
      }


        Stream<QuerySnapshot> getQuestionsBySubjectNameAndTopicName(String subjectName,String topicName){
          var streamOfData=  _firestore
                                .collection('subjetcs')
                                .document('$subjectName')
                                .collection('topics').document('$topicName').collection('QNA')
                                .snapshots();
            return streamOfData;
      }

        Stream<QuerySnapshot> getTodayChallenge(){
          var streamOfData=  _firestore
                                .collection('today').limit(20)
                                .snapshots();
            return streamOfData;
      }



      //to create a new user data in the collection 'users'
     Future createNewUserData(User newUser) async{

      final userResult = await _firestore.collection('users').add({
              'userID': newUser.userId,
              'userName':newUser.userName
           });
      return userResult;

      }
        Future <String>  getUserNameLocal() async{
      	final SharedPreferences prefs = await SharedPreferences.getInstance();
          return prefs.getString('userName')??'Smart';

    }

       Future<bool> setUserName(String userName) async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	return prefs.setString('userName',userName);
  }
  
       Future<void> userLogged() async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	final userLogged = prefs.setBool('islogged',true);
  }
   Future<void> userLoggedOut() async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	final userLoggedOut = prefs.setBool('islogged',false);
  }

  Future<bool> userLogStatus() async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	return prefs.getBool('islogged');
  }

    // getUserNameByUserID(Stirng userID){

    //     _firestore.collection('users').where(userID, )

    // }

}