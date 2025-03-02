part of 'match_detail_bloc.dart';

@immutable
sealed class MatchDetailEvent {}

class FetchMatchDetails extends MatchDetailEvent {
  FetchMatchDetails(this.match);

  final MatchEntity match;
}
