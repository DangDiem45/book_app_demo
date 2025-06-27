import 'package:book_app/core/error/failures.dart';
import 'package:book_app/features/book/domain/usecases/fetch_similar_book.dart';
import 'package:book_app/features/book/presentation/bloc/similar_books/similar_books_bloc.dart';
import 'package:book_app/features/book/presentation/bloc/similar_books/similar_books_event.dart';
import 'package:book_app/features/book/presentation/bloc/similar_books/similar_books_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_data.dart';

void main() {
  late MockFetchSimilarBooks mockFetchSimilarBooks;
  late SimilarBooksBloc similarBooksBloc;

  setUp(() {
    mockFetchSimilarBooks = MockFetchSimilarBooks();
    similarBooksBloc = SimilarBooksBloc(mockFetchSimilarBooks);
  });

  tearDown(() {
    similarBooksBloc.close();
  });

  group('SimilarBooksBloc', () {
    test('initial state is SimilarBooksInitial', () {
      expect(similarBooksBloc.state, equals(SimilarBooksInitial()));
    });

    test(
      'emits [Loading, Success] when FetchSimilarBooksEvent is successful',
      () async {
        // Arrange
        when(
          () => mockFetchSimilarBooks(categories: 'Programming'),
        ).thenAnswer((_) async => Right(bookEntity));

        // Act
        similarBooksBloc.add(FetchSimilarBooksEvent(categories: 'Programming'));

        // Assert
        await expectLater(
          similarBooksBloc.stream,
          emitsInOrder([
            equals(SimilarBooksLoading()),
            equals(SimilarBooksSuccess(bookEntity)),
          ]),
        );
        verify(
          () => mockFetchSimilarBooks(categories: 'Programming'),
        ).called(1);
      },
    );

    test(
      'emits [Loading, Failure] when FetchSimilarBooksEvent fails',
      () async {
        // Arrange
        when(
          () => mockFetchSimilarBooks(categories: 'Programming'),
        ).thenAnswer((_) async => Left(ServerFailure('Connection Timeout')));

        // Act
        similarBooksBloc.add(FetchSimilarBooksEvent(categories: 'Programming'));

        // Assert
        await expectLater(
          similarBooksBloc.stream,
          emitsInOrder([
            equals(SimilarBooksLoading()),
            equals(SimilarBooksFailure('Connection Timeout')),
          ]),
        );
        verify(
          () => mockFetchSimilarBooks(categories: 'Programming'),
        ).called(1);
      },
    );
  });
}

class MockFetchSimilarBooks extends Mock implements FetchSimilarBooks {}
