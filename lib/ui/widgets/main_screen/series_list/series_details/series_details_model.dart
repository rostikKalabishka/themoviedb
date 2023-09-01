import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/entity/series_details.dart';

class SeriesDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final int seriesId;
  SeriesDetails? _seriesDetails;
  String _locale = '';
  late DateFormat _dateFormat;
  SeriesDetails? get seriesDetails => _seriesDetails;

  SeriesDetailsModel(this.seriesId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    _seriesDetails = await _apiClient.seriesDetails(seriesId, _locale);
    notifyListeners();
  }
}
