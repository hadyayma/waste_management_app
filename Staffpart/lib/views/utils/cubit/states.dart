abstract class ZerosStates {}

class ZerosInitialState extends ZerosStates {}

class ZerosBottomNavState extends ZerosStates {}

class ZerosGetBusinessLoadingState extends ZerosStates {}

class ZerosGetBusinessSuccessState extends ZerosStates {}

class ZerosGetBusinessErrorState extends ZerosStates
{
  final String error;

  ZerosGetBusinessErrorState(this.error);
}

class ZerosGetSportsLoadingState extends ZerosStates {}

class ZerosGetSportsSuccessState extends ZerosStates {}

class ZerosGetSportsErrorState extends ZerosStates
{
  final String error;

  ZerosGetSportsErrorState(this.error);
}

class ZerosGetScienceLoadingState extends ZerosStates {}

class ZerosGetScienceSuccessState extends ZerosStates {}

class ZerosGetScienceErrorState extends ZerosStates
{
  final String error;

  ZerosGetScienceErrorState(this.error);
}

class ZerosGetSearchLoadingState extends ZerosStates {}

class ZerosGetSearchSuccessState extends ZerosStates {}

class ZerosGetSearchErrorState extends ZerosStates
{
  final String error;

  ZerosGetSearchErrorState(this.error);
}