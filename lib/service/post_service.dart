import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  String? downloadURl;
  Future getData(String path) async {
    try {
      if (path.isNotEmpty) {
        downloadURl =
            await FirebaseStorage.instance.ref().child(path).getDownloadURL();
        print(downloadURl);
        return downloadURl;
      } else {
        return 'https://images.squarespace-cdn.com/content/60779c032ee663667c29fd03/1618811379527-QMD0SRCFRSOBHQTULV2Y/unsplash-image-AEaTUnvneik.jpg';
      }
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}




// class ChatService extends ChangeNotifier {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> sendMessage(String receiverId, String message) async {
//     final String currentUserId = _firebaseAuth.currentUser!.uid;
//     final String currntUserEmail = _firebaseAuth.currentUser!.email.toString();
//     final Timestamp timestamp = Timestamp.now();
//     Message newMessage = Message(
//         senderId: currentUserId,
//         senderEmail: currntUserEmail,
//         receiverId: receiverId,
//         message: message,
//         timestamp: timestamp);

//     List<String> ids = [currentUserId, receiverId];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//     await _firestore
//         .collection("chat_rooms")
//         .doc(chatRoomId)
//         .collection('messages')
//         .add(newMessage.toMap());
//   }

//   Stream<QuerySnapshot> getMessages(String userId, String otherId) {
//     List<String> ids = [userId, otherId];
//     ids.sort();
//     String chatRoomId = ids.join('_');

//     return _firestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }
