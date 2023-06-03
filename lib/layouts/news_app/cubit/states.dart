abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class BottomNavState extends NewsStates {}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class BusinessLoadingState extends NewsStates {}

class BusinessSuccessState extends NewsStates {}

class BusinessErrorState extends NewsStates {
  final String error;

  BusinessErrorState(this.error);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class SportsLoadingState extends NewsStates {}

class SportsSuccessState extends NewsStates {}

class SportsErrorState extends NewsStates {
  final String error;

  SportsErrorState(this.error);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class ScienceLoadingState extends NewsStates {}

class ScienceSuccessState extends NewsStates {}

class ScienceErrorState extends NewsStates {
  final String error;

  ScienceErrorState(this.error);
}
