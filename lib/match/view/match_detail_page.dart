import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportz_interactive_assessment/match/match.dart';

class MatchDetailPage extends StatelessWidget {
  const MatchDetailPage({
    required this.match,
    super.key,
  });

  static Route<dynamic> route(MatchEntity match) {
    return MaterialPageRoute<void>(
      builder: (_) => MatchDetailPage(
        match: match,
      ),
    );
  }

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchDetailBloc(
        RepositoryProvider.of<AppRepository>(context),
      )..add(FetchMatchDetails(match)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${match.homeTeam.teamFullName} vs ${match.awayTeam.teamFullName}',
          ),
        ),
        body: BlocBuilder<MatchDetailBloc, MatchDetailState>(
          builder: (context, state) {
            if (state is MatchDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PlayersListView(
                      playersList: state.matchDetail.homeTeam.players,
                    ),
                    PlayersListView(
                      playersList: state.matchDetail.awayTeam.players,
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class PlayersListView extends StatelessWidget {
  const PlayersListView({
    required this.playersList,
    super.key,
  });

  final List<PlayerEntity> playersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playersList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final player = playersList.elementAt(index);
        return InkWell(
          onTap: () async {
            return showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                );
              },
            );
          },
          child: ListTile(
            title: Text(
                '${player.name}${player.isCaptian ? ' (C)' : ''} ${player.isWicketKeeper ? ' (WK)' : ''}'),
            subtitle: Text(player.position),
          ),
        );
      },
    );
  }
}
