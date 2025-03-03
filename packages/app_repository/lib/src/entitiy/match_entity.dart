import 'package:app_api/app_api.dart';
import 'package:app_repository/app_repository.dart';
import 'package:equatable/equatable.dart';

/// {@template match_entity}
/// Represents a match between two teams.
/// {@endtemplate}
class MatchEntity extends Equatable {
  /// {@macro match_entity}
  const MatchEntity({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.venue,
    this.dateTime,
    this.matchStatus = 'Scheduled',
    this.matchLeagueEntity = MatchLeagueEntity.empty,
  });

  /// Parsing the match details for the match listing.
  factory MatchEntity.forMatchListing(
    MatchDetails matchDetails,
    List<TeamDetails> teamDetails,
  ) {
    return MatchEntity(
      id: matchDetails.matchId,
      venue: matchDetails.venueName,
      dateTime:
          '${matchDetails.matchDate} ${matchDetails.matchTime}',
      matchStatus: matchDetails.matchStatus,
      homeTeam: TeamEntity.forMatchListing(
        teamDetails.firstWhere(
          (team) => team.teamId == matchDetails.homeTeamId,
        ),
      ),
      awayTeam: TeamEntity.forMatchListing(
        teamDetails.firstWhere(
          (team) => team.teamId == matchDetails.awayTeamId,
        ),
      ),
      matchLeagueEntity: MatchLeagueEntity(
        leagueName: matchDetails.matchLeague,
        matchType: matchDetails.matchType,
        matchNumber: matchDetails.matchNumber,
      ),
    );
  }

  /// Parsing the match details for the match detail.
  factory MatchEntity.forMatchDetail(
    MatchDetails matchDetails,
    List<TeamDetails> teamDetails,
  ) {
    return MatchEntity(
      id: matchDetails.matchId,
      homeTeam: TeamEntity.forMatchDetails(
        teamDetails.firstWhere(
          (team) => team.teamId == matchDetails.homeTeamId,
        ),
      ),
      awayTeam: TeamEntity.forMatchDetails(
        teamDetails.firstWhere(
          (team) => team.teamId == matchDetails.awayTeamId,
        ),
      ),
      venue: matchDetails.venueName,
      dateTime: '${matchDetails.matchDate} ${matchDetails.matchTime}',
    );
  }

  /// An empty match entity.
  static const empty = MatchEntity(
    id: '',
    venue: '',
    homeTeam: TeamEntity.empty,
    awayTeam: TeamEntity.empty,
  );

  /// The unique identifier for the match.
  final String id;

  /// The home team.
  final TeamEntity homeTeam;

  /// The away team.
  final TeamEntity awayTeam;

  /// The date and time of the match.
  final String? dateTime;

  /// The venue of the match.
  final String venue;

  /// Status for the match.
  final String matchStatus;

  /// The league in which the match is being played.
  final MatchLeagueEntity matchLeagueEntity;

  @override
  List<Object?> get props => [
        id,
        homeTeam,
        awayTeam,
        dateTime,
        venue,
        matchStatus,
      ];
}

/// {@template match_league_entity}
/// Represents a league in which a match is being played.
/// {@endtemplate}
class MatchLeagueEntity extends Equatable {
  /// {@macro match_league_entity}
  const MatchLeagueEntity({
    required this.leagueName,
    required this.matchType,
    this. matchNumber = '',
  });

  /// An empty instance of match league entity.
  static const empty = MatchLeagueEntity(
    leagueName: '',
    matchType: '',
  );

  /// An empty match league entity.
  final String leagueName;

  /// The type of match.
  final String matchType;

  /// The number of the match.
  final String matchNumber;

  @override
  List<Object?> get props => [leagueName, matchType,];
}
