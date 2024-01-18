import 'package:flutter/material.dart';
import 'package:peliculas/screens/screens.dart';

class AppRouter {

  static const String initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {
        'home'    : ( _ ) => HomeScreen(),
        'details' : ( _ ) => DetailsScreen()
    };
    return appRoutes;
  }

  
}



