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
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                avatar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          width: 120,
                          height: 120,
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
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text('My favorites movie', style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
                const MovieFavoriteList(),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text('My favorites TV', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                const MovieFavoriteList(),
                TextButton(
                    onPressed: () => model.deleteSession,
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 22),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieFavoriteList extends StatelessWidget {
  const MovieFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AccountModel>(context);
    if (model == null) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      // height: double.infinity,
      child: Stack(children: [
        SizedBox(
          height: 163,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: model.favoriteMovie?.results.length,
              itemExtent: 220,
              itemBuilder: (BuildContext context, int index) {
                // model.showedMovieAtIndex(index);
                final listMovie = model.favoriteMovie?.results[index];
                final posterPath = listMovie?.posterPath;
                if (listMovie == null) return const SizedBox.shrink();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2)),
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          posterPath != null
                              ? Image.network(
                                  ApiClient.imageUrl(posterPath),
                                  width: 95,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  listMovie.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  model.stringFromDate(listMovie.releaseDate),
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          // IconButton(
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        onTap: () => model.onMovieTap(context, index),
                      ),
                    )
                  ]),
                );
              }),
        ),
      ]),
    );
  }
}
