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
    String valueChoose;
    final List<String> items = ['Movie', 'TV'];
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            avatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      width: 100,
                      height: 100,
                      ApiClient.imageUrl(avatar),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            username != null
                ? Text(
                    username,
                    style: const TextStyle(fontSize: 22),
                  )
                : const SizedBox.shrink(),
            // DropdownButton(
            //     value: valueChoose,
            //     items: items.map((buildMen)),
            //     onChanged: (newValue) {}),
          ],
        ),
      ),
    );
  }
}
