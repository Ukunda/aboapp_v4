import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/subscription_suggestion_cubit.dart';
import '../../domain/entities/subscription_suggestion.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class SubscriptionSuggestionsScreen extends StatelessWidget {
  const SubscriptionSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.translate('suggestions_title')),
      ),
      body: BlocBuilder<SubscriptionSuggestionCubit, SubscriptionSuggestionState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildInitial(context),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (suggestions) => _buildList(context, suggestions),
            empty: () => Center(
                child: Text(context.l10n.translate('suggestions_empty'))),
            error: (msg) => Center(child: Text(msg)),
          );
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.read<SubscriptionSuggestionCubit>().scan(
              host: 'imap.example.com',
              port: 993,
              isSecure: true,
              username: 'name@example.com',
              password: 'password',
            ),
        child: Text(context.l10n.translate('suggestions_start_scan')),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<SubscriptionSuggestion> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final s = suggestions[index];
        return ListTile(
          title: Text(s.service),
          subtitle: Text('${s.amount.toStringAsFixed(2)} - ${s.cycle.name}'),
        );
      },
    );
  }
}
