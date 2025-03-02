import 'package:app_repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.appRepository}) : super(HomeInitial()) {
    on<FetchMatchListings>(_onFetchMatchListings);
  }

  final AppRepository appRepository;

  Future<void> _onFetchMatchListings(
    FetchMatchListings event,
    Emitter<HomeState> emit,
  ) async {
    final matchListings = await appRepository.getMatchLists();

    emit(MatchListingsLoaded(matchListings: matchListings));
  }
}
