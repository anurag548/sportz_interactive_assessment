import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';

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
                return Scaffold(
                  appBar: AppBar(
                    title: Text(player.name),
                    backgroundColor: Colors.white,
                  ),
                  body: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(
                              text: 'Batting Stats',
                            ),
                            Tab(
                              text: 'Bowling Stats',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _PlayerStatsView(
                                playerStats: player.battingStats!,
                              ),
                              _PlayerStatsView(
                                playerStats: player.bowlingStats!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: ListTile(
            title: Text(
              '${player.name}${player.isCaptian ? ' (C)' : ''} ${player.isWicketKeeper ? ' (WK)' : ''}',
            ),
            subtitle: Text(player.position),
          ),
        );
      },
    );
  }
}

class _PlayerStatsView extends StatelessWidget {
  const _PlayerStatsView({
    required this.playerStats,
  });

  final PlayerStats playerStats;

  static const _titleTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static const _valueTextStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        spacing: 24,
        children: [
          _displayPlayerStats('Style', playerStats.style),
          _displayPlayerStats('Average', playerStats.average),
          if (playerStats is BattingStats)
            _displayPlayerStats(
              'Strike Rate',
              (playerStats as BattingStats).strikeRate,
            )
          else
            _displayPlayerStats(
              'Economy',
              (playerStats as BowlingStats).economy,
            ),
          if (playerStats is BattingStats)
            _displayPlayerStats(
              'Total Runs',
              (playerStats as BattingStats).runs,
            )
          else
            _displayPlayerStats(
              'Wickets',
              (playerStats as BowlingStats).wickets,
            ),
        ],
      ),
    );
  }

  Widget _displayPlayerStats(String key, String value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              key,
              style: _titleTextStyle,
            ),
            const Spacer(),
            Text(
              value,
              style: _valueTextStyle,
            ),
          ],
        ),
      );
}
