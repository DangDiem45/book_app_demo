import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:book_app/features/book/presentation/widgets/detail/books_detail_header_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BooksDetailHeaderView', () {
    testWidgets('displays book title and image', (WidgetTester tester) async {
      // Arrange
      final bookItems = BookItemsEntity(
        id: '1',
        volumeInfo: VolumeInfoEntity(
          title: 'Test Book',
          authors: ['Author'],
          imageLinks: ImageLinksEntity(
            thumbnail: 'http://example.com/image.jpg',
          ),
        ),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: BooksDetailHeaderView(bookItems: bookItems)),
        ),
      );

      // Assert
      expect(find.text('Test Book'), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.text('Author'), findsOneWidget);
    });

    testWidgets('displays default title when no title is provided', (
      WidgetTester tester,
    ) async {
      // Arrange
      final bookItems = BookItemsEntity(
        id: '1',
        volumeInfo: VolumeInfoEntity(
          title: null,
          authors: ['Author'],
          imageLinks: ImageLinksEntity(
            thumbnail: 'http://example.com/image.jpg',
          ),
        ),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: BooksDetailHeaderView(bookItems: bookItems)),
        ),
      );

      // Assert
      expect(find.text('No Title'), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
