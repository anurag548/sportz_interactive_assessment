import 'package:app_repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'match_detail_event.dart';
part 'match_detail_state.dart';

class MatchDetailBloc extends Bloc<MatchDetailEvent, MatchDetailState> {
  MatchDetailBloc(this.appRepository) : super(MatchDetailInitial()) {
    on<FetchMatchDetails>(_onFetchMatchDetails);
  }
  final AppRepository appRepository;

  Future<void> _onFetchMatchDetails(
    FetchMatchDetails event,
    Emitter<MatchDetailState> emit,
  ) async {
    emit(MatchDetailLoaded(await appRepository.getMatchDetails(event.match)));
  }
}
