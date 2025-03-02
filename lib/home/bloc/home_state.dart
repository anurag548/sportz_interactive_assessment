part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class MatchListingsLoaded extends HomeState {
  MatchListingsLoaded({required this.matchListings});

  final List<MatchEntity> matchListings;
}
