
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportz_interactive_assessment/common/common.dart';
import 'package:sportz_interactive_assessment/match/match.dart';

class MatchDetailView extends StatelessWidget {
  const MatchDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchDetailBloc, MatchDetailState>(
      builder: (context, state) {
        if (state is MatchDetailLoaded) {
          return MatchDetailBody(state: state);
        } else if (state is MatchDetailError) {
          return ErrorView(message: state.message);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
