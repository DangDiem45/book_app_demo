import 'package:book_app/features/book/domain/usecases/fetch_feature_book.dart';
import 'package:book_app/features/book/domain/usecases/fetch_newest_book.dart';
import 'package:book_app/features/book/domain/usecases/fetch_similar_book.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../test_data.dart';

void main() {
  late MockBookRepository mockBookRepository;
  late FetchNewestBooks fetchNewestBooks;
  late FetchFeaturedBooks fetchFeaturedBooks;
  late FetchSimilarBooks fetchSimilarBooks;

  setUp(() {
    mockBookRepository = MockBookRepository();
    fetchNewestBooks = FetchNewestBooks(mockBookRepository);
    fetchFeaturedBooks = FetchFeaturedBooks(mockBookRepository);
    fetchSimilarBooks = FetchSimilarBooks(mockBookRepository);
  });

  group('FetchNewestBooks UseCase', () {
    test('should call repository and return BookEntity', () async {
      // Arrange
      when(
        () => mockBookRepository.fetchNewestBooks(startIndex: 0),
      ).thenAnswer((_) async => Right(bookEntity));

      // Act
      final result = await fetchNewestBooks(startIndex: 0);

      // Assert
      expect(result, Right(bookEntity));
      verify(
        () => mockBookRepository.fetchNewestBooks(startIndex: 0),
      ).called(1);
    });
  });

  group('FetchFeaturedBooks UseCase', () {
    test('should call repository and return BookEntity', () async {
      // Arrange
      when(
        () => mockBookRepository.fetchFeaturedBooks(),
      ).thenAnswer((_) async => Right(bookEntity));

      // Act
      final result = await fetchFeaturedBooks();

      // Assert
      expect(result, Right(bookEntity));
      verify(() => mockBookRepository.fetchFeaturedBooks()).called(1);
    });
  });

  group('FetchSimilarBooks UseCase', () {
    test('should call repository and return BookEntity', () async {
      // Arrange
      when(
        () => mockBookRepository.fetchSimilarBooks(categories: 'Programming'),
      ).thenAnswer((_) async => Right(bookEntity));

      // Act
      final result = await fetchSimilarBooks(categories: 'Programming');

      // Assert
      expect(result, Right(bookEntity));
      verify(
        () => mockBookRepository.fetchSimilarBooks(categories: 'Programming'),
      ).called(1);
    });
  });
}
