abstract class StaffLoginStates {}

class SLoginInitialState extends StaffLoginStates {}

class SLoginLoadingState extends StaffLoginStates {}

class SLoginSuccessState extends StaffLoginStates {}

class SLoginErrorState extends StaffLoginStates
{
  final String error;

  SLoginErrorState(this.error);
}
class SLoginChangePasswordVisibilityState extends StaffLoginStates {}


