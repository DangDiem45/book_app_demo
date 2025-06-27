import 'package:book_app/core/error/failures.dart';
import 'package:book_app/features/book/domain/usecases/fetch_newest_book.dart';
import 'package:book_app/features/book/presentation/bloc/newest_books/newest_books_bloc.dart';
import 'package:book_app/features/book/presentation/bloc/newest_books/newest_books_event.dart';
import 'package:book_app/features/book/presentation/bloc/newest_books/newest_books_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_data.dart';

void main() {
  late MockFetchNewestBooks mockFetchNewestBooks;
  late NewestBooksBloc newestBooksBloc;

  setUp(() {
    mockFetchNewestBooks = MockFetchNewestBooks();
    newestBooksBloc = NewestBooksBloc(mockFetchNewestBooks);
  });

  tearDown(() {
    newestBooksBloc.close();
  });

  group('NewestBooksBloc', () {
    test('initial state is NewestBooksInitial', () {
      expect(newestBooksBloc.state, equals(NewestBooksInitial()));
    });

    test(
      'emits [Loading, Success] and updates loadedBooks when FetchNewestBooksEvent is successful',
      () async {
        // Arrange
        when(
          () => mockFetchNewestBooks(startIndex: 0),
        ).thenAnswer((_) async => Right(bookEntity));

        // Act
        newestBooksBloc.add(FetchNewestBooksEvent(startIndex: 0));

        // Assert
        await expectLater(
          newestBooksBloc.stream,
          emitsInOrder([
            equals(NewestBooksLoading()),
            equals(NewestBooksSuccess(bookEntity)),
          ]),
        );
        await untilCalled(() => mockFetchNewestBooks(startIndex: 0));
        expect(newestBooksBloc.loadedBooks, equals(bookEntity.items));
        expect(newestBooksBloc.startIndex, equals(10));
        verify(() => mockFetchNewestBooks(startIndex: 0)).called(1);
      },
    );

    test('emits [Loading, Failure] when FetchNewestBooksEvent fails', () async {
      // Arrange
      when(
        () => mockFetchNewestBooks(startIndex: 0),
      ).thenAnswer((_) async => Left(ServerFailure('Connection Timeout')));

      // Act
      newestBooksBloc.add(FetchNewestBooksEvent(startIndex: 0));

      // Assert
      await expectLater(
        newestBooksBloc.stream,
        emitsInOrder([
          equals(NewestBooksLoading()),
          equals(NewestBooksFailure('Connection Timeout')),
        ]),
      );
      verify(() => mockFetchNewestBooks(startIndex: 0)).called(1);
    });
  });
}

class MockFetchNewestBooks extends Mock implements FetchNewestBooks {}
