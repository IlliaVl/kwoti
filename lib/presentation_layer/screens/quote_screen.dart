import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

import '../../domain_layer/cubits/quote_cubit.dart';
import '../../domain_layer/cubits/quote_state.dart';

/// Screen for displaying random quote
/// Depends on [QuoteCubit] which state store fetched quotes
class QuoteScreen extends StatelessWidget {
  /// Creates new [QuoteScreen].
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<QuoteCubit>();
    final state = cubit.state;

    final shouldRetry = !state.busy &&
        state.errorStatus != QuoteErrorStatus.none &&
        state.quote == null;

    final firstLoad = state.busy &&
        state.errorStatus == QuoteErrorStatus.none &&
        state.quote == null;

    return BlocListener<QuoteCubit, QuoteState>(
      listener: (context, state) {
        if (!state.busy && state.errorStatus != QuoteErrorStatus.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Try later, please.'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Random quote'),
        ),
        body: shouldRetry
            ? Center(
                child: TextButton(
                  onPressed: cubit.load,
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            : firstLoad
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '"${state.quote?.quote ?? ''}"',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 16.0,
                                  end: 32.0,
                                ),
                                child: Text(
                                  state.quote?.author ?? '',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                  onPressed: () =>
                                      FlutterShareMe().shareToWhatsApp(
                                        msg: state.quote?.quoteWithAuthor ?? '',
                                      ),
                                  child: const Text('Share to WhatsApp'))
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: state.busy ? null : cubit.load,
                          child: state.busy
                              ? const SizedBox(
                                  height: 22.0,
                                  width: 22.0,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  'One more',
                                  style: TextStyle(
                                    fontSize: 26.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
