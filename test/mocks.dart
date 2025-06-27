import 'package:book_app/core/util/service_locator.dart';
import 'package:book_app/features/book/data/data_source/books_api_service.dart';
import 'package:book_app/features/book/domain/repository/book_repository.dart';
import 'package:book_app/features/book/domain/usecases/fetch_newest_book.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes
class MockBooksApiService extends Mock implements BooksApiService {}

class MockBookCacheService extends Mock implements BookCacheService {}

class MockBookRepository extends Mock implements BookRepository {}

class MockDio extends Mock implements Dio {}

class MockGoRouter extends Mock implements GoRouter {
  @override
  GoRouteInformationProvider get routeInformationProvider =>
      MockGoRouteInformationProvider();
}

class MockGoRouteInformationProvider extends Mock
    implements GoRouteInformationProvider {}

class MockRouteInformationProvider extends Mock
    implements RouteInformationProvider {}

class MockFetchNewestBooks extends Mock implements FetchNewestBooks {}

class MockFeaturedBooksBloc extends Mock implements FeaturedBooksBloc {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockCachedNetworkImageProvider extends Mock implements ImageProvider {}
