import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_app/app_cubit/main_cubit.dart';
import 'package:new_app/app_cubit/main_states.dart';
import 'package:new_app/layouts/news_app/cubit/cubit.dart';
import 'package:new_app/layouts/news_app/news_layout.dart';
import 'package:new_app/shared/bloc_observer.dart';
import 'package:new_app/shared/network/local/cache_helper.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppTheme(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    systemNavigationBarColor: Colors.white,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange),
                textTheme: const TextTheme(
                    displayLarge: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              darkTheme: ThemeData(
                  appBarTheme: AppBarTheme(
                    elevation: 0,
                    backgroundColor: HexColor("#18191a"),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor("#18191a"),
                        systemNavigationBarIconBrightness: Brightness.light,
                        systemNavigationBarColor: Colors.black),
                  ),
                  textTheme: const TextTheme(
                      displayLarge: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: HexColor("#18191a"),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      unselectedItemColor: Colors.grey,
                      backgroundColor: HexColor("#3a3b3c"))),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const NewsLayout());
        },
      ),
    );
  }
}
