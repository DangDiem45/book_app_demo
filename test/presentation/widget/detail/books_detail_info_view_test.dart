import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:book_app/features/book/presentation/widgets/detail/books_detail_info_view.dart';

import '../../../test_data.dart';

void main() {
  late BookItemsEntity bookItem;

  setUp(() {
    bookItem = bookEntity.items!.first;
  });

  Widget buildWidget({required BookItemsEntity bookItems}) {
    return MaterialApp(
      home: Scaffold(body: BooksDetailInfoView(bookItems: bookItems)),
    );
  }

  testWidgets('displays book details correctly', (tester) async {
    await tester.pumpWidget(buildWidget(bookItems: bookItem));
    await tester.pumpAndSettle();

    expect(find.text('Publisher: '), findsOneWidget);
    expect(find.text('Published: '), findsOneWidget);
    expect(find.text('Pages: '), findsOneWidget);

    expect(find.text('Publisher'), findsOneWidget);
    expect(find.text('2023-01-01'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);

    expect(find.text('Description'), findsNWidgets(2));
    expect(find.byIcon(Icons.business), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.menu_book), findsOneWidget);
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
        imageLinks: null,
        categories: null,
      ),
      saleInfo: null,
    );

    await tester.pumpWidget(buildWidget(bookItems: bookItemWithNulls));
    await tester.pumpAndSettle();

    expect(find.text('Publisher: '), findsOneWidget);
    expect(find.text('Published: '), findsOneWidget);
    expect(find.text('Pages: '), findsOneWidget);

    // Kiểm tra value fallback
    expect(find.text('Unknown'), findsNWidgets(3));
    expect(find.text('No description available.'), findsOneWidget);
    expect(find.byIcon(Icons.business), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.menu_book), findsOneWidget);
  });
}
