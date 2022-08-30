import 'package:equatable/equatable.dart';

import '../model/quote.dart';

/// The state of the [QuoteCubit]
class QuoteState extends Equatable {
  /// Random quote
  final Quote? quote;

  /// The current error status.
  final QuoteErrorStatus errorStatus;

  /// True if the cubit is processing something.
  final bool busy;

  /// Creates a new [QuoteState].
  const QuoteState({
    this.quote,
    this.errorStatus = QuoteErrorStatus.none,
    this.busy = false,
  });

  @override
  List<Object?> get props => [
        quote,
        errorStatus,
        busy,
      ];

  /// Creates a new state based on this one.
  QuoteState copyWith({
    Quote? quote,
    QuoteErrorStatus? errorStatus,
    bool? busy,
  }) =>
      QuoteState(
        quote: quote ?? this.quote,
        errorStatus: errorStatus ?? this.errorStatus,
        busy: busy ?? this.busy,
      );
}

/// The available error status
enum QuoteErrorStatus {
  /// No errors
  none,

  /// Generic error
  generic,

  /// Network error
  network,
}
