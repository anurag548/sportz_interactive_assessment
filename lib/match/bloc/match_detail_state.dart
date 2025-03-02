part of 'match_detail_bloc.dart';

@immutable
sealed class MatchDetailState {}

final class MatchDetailInitial extends MatchDetailState {}

final class MatchDetailLoaded extends MatchDetailState with EquatableMixin {
  MatchDetailLoaded(this.matchDetail);

  final MatchEntity matchDetail;

  @override
  List<Object?> get props => [
        matchDetail,
      ];
}
