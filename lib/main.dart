import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'services/services.dart';
import 'package:vtech/util/const.dart';

import 'package:vtech/screens/signin.dart';
import 'package:vtech/screens/verify.dart';
import 'package:vtech/screens/addCamera.dart';
import 'package:vtech/screens/scanQRCode.dart';
import 'package:vtech/screens/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Demo',
      theme:  ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blue),
          fillColor: Color(0xFFececec),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(6), 
            ),
            borderSide: BorderSide(
              width: 0, 
              style: BorderStyle.none,
            ),
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(  
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
            ),
            primary: Colors.orange, // background color
            textStyle: TextStyle(
              fontSize: 16, 
              color: Colors.white,
            ),
          )
        ),
      ),
      home: BlocProvider(
        create: (context) {
          return AuthBloc(authService: AuthService())
            ..add(AppLoaded());
        },
        child: BlocBuilder<AuthBloc, AuthState>(  
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Routes();
            }
            else if (state is AuthPending) {
              return VerifyScreen();
            }
            return Routes();
            // return SignInScreen();
          },
        ),
      ),
    );
  }
}

class Routes extends StatelessWidget {
  const Routes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(
       appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Constants.secondary
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(  
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
            ),
            primary: Constants.secondary, // background color
            textStyle: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            elevation: 0
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            textStyle: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
            ),
            primary: Constants.secondary,
            backgroundColor: Colors.transparent,
          ),
        )
      ),
      routes: <String, WidgetBuilder>{
         '/': (BuildContext context) => HomeScreen(),
         '/scanQRCode': (BuildContext context) => ScanQRCodeScreen(),
         '/addCamera': (BuildContext context) => AddCameraScreen(),
      },
    );
  }
}

