import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/modules/shop_screens/login_screens/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'modules/shop_screens/on_boarding_screens/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  onBoarding ??= false;
   token = CacheHelper.getData(key: 'token');
  if (onBoarding) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoarding();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData()
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.teal,
                ),
                backgroundColor: Colors.white,
                elevation: 0),
            scaffoldBackgroundColor: Colors.white,
              drawerTheme:const DrawerThemeData(
                backgroundColor: Colors.teal,
              ),
              listTileTheme: const ListTileThemeData(
              iconColor: Colors.white,
              textColor: Colors.white
            )
          ),
          home: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 3)),
              builder: (context, sh) {
                if (sh.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else {
                  return startWidget;
                }
              })),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late AnimationController animationController;
@override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this ,duration:const Duration(seconds: 1), lowerBound: 0.4 , upperBound: 1  );
animationController.forward();
animationController.addListener(() {
  if(animationController.isCompleted) animationController.reverse() ;
  if(animationController.isDismissed) animationController.forward();
});
  }
  @override
  void dispose() {
  animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.teal,
      child: FadeTransition(
        opacity: animationController,
          child: Image.asset('assets/images/logo.png')),
    );
  }
}
