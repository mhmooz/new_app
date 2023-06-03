import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/states.dart';
import 'package:new_app/modules/business/business_screen.dart';
import 'package:new_app/modules/science/science_screen.dart';
import 'package:new_app/modules/settings/settings.dart';
import 'package:new_app/modules/sports/sports_screen.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

// ........................   bottomNavBar  ...........................

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'BUSINESS'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'SPORTS'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'SCINECE'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'SETTINGS'),
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

// ..................................  BODY   .............................................

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   Dio   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  List<dynamic> business = [];

  void getBusiness() {
    emit(BusinessLoadingState()); //........Loading before getting the data
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '9060398ae779405f8acfa44b906b7a68',
    }).then((value) {
      business = value.data['articles'];

      emit(BusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(SportsLoadingState()); //........Loading before getting the data
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '9060398ae779405f8acfa44b906b7a68',
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

  List<dynamic> science = [];

  void getScience() {
    emit(ScienceLoadingState()); //........Loading before getting the data
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '9060398ae779405f8acfa44b906b7a68',
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
}
