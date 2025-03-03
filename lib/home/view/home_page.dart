import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportz_interactive_assessment/common/common.dart';
import 'package:sportz_interactive_assessment/home/home.dart';
import 'package:sportz_interactive_assessment/match/view/match_detail_page.dart';

/// {@template home_page}
/// A [StatelessWidget] which is reponsible for providing the [HomeBloc].
/// {@endtemplate}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (ctx) => HomeBloc(
        appRepository: RepositoryProvider.of<AppRepository>(context),
      )..add(FetchMatchListings()),
      child: const MatchListingView(),
    );
  }
}

class MatchListingView extends StatelessWidget {
  const MatchListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Listing'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is MatchListingsLoaded) {
            return ListView.builder(
              itemCount: state.matchListings.length,
              itemBuilder: (context, index) {
                final matchEntity = state.matchListings.elementAt(index);
                return MatchListingWidget(matchEntity: matchEntity,);
              },
            );
          } else if (state is MatchListingsError) {
            return ErrorView(message: state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MatchListingWidget extends StatelessWidget {
  const MatchListingWidget({
    required this.matchEntity,
    super.key,
  });

  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MatchDetailPage.route(matchEntity),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.primary.withAlpha(
                        90,
                      ),
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueGrey.shade100.withAlpha(90),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Text('${matchEntity.matchLeagueEntity.leagueName.toUpperCase()} - ${matchEntity.matchLeagueEntity.matchType} (${matchEntity.matchLeagueEntity.matchNumber}) - ${matchEntity.matchStatus}'),
              
              Align(
                
                child: Text(
                  '${matchEntity.homeTeam.teamShortName} vs ${matchEntity.awayTeam.teamShortName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
    
              Row(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                    const  Icon(Icons.calendar_today_rounded, size: 16),
                      Text(
                        matchEntity.dateTime!,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    spacing: 8,
                    children: [
                    const  Icon(Icons.place_rounded, size: 16),
                      Text(
                        matchEntity.venue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
