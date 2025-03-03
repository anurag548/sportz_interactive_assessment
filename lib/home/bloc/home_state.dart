part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class MatchListingsLoaded extends HomeState with EquatableMixin {
  MatchListingsLoaded({required this.matchListings});

  final List<MatchEntity> matchListings;

  @override
  List<Object> get props => [matchListings,];
}


final class MatchListingsError extends HomeState with EquatableMixin {
  MatchListingsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message,];
}