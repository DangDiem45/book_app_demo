import 'package:book_app/core/constant/constants.dart';
import 'package:book_app/core/error/failures.dart';
import 'package:book_app/core/util/service_locator.dart';
import 'package:book_app/features/book/data/models/books.dart';
import 'package:book_app/features/book/data/repository/book_repository_impl.dart';
import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../test_data.dart';

void main() {
  late MockBooksApiService mockBooksApiService;
  late MockBookCacheService mockBookCacheService;
  late BookRepositoryImpl bookRepository;

  setUpAll(() {
    registerFallbackValue(BookModel());
    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() {
    mockBooksApiService = MockBooksApiService();
    mockBookCacheService = MockBookCacheService();
    bookRepository = BookRepositoryImpl(mockBooksApiService);
    getIt.registerSingleton<BookCacheService>(mockBookCacheService);
  });

  tearDown(() {
    getIt.reset();
  });

  group('BookRepositoryImpl', () {
    group('fetchNewestBooks', () {
      test('should return BookEntity when API call is successful', () async {
        // Arrange
        when(
          () => mockBooksApiService.getBooks(
            query: 'programming',
            filtering: 'free-ebooks',
            sorting: 'newest',
            startIndex: 0,
            apiKey: bookApiKey,
          ),
        ).thenAnswer((_) async => bookModel);
        when(
          () =>
              mockBookCacheService.saveBooksToCache(any(), key: 'newest_book'),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await bookRepository.fetchNewestBooks(startIndex: 0);

        // Assert
        expect(result, equals(Right<Failure, BookEntity>(bookEntity)));
        verify(
          () => mockBooksApiService.getBooks(
            query: 'programming',
            filtering: 'free-ebooks',
            sorting: 'newest',
            startIndex: 0,
            apiKey: bookApiKey,
          ),
        ).called(1);
        verify(
          () => mockBookCacheService.saveBooksToCache(
            bookModel,
            key: 'newest_book',
          ),
        ).called(1);
      });

      test('should return cached data when API call fails', () async {
        // Arrange
        when(
          () => mockBooksApiService.getBooks(
            query: 'programming',
            filtering: 'free-ebooks',
            sorting: 'newest',
            startIndex: 0,
            apiKey: bookApiKey,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );
        when(
          () => mockBookCacheService.getBooksFromCache(key: 'newest_book'),
        ).thenAnswer((_) async => bookModel);

        // Act
        final result = await bookRepository.fetchNewestBooks(startIndex: 0);

        // Assert
        expect(result, equals(Right<Failure, BookEntity>(bookEntity)));
        verify(
          () => mockBookCacheService.getBooksFromCache(key: 'newest_book'),
        ).called(1);
      });

      test(
        'should return ServerFailure when API call fails and no cache is available',
        () async {
          // Arrange
          when(
            () => mockBooksApiService.getBooks(
              query: 'programming',
              filtering: 'free-ebooks',
              sorting: 'newest',
              startIndex: 0,
              apiKey: bookApiKey,
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.connectionTimeout,
            ),
          );
          when(
            () => mockBookCacheService.getBooksFromCache(key: 'newest_book'),
          ).thenAnswer((_) async => null);

          // Act
          final result = await bookRepository.fetchNewestBooks(startIndex: 0);

          // Assert
          expect(
            result,
            equals(
              Left<Failure, BookEntity>(ServerFailure('Connection Timeout')),
            ),
          );
        },
      );
    });

    group('fetchFeaturedBooks', () {
      test('should return BookEntity when API call is successful', () async {
        // Arrange
        when(
          () => mockBooksApiService.getBooks(
            query: 'computer science',
            filtering: 'free-ebooks',
            sorting: null,
            startIndex: null,
            apiKey: bookApiKey,
          ),
        ).thenAnswer((_) async => bookModel);
        when(
          () =>
              mockBookCacheService.saveBooksToCache(any(), key: 'feature_book'),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await bookRepository.fetchFeaturedBooks();

        // Assert
        expect(result, equals(Right<Failure, BookEntity>(bookEntity)));
        verify(
          () => mockBooksApiService.getBooks(
            query: 'computer science',
            filtering: 'free-ebooks',
            sorting: null,
            startIndex: null,
            apiKey: bookApiKey,
          ),
        ).called(1);
        verify(
          () => mockBookCacheService.saveBooksToCache(
            bookModel,
            key: 'feature_book',
          ),
        ).called(1);
      });
    });

    group('fetchSimilarBooks', () {
      test('should return BookEntity when API call is successful', () async {
        // Arrange
        when(
          () => mockBooksApiService.getBooks(
            query: 'Subject:Programming',
            filtering: 'free-ebooks',
            sorting: 'relevance',
            startIndex: null,
            apiKey: bookApiKey,
          ),
        ).thenAnswer((_) async => bookModel);
        when(
          () =>
              mockBookCacheService.saveBooksToCache(any(), key: 'similar_book'),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await bookRepository.fetchSimilarBooks(
          categories: 'Programming',
        );

        // Assert
        expect(result, equals(Right<Failure, BookEntity>(bookEntity)));
        verify(
          () => mockBooksApiService.getBooks(
            query: 'Subject:Programming',
            filtering: 'free-ebooks',
            sorting: 'relevance',
            startIndex: null,
            apiKey: bookApiKey,
          ),
        ).called(1);
        verify(
          () => mockBookCacheService.saveBooksToCache(
            bookModel,
            key: 'similar_book',
          ),
        ).called(1);
      });
    });
  });
}
