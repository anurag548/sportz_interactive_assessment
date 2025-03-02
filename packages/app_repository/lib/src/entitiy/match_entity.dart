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
  });

  factory MatchEntity.forMatchListing(
    MatchDetails matchDetails,
    List<TeamDetails> teamDetails,
  ) {
    return MatchEntity(
      id: matchDetails.matchId,
      venue: matchDetails.venueName,
      dateTime:
          '${matchDetails.matchDate.replaceAll('/', '-')} ${matchDetails.matchTime}',
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
    );
  }

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

  @override
  List<Object?> get props => [
        id,
        homeTeam,
        awayTeam,
        dateTime,
      ];
}
