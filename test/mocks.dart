import 'package:book_app/core/util/service_locator.dart';
import 'package:book_app/features/book/data/data_source/books_api_service.dart';
import 'package:book_app/features/book/domain/repository/book_repository.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes
class MockBooksApiService extends Mock implements BooksApiService {}

class MockBookCacheService extends Mock implements BookCacheService {}

class MockBookRepository extends Mock implements BookRepository {}

class MockDio extends Mock implements Dio {}

class MockSharedPreferences extends Mock implements SharedPreferences {}
