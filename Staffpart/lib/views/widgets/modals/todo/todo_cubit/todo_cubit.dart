import 'package:Staff/views/widgets/modals/todo/todo_Screen.dart';
import 'package:Staff/views/widgets/modals/todo/todo_Screen_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_states.dart';


class TodoCubit extends Cubit<TodoStates> {
  TodoScreen? todoScreen; // Add a nullable type indicator '?'

  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  void Todolist({
    required String Name,
    required Timestamp Time,
    required String Address,
    required String Email,
    required String Phone,
    required String uid,
  }) {
    TodoItem item = TodoItem(
      Name: Name,
      Address: Address,
      Phone: Phone,
      Email: Email,
      datePublished: Time.toDate().toLocal().toString(),
      uid: uid,
      ServeceStatus: 'Door To Door',
    );
    emit(TodoLoadingState());
    FirebaseFirestore.instance
        .collection('user_Mobile')
        .doc(uid)
        .set(item.toMap())
        .then((value) {
      emit(TodoSuccessState());
    }).catchError((error) {
      emit(TodoErrorState(error.toString()));
    });
  }
}

