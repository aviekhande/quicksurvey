// import 'package:cloudcard/core/routes/app_router.dart';
// import 'package:cloudcard/core/routes/app_router.gr.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:cloudcard/core/services/shared_preferences/shared_preferences_service.dart';
// import 'package:cloudcard/init_dependencies.dart';

// class AuthInterceptor extends Interceptor {
//   final SharedPreferencesService _sharedPrefsService;
//   // final GlobalKey<NavigatorState> navigatorKey;

//   AuthInterceptor({
//     // required this.navigatorKey,
//     required SharedPreferencesService sharedPrefsService,
//   }) : _sharedPrefsService = sharedPrefsService;

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     if (err.response?.statusCode == 401) {
//       // Log out the user
//       _sharedPrefsService.deleteToken();

//       // Navigate to login page
//       _redirectToLogin();

//       // You can choose to either continue with the error or resolve it
//       return handler.resolve(
//         Response(
//           requestOptions: err.requestOptions,
//           statusCode: 401,
//           data: {'message': 'Unauthorized, redirecting to login'},
//         ),
//       );
//     }
//     return handler.next(err);
//   }

//   void _redirectToLogin() {
//     // Use a post-frame callback to avoid navigation during build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final router = serviceLocator<AppRouter>();

//       // Clear the entire navigation stack and go to login
//       router.replaceAll([LoginViaQrRoute()]);
//     });
//   }
// }
