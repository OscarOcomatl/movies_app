import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/router/app_router.dart';
import 'package:provider/provider.dart';
// import 'package:peliculas/screens/screens.dart';


// void main() => runApp(const MyApp());
void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => MoviesProvider(), lazy: false, // lazy eta en true por defecto, osea hasta que se necesite va a llamar esa instancia pero en false, la manda a llamar tan pronto se cree ese widget
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      // initialRoute: 'home',
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.getRoutes(),
      // routes: {
      //   'home'    : ( _ ) => HomeScreen(),
      //   'details' : ( _ ) => DetailsScreen()
      // },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}

