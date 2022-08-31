import 'package:bloc_test/bloc_test.dart';
import 'package:kwoti/domain_layer/abstracts/repositories/base_repository.dart';
import 'package:kwoti/domain_layer/cubits/quote_cubit.dart';
import 'package:kwoti/domain_layer/cubits/quote_state.dart';
import 'package:kwoti/domain_layer/model/quote.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockQuoteRepository1 extends Mock implements BaseRepository {}

class MockQuoteRepository2 extends Mock implements BaseRepository {}

class MockQuote extends Mock implements Quote {}

class TestQuoteCubit extends QuoteCubit {
  TestQuoteCubit({required super.repositories});

  @override
  BaseRepository get repository => repositories[0];
}

void main() {
  final quote1 = MockQuote();
  final quote2 = MockQuote();

  final repository1 = MockQuoteRepository1();
  final repository2 = MockQuoteRepository2();

  final List<BaseRepository> repositories = [
    repository1,
    repository2,
  ];

  late TestQuoteCubit cubit;

  setUp(
    () {
      cubit = TestQuoteCubit(repositories: repositories);

      when(
        repository1.getRandomQuote,
      ).thenAnswer(
        (_) async => quote1,
      );

      when(
        repository2.getRandomQuote,
      ).thenAnswer(
        (_) async => quote2,
      );
    },
  );

  blocTest<QuoteCubit, QuoteState>(
    'Starts with empty state',
    build: () => cubit,
    verify: (c) => expect(
      c.state,
      const QuoteState(),
    ),
  );

  blocTest<QuoteCubit, QuoteState>(
    'Loads random quote, '
    'emits state with loaded quote',
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      const QuoteState(busy: true),
      QuoteState(
        quote: quote1,
        busy: false,
      )
    ],
    verify: (c) {
      verify(
        repository1.getRandomQuote,
      ).called(1);
    },
  );

  blocTest<QuoteCubit, QuoteState>(
    'Handles exceptions gracefully',
    setUp: () {
      /// Test case that throws Exception
      when(
        repository1.getRandomQuote,
      ).thenAnswer(
        (_) async => throw Exception('Some Error'),
      );
    },
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      const QuoteState(
        busy: true,
      ),
      const QuoteState(
        busy: false,
        errorStatus: QuoteErrorStatus.generic,
      )
    ],
    verify: (c) {
      verify(
        repository1.getRandomQuote,
      ).called(1);
    },
  );
}
