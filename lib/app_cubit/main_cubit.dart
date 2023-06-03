import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/app_cubit/main_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  void changeAppTheme() {
    isDark = !isDark;
    emit(AppChangeThemeModeState());
  }
}
