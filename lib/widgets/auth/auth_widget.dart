import 'package:flutter/material.dart';

import '../../Theme/app_bar_style.dart';
import '../../Theme/button_style.dart';
import '../../Theme/thema.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.people,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 14, 117, 201),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
        // backgroundColor: const Color.fromARGB(255, 1, 20, 48),
        title: const Text(
          'Login to your account',
          style: AppColors.textAppBar,
        ),
      ),
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Colors.black);
    final navigator = Navigator.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {
                navigator.pushNamed('/sign_up');
              },
              child: const Text('Register')),
          const SizedBox(height: 25),
          const Text(
            'If you signed up but didn`t get your verification email, click here to have it resent.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              navigator.pushNamed('/resend_email');
            },
            style: AppButtonStyle.linkButton,
            child: const Text('Verify Email'),
          ),
          const SizedBox(
            height: 25,
          ),
          const _FormWidget()
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();

  String? errorText = null;
  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordController.text;
    print(login);
    setState(() {
      if (password.length < 5 || login.isEmpty) {
        errorText = 'Error password or username';
        print('error');
      } else {
        final navigator = Navigator.of(context);
        navigator.pushNamed('/main_screen');
        errorText = null;
      }
    });
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _resetPassword() {
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
    const textFieldStyle = textFormFieldStyle;
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 10,
          )
        ],
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _loginFocus,
          autofocus: true,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, _loginFocus, _passwordFocus);
          },
          controller: _loginTextController,
          decoration: textFieldStyle,
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _passwordFocus,
          controller: _passwordController,
          decoration: textFieldStyle,
          obscureText: true,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: AppButtonStyle.eventButton,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        ),
      ],
    );
  }
}
