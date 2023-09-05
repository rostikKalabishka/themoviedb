import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../domain/entity/account_details.dart';

class AccountModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  AccountDetails? _accountDetails;

  String _locale = '';
  late DateFormat _dateFormat;

  AccountDetails? get accountDetails => _accountDetails;

  AccountModel();

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _accountDetails = await _apiClient.accountDetails(sessionId, accountId);
    notifyListeners();
  }
}
