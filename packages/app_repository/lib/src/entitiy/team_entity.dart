import 'package:app_api/app_api.dart'
    show BattingDetails, BowlingDetails, TeamDetails;
import 'package:equatable/equatable.dart';

/// {@template team_entity}
/// Represents a team.
/// {@endtemplate}
class TeamEntity extends Equatable {
  /// {@macro team_entity}
  const TeamEntity({
    required this.teamId,
    required this.teamFullName,
    this.teamShortName = '',
    this.players = const [],
  });

  factory TeamEntity.forMatchListing(TeamDetails teamDetails) {
    return TeamEntity(
      teamId: int.parse(teamDetails.teamId),
      teamFullName: teamDetails.teamName,
      teamShortName: teamDetails.teamShortName,
    );
  }

  factory TeamEntity.forMatchDetails(TeamDetails teamDetails) {
    return TeamEntity(
      teamId: int.parse(teamDetails.teamId),
      teamFullName: teamDetails.teamName,
      teamShortName: teamDetails.teamShortName,
      players: teamDetails.players
          .map(
            (player) => PlayerEntity(
              id: player.id,
              name: player.name,
              position: player.position,
              isCaptian: player.isCaptian,
              isWicketKeeper: player.isKeeper,
              battingStats:
                  BattingStats.fromBattingDetails(player.battingStats),
              bowlingStats:
                  BowlingStats.fromBowlingDetails(player.bowlingStats),
            ),
          )
          .toList(),
    );
  }

  /// An empty team entity.
  static const empty = TeamEntity(
    teamId: -1,
    teamFullName: '',
    teamShortName: '',
  );

  /// The id of the team.
  final int teamId;

  /// The full name of the team.
  final String teamFullName;

  /// The short name of the team.
  final String teamShortName;

  /// The list of players in the team.
  final List<PlayerEntity> players;

  @override
  List<Object> get props => [
        teamId,
        teamFullName,
        teamShortName,
        players,
      ];
}

/// {@template player_entity}
/// Represents a player.
/// {@endtemplate}
class PlayerEntity extends Equatable {
  /// {@macro player_entity}
  const PlayerEntity({
    required this.id,
    required this.name,
    required this.position,
    this.isCaptian = false,
    this.isWicketKeeper = false,
    this.battingStats,
    this.bowlingStats,
  });

  /// An empty player entity.
  static const empty = PlayerEntity(
    id: '',
    name: '',
    position: '',
  );

  /// The unique identifier for the player.
  final String id;

  /// The name of the player.
  final String name;

  /// The position of the player.
  final String position;

  /// Whether the player is the captain of the team.
  final bool isCaptian;

  /// Whether the player is the wicket keeper of the team.
  final bool isWicketKeeper;

  /// The batting stats of the player.
  final PlayerStats? battingStats;

  /// The bowling stats of the player.
  final PlayerStats? bowlingStats;

  @override
  List<Object?> get props => [
        id,
        name,
        position,
        battingStats,
        bowlingStats,
      ];
}

/// {@template player_stats}
/// Base class for all player stats.
/// {@endtemplate}
abstract class PlayerStats {
  /// {@macro player_stats}
  const PlayerStats({
    required this.style,
    required this.average,
  });

  /// The style of the player.
  final String style;

  /// The average of the player.
  final String average;
}

/// {@template batting_stats}
/// Represents the batting stats of a player.
/// {@endtemplate}
class BattingStats extends PlayerStats with EquatableMixin {
  /// {@macro batting_stats}
  const BattingStats({
    required super.style,
    required super.average,
    required this.strikeRate,
    required this.runs,
  });

  /// Creates a [BattingStats] instance from a [BattingDetails] instance.
  factory BattingStats.fromBattingDetails(BattingDetails battingDetails) {
    return BattingStats(
      style: battingDetails.style,
      average: battingDetails.average,
      strikeRate: battingDetails.strikeRate,
      runs: battingDetails.runs,
    );
  }

  /// The strike rate of the player.
  final String strikeRate;

  /// The total runs scored by the player.
  final String runs;

  @override
  List<Object> get props => [
        style,
        average,
        strikeRate,
        runs,
      ];
}

/// {@template bowling_stats}
/// Represents the bowling stats of a player.
/// {@endtemplate}
class BowlingStats extends PlayerStats with EquatableMixin {
  /// {@macro bowling_stats}
  const BowlingStats({
    required super.style,
    required super.average,
    required this.economy,
    required this.wickets,
  });

  factory BowlingStats.fromBowlingDetails(BowlingDetails bowlingDetails) {
    return BowlingStats(
      style: bowlingDetails.style,
      average: bowlingDetails.average,
      economy: bowlingDetails.economy,
      wickets: bowlingDetails.wickets,
    );
  }

  /// The economy of the player.
  final String economy;

  /// The total wickets taken by the player.
  final String wickets;

  @override
  List<Object> get props => [
        style,
        average,
        economy,
        wickets,
      ];
}
