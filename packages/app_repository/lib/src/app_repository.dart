import 'dart:isolate';

import 'package:app_api/app_api.dart';
import 'package:app_repository/app_repository.dart';

/// Key for storing the match details in the cache.
const String kMatchDetailsKey = 'match_list';

/// Key for storing the team details in the cache.
const String kTeamDetailsKey = 'team_list';

/// {@template app_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AppRepository {
  /// {@macro app_repository}
  AppRepository({
    required AppApiClient apiClient,
  }) : _apiClient = apiClient;

  final AppApiClient _apiClient;

  final Map<String, List<dynamic>> _cachedResponseList = {
    kMatchDetailsKey: <MatchDetails>[],
    kTeamDetailsKey: <TeamDetails>[],
  };

  /// Fetches the data from the api.
  Future<Map<String, List<dynamic>>> get _responseList async {
    if (_cachedResponseList.entries.every(
      (element) => element.value.isNotEmpty,
    )) {
      return _cachedResponseList;
    }
    for (final path in availablePaths) {
      final response = await Isolate.run(() => _apiClient.getData(path: path));
      _cachedResponseList
        ..update(
          kMatchDetailsKey,
          (previous) => List.from(previous)..add(response.matchDetails),
        )
        ..update(
          kTeamDetailsKey,
          (previous) => List.from(previous)..addAll(response.teamDetails),
        );
    }
    return _cachedResponseList;
  }

  /// Extracts the match data from response recieved through api.
  Future<List<MatchEntity>> getMatchLists() async {
    final responseList = await _responseList;

    final matchList = responseList[kMatchDetailsKey]!
        .map<MatchEntity>(
          (matchDetails) => MatchEntity.forMatchListing(
            matchDetails as MatchDetails,
            responseList[kTeamDetailsKey]!.cast(),
          ),
        )
        .toList();

    return matchList;
  }

  /// Extracts the match details from response recieved through api.
  Future<MatchEntity> getMatchDetails(MatchEntity matchEntity) async {
    final responseList = await _responseList;

    final matchDetail = responseList[kMatchDetailsKey]!.firstWhere(
      (element) => (element as MatchDetails).matchId == matchEntity.id,
    ) as MatchDetails;

    return MatchEntity.forMatchDetail(
      matchDetail,
      responseList[kTeamDetailsKey]!.cast(),
    );
  }

  /// Extracts the team details from response recieved through api.
  Future<PlayerEntity> getPlayerDetails(String playerId) async {
    return PlayerEntity.empty;
  }
}
