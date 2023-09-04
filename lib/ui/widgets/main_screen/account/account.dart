import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../library/widgets/inherited/provider.dart';
import 'account_model.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.watch<AccountModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AccountModel>(context);
    if (model == null) return const SizedBox.shrink();
    final username = model.accountDetails?.username;
    final avatar = model.accountDetails?.avatar.tmdb.avatarPath;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            username != null ? Text(username) : const SizedBox.shrink(),
            avatar != null
                ? Image.network(
                    ApiClient.imageUrl(avatar),
                    width: 100,
                    height: 100,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
