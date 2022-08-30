import 'package:flutter_bloc/flutter_bloc.dart';

import '../abstracts/repositories/base_repository.dart';
import 'quote_state.dart';

/// A cubit that keeps state of receiving random quote
class QuoteCubit extends Cubit<QuoteState> {
  final BaseRepository _repository;

  /// Creates a new cubit using the supplied [repository]
  QuoteCubit({required BaseRepository repository})
      : _repository = repository,
        super(const QuoteState());

  /// Loads random quote
  Future<void> load() async {
    emit(
      state.copyWith(
        busy: true,
        errorStatus: QuoteErrorStatus.none,
      ),
    );

    try {
      final quote = await _repository.getRandomQuote();

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
