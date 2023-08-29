import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/routes/routes.dart';
import 'package:themoviedb/ui/widgets/auth/auth_modal.dart';

import '../../Theme/app_bar_style.dart';
import '../../Theme/button_style.dart';
import '../../Theme/theme.dart';

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
            onPressed: () {
              SessionDataProvider().setSessionId(null);
            },
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
                navigator.pushNamed(MainNavigationRouteName.signUp);
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
              navigator.pushNamed(MainNavigationRouteName.resendEmail);
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

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _loginFocus = FocusNode();
    final _passwordFocus = FocusNode();
    const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
    const textFieldStyle = textFormFieldStyle;
    final model = NotifierProvider.read<AuthModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ErrorMessageWidget(),
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _loginFocus,
          autofocus: true,
          // onFieldSubmitted: (_) {
          //   _fieldFocusChange(context, _loginFocus, _passwordFocus);
          // },
          controller: model?.loginTextController,
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
          controller: model?.passwordTextController,
          decoration: textFieldStyle,
          obscureText: true,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            _AuthButtonWidget(),
            TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        ),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyle.eventButton,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
