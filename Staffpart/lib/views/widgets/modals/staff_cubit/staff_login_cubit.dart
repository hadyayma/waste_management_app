
import 'package:Staff/views/widgets/modals/staff_cubit/staff_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'staff_login_states.dart';

class SLoginCubit extends Cubit<StaffLoginStates> {
  LoginScreen? loginScreen;

  SLoginCubit() : super(SLoginInitialState()) {
    loginScreen = LoginScreen(); // Initialize loginScreen here
  }

  static SLoginCubit get(context) => BlocProvider.of(context);

  void staffLogin({
    required String email,
    required String password,
  }) {
    emit(SLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SLoginSuccessState());
    }).catchError((error) {
      emit(SLoginErrorState(error.toString()));
    });
  }
}
