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
        body: const MatchDetailView(),
      ),
    );
  }
}
