import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/states.dart';
import 'package:new_app/modules/business/business_screen.dart';
import 'package:new_app/modules/science/science_screen.dart';
import 'package:new_app/modules/sports/sports_screen.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

// ------------------------   bottomNavBar  ------------------------

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'BUSINESS'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'SPORTS'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'SCINECE'),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    if (index == 1) {
      emit(SportsLoadingState());
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(BottomNavState());
  }

// ------------------------       BODY      ------------------------

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

// ------------------------       Dio       ------------------------

  List<dynamic> business = [];

  void getBusiness() {
    emit(BusinessLoadingState()); //........Loading before getting the data
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e3ed9bca131549568264a46b431ebeb8',
    }).then((value) {
      business = value.data['articles'];

      emit(BusinessSuccessState());
    }).catchError((error) {
      print('the error is =========${error.toString()}');
      emit(BusinessErrorState(error.toString()));
    });
  }

// -------------
  List<dynamic> sports = [];

  void getSports() {
    emit(SportsLoadingState()); //........Loading before getting the data
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'e3ed9bca131549568264a46b431ebeb8',
      }).then((value) {
        sports = value.data['articles'];

        emit(SportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SportsErrorState(error.toString()));
      });
    } else {
      emit(SportsSuccessState());
    }
  }

// -------------
  List<dynamic> science = [];

  void getScience() {
    emit(ScienceLoadingState()); //........Loading before getting the data
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'e3ed9bca131549568264a46b431ebeb8',
      }).then((value) {
        science = value.data['articles'];

        emit(ScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ScienceErrorState(error.toString()));
      });
    } else {
      emit(ScienceSuccessState());
    }
  }

// -------------
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(SearchLoadingState()); //........Loading before getting the data
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'e3ed9bca131549568264a46b431ebeb8',
    }).then((value) {
      search = value.data['articles'];

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
}
