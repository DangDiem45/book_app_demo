import 'package:book_app/features/book/domain/entities/books.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_bloc.dart';
import 'package:book_app/features/book/presentation/bloc/feature_books/feature_books_state.dart';
import 'package:book_app/features/book/presentation/widgets/home/feature_book_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../test_data.dart';
import '../../../mocks.dart';

void main() {
  late MockFeaturedBooksBloc mockFeaturedBooksBloc;
  late BookEntity bookEntityTest;
  late StreamController<FeaturedBooksState> controller;

  setUp(() {
    mockFeaturedBooksBloc = MockFeaturedBooksBloc();
    bookEntityTest = bookEntity;
    controller = StreamController<FeaturedBooksState>.broadcast();
    when(
      () => mockFeaturedBooksBloc.stream,
    ).thenAnswer((_) => controller.stream);
  });

  tearDown(() {
    controller.close();
  });

  Widget buildWidget({required bool isLargeScreen}) {
    return MaterialApp(
      home: BlocProvider<FeaturedBooksBloc>.value(
        value: mockFeaturedBooksBloc,
        child: FeaturedBooksListView(
          isLargeScreen: isLargeScreen,
          orientation: Orientation.portrait,
        ),
      ),
    );
  }

  testWidgets('displays loading indicator when state is FeaturedBooksLoading', (
    tester,
  ) async {
    when(() => mockFeaturedBooksBloc.state).thenReturn(FeaturedBooksLoading());
    controller.add(FeaturedBooksLoading());

    await tester.pumpWidget(buildWidget(isLargeScreen: false));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.text('Connection Timeout'), findsNothing);
  });

  testWidgets('displays books when state is FeaturedBooksSuccess', (
    tester,
  ) async {
    when(
      () => mockFeaturedBooksBloc.state,
    ).thenReturn(FeaturedBooksSuccess(bookEntityTest));
    controller.add(FeaturedBooksSuccess(bookEntityTest));

    await tester.pumpWidget(buildWidget(isLargeScreen: false));
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('displays error message when state is FeaturedBooksFailure', (
    tester,
  ) async {
    when(
      () => mockFeaturedBooksBloc.state,
    ).thenReturn(FeaturedBooksFailure('Connection Timeout'));
    controller.add(FeaturedBooksFailure('Connection Timeout'));

    await tester.pumpWidget(buildWidget(isLargeScreen: false));
    await tester.pumpAndSettle();

    expect(find.text('Connection Timeout'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('displays correctly for large screen', (tester) async {
    when(
      () => mockFeaturedBooksBloc.state,
    ).thenReturn(FeaturedBooksSuccess(bookEntityTest));
    controller.add(FeaturedBooksSuccess(bookEntityTest));

    await tester.pumpWidget(buildWidget(isLargeScreen: true));
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CachedNetworkImage &&
            widget.width == 150.0 &&
            widget.height == 250.0,
      ),
      findsOneWidget,
    );
  });
}
