import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../services/services.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInForm()
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email'
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password'
            )
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () { 
              authBloc.add(UserSignInStart(email: emailController.text, password: passwordController.text));
            },
            child: const Text('Sign In'),
          ),
        ]
      )
    );
  }
}

