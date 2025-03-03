import 'package:flutter/material.dart';
import 'package:sportz_interactive_assessment/match/match.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MatchDetailBody extends StatefulWidget {
  const MatchDetailBody({required this.state,super.key});

  final MatchDetailLoaded state;

  @override
  State<MatchDetailBody> createState() => _MatchDetailBodyState();
}

class _MatchDetailBodyState extends State<MatchDetailBody> with SingleTickerProviderStateMixin {

  MatchDetailLoaded get state => widget.state;

  late final TabController tabController;

  static final homeTeamKey = GlobalKey(debugLabel: 'home_team');

  static final awayTeamKey = GlobalKey(debugLabel: 'away_team');

  static const _scrollableDuration = Duration(milliseconds: 500);

  

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void _onTabTapped(int index) {
    final key = index == 0 ? homeTeamKey : awayTeamKey;
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: _scrollableDuration,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  tabs:  const [
                    Tab(text: 'Home Team'),
                    Tab(text: 'Away Team'),
                  ],
                  onTap: _onTabTapped,
                ),
                VisibilityDetector(
                  key: homeTeamKey,
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction == 1) {
                      tabController.animateTo(0);
                    }
                  },
                  child: PlayersListView(
                    title: '${state.matchDetail.homeTeam.teamFullName} (home)',
                    playersList: state.matchDetail.homeTeam.players,
                  ),
                ),
                VisibilityDetector(
                  key: awayTeamKey,
                  onVisibilityChanged:(info) {
                    if (info.visibleFraction == 1) {
                      tabController.animateTo(1);
                    }
                  },
                  child: PlayersListView(
                    
                    title: '${state.matchDetail.awayTeam.teamFullName} (away)',
                    playersList: state.matchDetail.awayTeam.players,
                  ),
                ),
              ],
            ),
          );
  }
}
