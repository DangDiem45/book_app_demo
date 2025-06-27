import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:book_app/features/book/presentation/widgets/home/best_seller_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../test_data.dart';

void main() {
  late BookItemsEntity bookItem;

  setUp(() {
    bookItem = bookEntity.items!.first;
  });

  Widget buildWidget({
    required BookItemsEntity bookItems,
    bool isLargeScreen = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BestSellerListViewItem(
          bookItems: bookItems,
          isLargeScreen: isLargeScreen,
        ),
      ),
    );
  }

  testWidgets('displays book details correctly for small screen', (
    tester,
  ) async {
    await tester.pumpWidget(buildWidget(bookItems: bookItem));
    await tester.pumpAndSettle();

    expect(find.text('Test Book'), findsOneWidget);
    expect(find.text('Author'), findsOneWidget);
    expect(find.text('100000 VND'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('(10)'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.star), findsOneWidget);
  });

  testWidgets('displays book details correctly for large screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildWidget(bookItems: bookItem, isLargeScreen: true),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test Book'), findsOneWidget);
    expect(find.text('Author'), findsOneWidget);
    expect(find.text('100000 VND'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('(10)'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.star), findsOneWidget);
  });

  testWidgets('displays fallback for null values', (tester) async {
    final bookItemWithNulls = BookItemsEntity(
      id: '1',
      volumeInfo: VolumeInfoEntity(
        title: null,
        authors: null,
        publisher: null,
        publishedDate: null,
        description: null,
        pageCount: null,
        averageRating: null,
        ratingsCount: null,
        imageLinks: ImageLinksEntity(thumbnail: 'invalid_url'),
        categories: null,
      ),
      saleInfo: null,
    );

    await tester.pumpWidget(buildWidget(bookItems: bookItemWithNulls));
    await tester.pumpAndSettle();

    expect(find.text('Unknown Author'), findsOneWidget);
    expect(find.text('Free'), findsOneWidget);
    expect(find.text('0.0'), findsOneWidget);
    expect(find.text('(0)'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
