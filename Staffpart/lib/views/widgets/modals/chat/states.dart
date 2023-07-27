abstract class AppStates{

}
class AppInitialState extends AppStates{}
class AppChangeBottomNavBarState extends AppStates
{
  final int index;

  AppChangeBottomNavBarState(this.index);

}
class SendMessageSuccessState extends AppStates{}
class SendMessageErrorState extends AppStates{}
class GetMessageSuccessState extends AppStates{}
class GetMessageErrorState extends AppStates{}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}
