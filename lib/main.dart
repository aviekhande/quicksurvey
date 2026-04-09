
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/colors.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // context.read<NetworkBloc>().add(NetworkObserve());
    // _preloadMultipleSvgs();
    // _preloadSvg();
  }


  @override
  Widget build(BuildContext context) {
    // final appRouter = serviceLocator<AppRouter>();
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    // final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // final appRouter = serviceLocator<AppRouter>();
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light, // Android
                  statusBarBrightness: Brightness.dark, // iOS
                ),
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(0.94)),
                  child: child!,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            // routerConfig: appRouter.config(
            //   navigatorObservers: () => [
            //     // serviceLocator<AnalyticsService>().getAnalyticsObserver(),
            //   ],
            // ),
            title: AppStrings.kAppTitle,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.kColorPrimaryBg,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          ),
        ),
      ),
    );
  }
}
