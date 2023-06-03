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

// ........................bottomNavBar...........................

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'BUSINESS'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'SCINECE'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'SPORTS'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'SETTINGS'),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(BottomNavState());
  }

// ..................................BODY.............................................

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen(),
  ];

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Dio>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
}
