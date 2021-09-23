import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/modules/welcome_screen/welcome_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'layouts/home_screen/cubit/cubit.dart';
import 'layouts/home_screen/home_screen.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/search_screen/cubit/cubit.dart';
import 'modules/sign_up_screen/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = HomeScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopAppCubit()
            ..getUserData()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()

        ),
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){},
        builder:  (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
            ThemeData(fontFamily: 'Jannah', primarySwatch: Colors.deepOrange),
            home: startWidget,
          );
        },
      ),
    );
  }
}
