import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../abstracts/repositories/base_repository.dart';
import 'quote_state.dart';

/// A cubit that keeps state of receiving random quote
class QuoteCubit extends Cubit<QuoteState> {
  @protected
  final List<BaseRepository> repositories;

  /// Creates a new cubit using the supplied [repository]
  QuoteCubit({required this.repositories})
      : assert(repositories.isNotEmpty),
        super(const QuoteState());

  @protected
  BaseRepository get repository =>
      repositories[Random().nextInt(repositories.length)];

  /// Loads random quote
  Future<void> load() async {
    emit(
      state.copyWith(
        busy: true,
        errorStatus: QuoteErrorStatus.none,
      ),
    );

    try {
      final quote = await repository.getRandomQuote();

      emit(
        state.copyWith(
          quote: quote,
          busy: false,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          busy: false,
          errorStatus: QuoteErrorStatus.generic,
        ),
      );
    }
  }
}
