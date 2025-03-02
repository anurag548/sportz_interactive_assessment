import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MatchDetailPage.route(state.matchListings[index]),
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
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          Row(
                            children: [
                              Text(
                                state.matchListings[index].dateTime!,
                              ),
                              const Spacer(),
                              Text(
                                state.matchListings[index].venue,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.matchListings[index].homeTeam
                                    .teamShortName,
                              ),
                              const Text(' vs '),
                              Text(
                                state.matchListings[index].awayTeam
                                    .teamShortName,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
