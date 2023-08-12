import 'package:flutter/material.dart';

import '../../Theme/app_bar_style.dart';
import '../../Theme/button_style.dart';
import '../../Theme/thema.dart';

class ResendEmailScreen extends StatefulWidget {
  const ResendEmailScreen({super.key});

  @override
  State<ResendEmailScreen> createState() => _ResendEmailScreenState();
}

class _ResendEmailScreenState extends State<ResendEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resend activation email',
          style: AppColors.textAppBar,
        ),
      ),
      body: const ResendActivationEmail(),
    );
  }
}

class ResendActivationEmail extends StatefulWidget {
  const ResendActivationEmail({super.key});

  @override
  State<ResendActivationEmail> createState() => _ResendActivationEmailState();
}

class _ResendActivationEmailState extends State<ResendActivationEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const Text(
              'Missing your account verification email? Enter your email below to have it resent.'),
          const SizedBox(
            height: 20,
          ),
          const Text('Email'),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'What`s your email?',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 25),
          const ButtonsWidget()
        ],
      ),
    );
  }
}

class ButtonsWidget extends StatefulWidget {
  const ButtonsWidget({super.key});

  @override
  State<ButtonsWidget> createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: AppButtonStyle.eventButton,
          child: const Text('Send'),
        ),
        TextButton(
          onPressed: () {},
          style: AppButtonStyle.linkButton,
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
