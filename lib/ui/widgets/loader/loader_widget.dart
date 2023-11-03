import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/ui/widgets/loader/loader_view_model.dart';

import '../../routes/routes.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (previous, current) =>
          current != LoaderViewCubitState.unknown,
      listener: (context, state) {
        onLoaderViewCubitStateChange(context, state);
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void onLoaderViewCubitStateChange(
      BuildContext context, LoaderViewCubitState state) {
    final nextScreen = state == LoaderViewCubitState.authorize
        ? MainNavigationRouteName.mainScreen
        : MainNavigationRouteName.auth;

    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
