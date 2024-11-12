import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tvmaze/config/app_providers.dart';
import 'package:tvmaze/config/app_routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (
        context,
        orientation,
        type,
      ) {
        return MultiBlocProvider(
          providers: AppProviders().providers,
          child: MaterialApp(
            onGenerateRoute: AppRoutes.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splashScreen,
            theme: ThemeData.dark(),
          ),
        );
      },
    );
  }
}
