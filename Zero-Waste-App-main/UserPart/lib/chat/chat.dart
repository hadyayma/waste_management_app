import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Testing/Theme/app_color.dart';
import '../models/posts.dart';

class UserChatPage extends StatefulWidget {
  late final String staffItemId;

  static var routeName='/UserChatPage';

  UserChatPage({required this.staffItemId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<UserChatPage> {
  final TextEditingController _textController = TextEditingController();
  CollectionReference? _staffCollection;
  CollectionReference? _userCollection;
  late String _senderId = ''; // Initialize _senderId with an empty string
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _getSenderId();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getSenderId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _senderId = user.uid;
        _userCollection = FirebaseFirestore.instance
            .collection('requests')
            .doc(widget.staffItemId)
            .collection('chat');
        _staffCollection = FirebaseFirestore.instance
            .collection('staff')
            .doc(_senderId)
            .collection('chat');
      });
      _scrollToLastMessage();
    }
  }

  void sendMessage(String message) {
    String receiverId = widget.staffItemId;

    MessageDataModel staffMessage = MessageDataModel(
      senderId: receiverId,  // Swap senderId and receiverId
      receiverId: _senderId,
      message: message,
      time: Timestamp.now(),
    );

    MessageDataModel userMessage = MessageDataModel(
      senderId: _senderId,
      receiverId: receiverId,  // Swap senderId and receiverId
      message: message,
      time: Timestamp.now(),
    );

    _staffCollection
        ?.doc(widget.staffItemId)
        .collection('messages')
        .add(staffMessage.toJson())
        .then((_) {
      setState(() {}); // Trigger UI rebuild after sending the message
      _scrollToLastMessage();
    });

    _userCollection
        ?.doc(_senderId)
        .collection('messages')
        .add(userMessage.toJson())
        .then((_) {
      setState(() {}); // Trigger UI rebuild after sending the message
      _scrollToLastMessage();
    });

    _textController.clear();
  }

  void _scrollToLastMessage() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat With Us'),
        backgroundColor: AppColor.kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _userCollection
                    ?.doc(_senderId)
                    .collection('messages')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return Text('No messages found');
                  }

                  List<MessageDataModel> messages = snapshot.data!.docs
                      .map((doc) =>
                      MessageDataModel.fromJson(doc.data() as Map<String, dynamic>))
                      .toList();

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToLastMessage();
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      MessageDataModel message = messages[index];
                      final bool isSentMessage = _senderId == message.senderId;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Align(
                          alignment: _senderId == message.senderId
                              ? AlignmentDirectional.centerEnd
                              : AlignmentDirectional.centerStart,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _senderId == message.senderId
                                  ? AppColor.kPrimaryColor.withOpacity(0.2)
                                  : Colors.grey[300],
                              borderRadius: isSentMessage
                                  ? BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(10),
                                topStart: Radius.circular(10),
                                topEnd: Radius.circular(10),
                              )
                                  : BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(10),
                                topStart: Radius.circular(10),
                                topEnd: Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Text(
                              message.message,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.kPlaceholder3,
                  width: 0.5,
                ),
                color: AppColor.kPlaceholder3
                ,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        controller: _textController,
                        cursorColor: AppColor.kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                            color: AppColor.kTextColor3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.kPlaceholder2,
                        width: 0.5,
                      ),
                      color: AppColor.kPlaceholder2,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 50.0,
                    child: MaterialButton(
                      onPressed: () {
                        String message = _textController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                        }
                      },
                      minWidth: 1.0,
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color:AppColor.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
