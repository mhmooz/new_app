import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/app_cubit/main_cubit.dart';
import 'package:new_app/app_cubit/main_states.dart';
import 'package:new_app/layouts/news_app/cubit/cubit.dart';
import 'package:new_app/layouts/news_app/news_layout.dart';
import 'package:new_app/shared/bloc_observer.dart';
import 'package:new_app/shared/network/local/cache_helper.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';
import 'package:new_app/shared/styles/themes.dart';

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
              theme:lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,

              home: const NewsLayout());
        },
      ),
    );
  }
}
