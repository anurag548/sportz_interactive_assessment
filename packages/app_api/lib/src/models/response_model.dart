import 'dart:developer';

import 'package:equatable/equatable.dart';

/// {@template response_model}
/// Base class for all response models.
/// {@endtemplate}
class ResponseModel extends Equatable {
  /// {@macro response_model}
  const ResponseModel({
    required this.matchDetails,
    this.teamDetails = const [],
  });

  /// Converts the response json string to a [ResponseModel].
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    log('ResponseModel.fromJson: $json');
    return ResponseModel(
      matchDetails:
          MatchDetails.fromJson(json['Matchdetail'] as Map<String, dynamic>),
      teamDetails: TeamDetails.fromJson(json['Teams'] as Map<String, dynamic>),
    );
  }

  /// Maps the response model to a json string.
  final MatchDetails matchDetails;

  /// Maps the team details from the json string.
  final List<TeamDetails> teamDetails;

  @override
  List<Object> get props => [
        matchDetails,
      ];
}

/// {@template match_details}
/// Represents the details of a match.
/// {@endtemplate}
class MatchDetails extends Equatable {
  /// {@macro match_details}
  const MatchDetails({
    required this.matchId,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.venueName,
    required this.matchDate,
    required this.matchTime,
    this.matchStatus = 'Scheduled',
    this.matchLeague = 'ICC',
    this.matchType = 'ODI',
    this.matchNumber = '-1',
  });

  /// Converts the response json string to a [MatchDetails].
  factory MatchDetails.fromJson(Map<String, dynamic> matchDetailJson) {
    final matchJson = matchDetailJson['Match'] as Map<String, dynamic>;

    final venueJson = matchDetailJson['Venue'] as Map<String, dynamic>;

    return MatchDetails(
      homeTeamId: matchDetailJson['Team_Home'] as String,
      awayTeamId: matchDetailJson['Team_Away'] as String,
      matchStatus: matchDetailJson['Status'] as String,
      venueName: venueJson['Name'] as String,
      matchId: matchJson['Id'] as String,
      matchDate: matchJson['Date'] as String,
      matchTime: matchJson['Time'] as String,
      matchLeague: matchJson['League'] as String,
      matchType: matchJson['Type'] as String,
      matchNumber: matchJson['Number'] as String,

    );
  }

  /// Stores the id of the match.
  final String matchId;

  /// Stores the id of the home team.
  final String homeTeamId;

  /// Stores the id of the away team.
  final String awayTeamId;

  /// Stores the name of the venue.
  final String venueName;

  /// Stores the date of the match.
  final String matchDate;

  /// Stores the time of the match.
  final String matchTime;

  /// Stores the status of the match.
  final String matchStatus;

  /// The league in which the match is being played.
  final String matchLeague;

   /// Match type.
   final String matchType;

  /// Stores the match number.
   final String matchNumber;

  @override
  List<Object> get props => [
        matchId,
        homeTeamId,
        awayTeamId,
        venueName,
        matchDate,
        matchTime,
        matchStatus,
        matchLeague,
        matchType,
        matchNumber,
      ];
}

/// {@template team_details}
/// Represents the details of a team.
/// {@endtemplate}
class TeamDetails extends Equatable {
  /// {@macro team_details}
  const TeamDetails({
    required this.teamId,
    required this.teamName,
    required this.teamShortName,
    this.players = const [],
  });

  /// Converts the response json string to a [TeamDetails].
  static List<TeamDetails> fromJson(Map<String, dynamic> teamDetailsJson) {
    final teamDetailsList = teamDetailsJson.entries.map((entry) {
      final teamJson = entry.value as Map<String, dynamic>;
      return TeamDetails(
        teamId: entry.key,
        teamName: teamJson['Name_Full'] as String,
        teamShortName: teamJson['Name_Short'] as String,
        players: PlayersDetails.fromJson(
            teamJson['Players'] as Map<String, dynamic>),
      );
    }).toList();
    return teamDetailsList;
  }

  /// Stores the id of the team.
  final String teamId;

  /// Stores the full name of the team.
  final String teamName;

  /// Stores the short name of the team.
  final String teamShortName;

  /// Stores the list of players in the team.
  final List<PlayersDetails> players;

  @override
  List<Object> get props => [
        teamId,
        teamName,
        teamShortName,
        players,
      ];
}

/// {@template players_details}
/// Represents the details of a player.
/// {@endtemplate}
class PlayersDetails extends Equatable {
  /// {@macro players_details}
  const PlayersDetails({
    required this.id,
    required this.name,
    required this.position,
    required this.battingStats,
    required this.bowlingStats,
    this.isCaptian = false,
    this.isKeeper = false,
  });

  static List<PlayersDetails> fromJson(Map<String, dynamic> playersJson) {
    final playersList = playersJson.entries.map((entry) {
      final playerJson = entry.value as Map<String, dynamic>;
      return PlayersDetails(
        id: entry.key,
        name: playerJson['Name_Full'] as String,
        position: playerJson['Position'] as String,
        battingStats: BattingDetails.fromJson(
          playerJson['Batting'] as Map<String, dynamic>,
        ),
        bowlingStats: BowlingDetails.fromJson(
          playerJson['Bowling'] as Map<String, dynamic>,
        ),
        isCaptian: playerJson['Iscaptain'] as bool? ?? false,
        isKeeper: playerJson['Iskeeper'] as bool? ?? false,
      );
    }).toList();
    return playersList;
  }

  /// Stores the id of the player.
  final String id;

  /// Stores the name of the player.
  final String name;

  /// Stores the position of the player.
  final String position;

  /// Stores the batting stats of the player.
  final bool isCaptian;

  /// Stores the bowling stats of the player.
  final bool isKeeper;

  /// Stores the batting stats of the player.
  final BattingDetails battingStats;

  /// Stores the bowling stats of the player.
  final BowlingDetails bowlingStats;

  @override
  List<Object> get props => [
        id,
        name,
        position,
        battingStats,
        bowlingStats,
      ];
}

class BowlingDetails extends Equatable {
  const BowlingDetails({
    required this.style,
    required this.average,
    required this.economy,
    required this.wickets,
  });

  factory BowlingDetails.fromJson(Map<String, dynamic> bowlingJson) {
    return BowlingDetails(
      style: bowlingJson['Style'] as String,
      average: bowlingJson['Average'] as String,
      economy: bowlingJson['Economyrate'] as String,
      wickets: bowlingJson['Wickets'] as String,
    );
  }

  final String style;
  final String average;
  final String economy;
  final String wickets;

  @override
  List<Object> get props => [
        style,
        average,
        economy,
        wickets,
      ];
}

class BattingDetails extends Equatable {
  const BattingDetails({
    required this.style,
    required this.average,
    required this.strikeRate,
    required this.runs,
  });

  factory BattingDetails.fromJson(Map<String, dynamic> battingJson) {
    return BattingDetails(
      style: battingJson['Style'] as String,
      average: battingJson['Average'] as String,
      strikeRate: battingJson['Strikerate'] as String,
      runs: battingJson['Runs'] as String,
    );
  }

  final String style;
  final String average;
  final String strikeRate;
  final String runs;

  @override
  List<Object> get props => [
        style,
        average,
        strikeRate,
        runs,
      ];
}
