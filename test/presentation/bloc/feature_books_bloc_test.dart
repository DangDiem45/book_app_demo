import 'package:book_app/core/error/failures.dart';
import 'package:book_app/features/book/domain/usecases/fetch_feature_book.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_bloc.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_event.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_data.dart';

void main() {
  late MockFetchFeaturedBooks mockFetchFeaturedBooks;
  late FeaturedBooksBloc featuredBooksBloc;

  setUp(() {
    mockFetchFeaturedBooks = MockFetchFeaturedBooks();
    featuredBooksBloc = FeaturedBooksBloc(mockFetchFeaturedBooks);
  });

  tearDown(() {
    featuredBooksBloc.close();
  });

  group('FeaturedBooksBloc', () {
    test('initial state is FeaturedBooksInitial', () {
      expect(featuredBooksBloc.state, FeaturedBooksInitial());
    });

    test(
      'emits [Loading, Success] when FetchFeaturedBooksEvent is successful',
      () async {
        // Arrange
        when(
          () => mockFetchFeaturedBooks(),
        ).thenAnswer((_) async => Right(bookEntity));

        // Act
        featuredBooksBloc.add(FetchFeaturedBooksEvent());

        // Assert
        await expectLater(
          featuredBooksBloc.stream,
          emitsInOrder([
            FeaturedBooksLoading(),
            FeaturedBooksSuccess(bookEntity),
          ]),
        );
        verify(() => mockFetchFeaturedBooks()).called(1);
      },
    );

    test(
      'emits [Loading, Failure] when FetchFeaturedBooksEvent fails',
      () async {
        // Arrange
        when(
          () => mockFetchFeaturedBooks(),
        ).thenAnswer((_) async => Left(ServerFailure('Connection Timeout')));

        // Act
        featuredBooksBloc.add(FetchFeaturedBooksEvent());

        // Assert
        await expectLater(
          featuredBooksBloc.stream,
          emitsInOrder([
            FeaturedBooksLoading(),
            FeaturedBooksFailure('Connection Timeout'),
          ]),
        );
        verify(() => mockFetchFeaturedBooks()).called(1);
      },
    );
  });
}

class MockFetchFeaturedBooks extends Mock implements FetchFeaturedBooks {}
