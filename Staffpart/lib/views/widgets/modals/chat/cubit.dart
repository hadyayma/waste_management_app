// import 'package:Staff/views/widgets/modals/chat/message_model.dart';
// import 'package:Staff/views/widgets/modals/chat/states.dart';
// import 'package:Staff/views/widgets/modals/todo_Screen.dart';
// import 'package:Staff/views/widgets/modals/todo_Screen_modal.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
// class MessageCubit extends Cubit<AppStates> {
//   MessageCubit() : super(AppInitialState());
//
//   // To be more easily when use this cubit in many places
//   static MessageCubit get(context) => BlocProvider.of(context);
//   MessageDataModel? messageModel;
//   int currentIndex = 0;
//   List<Widget> screens = [
//     CurrentListScreen(),
//     FinishedListScreen(),
//   ];
//   List<String> titles = [
//     'Current',
//     'Finished',
//   ];
//
//   TextEditingController messageController = TextEditingController();
//
//   void sendMessage(TodoItem userDataModel) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uId)
//         .collection('chats')
//         .get()
//         .then((value) {
//       MessageDataModel model = MessageDataModel(
//         time: DateTime.now().toString(),
//         message: messageController.text,
//         receiverId: userDataModel.uId,
//         senderId: user!.uId,
//       );
//
//       if (value.docs
//           .any((element) => element.reference.id != userDataModel.uId)) {
//         TodoItem chatDataModel = TodoItem(
//           Address: ,
//           Name: ,
//           Time: ,
//           Email: ,
//           UID: ,
//           Phone: ,
//           isFinished: ,
//         );
//
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uId)
//             .collection('chats')
//             .doc(userDataModel.uId)
//             .set(chatDataModel.toJson())
//             .then((value) {})
//             .catchError((error) {
//           debugPrint(error.toString());
//
//           emit(CreateChatError(
//             message: error.toString(),
//           ));
//         });
//
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(userDataModel.uId)
//             .collection('chats')
//             .doc(user!.uId)
//             .set(chatDataModel.toJson())
//             .then((value) {})
//             .catchError((error) {
//           debugPrint(error.toString());
//
//           emit(CreateChatError(
//             message: error.toString(),
//           ));
//         });
//       } else {
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uId)
//             .collection('chats')
//             .doc(userDataModel.uId)
//             .collection('messages')
//             .add(model.toJson())
//             .then((value) {
//           messageController.clear();
//         }).catchError((error) {
//           debugPrint(error.toString());
//
//           emit(CreateChatError(
//             message: error.toString(),
//           ));
//         });
//
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(userDataModel.uId)
//             .collection('chats')
//             .doc(user!.uId)
//             .collection('messages')
//             .add(model.toJson())
//             .then((value) {
//           messageController.clear();
//         }).catchError((error) {
//           debugPrint(error.toString());
//
//           emit(CreateChatError(
//             message: error.toString(),
//           ));
//         });
//       }
//     }).catchError((error) {
//       debugPrint(error.toString());
//
//       emit(SendMessage(
//         message: error.toString(),
//       ));
//     });
//   }
//
//   List<MessageDataModel> messagesList = [];
//
//   void getMessages(UserDataModel userDataModel) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uId)
//         .collection('chats')
//         .doc(userDataModel.uId)
//         .collection('messages').orderBy('time', descending: true,)
//         .snapshots()
//         .listen((value) {
//       messagesList = [];
//
//       for (var element in value.docs) {
//         messagesList.add(MessageDataModel.fromJson(element.data()));
//       }
//
//       debugPrint(messagesList.length.toString());
//
//       emit(GetMessagesSuccess());
//     });
//   }
// }
