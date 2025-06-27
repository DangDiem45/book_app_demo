import 'package:book_app/features/book/data/models/books.dart';
import 'package:book_app/features/book/data/models/mapper.dart';

final bookModel = BookModel(
  kind: null,
  totalItems: null,
  items: [
    Items(
      id: '1',
      volumeInfo: VolumeInfo(
        title: 'Test Book',
        authors: ['Author'],
        publisher: 'Publisher',
        publishedDate: '2023-01-01',
        description: 'Description',
        pageCount: 100,
        averageRating: 4.5,
        ratingsCount: 10,
        imageLinks: ImageLinks(thumbnail: 'http://example.com/image.jpg'),
        categories: ['Programming'],
      ),
      saleInfo: SaleInfo(
        country: 'US',
        saleability: 'FOR_SALE',
        isEbook: true,
        listPrice: ListPrice(amount: 100000, currencyCode: 'VND'),
        retailPrice: ListPrice(amount: 300000, currencyCode: 'VND'),
        buyLink: 'http://example.com/buy',
      ),
    ),
  ],
);

final bookEntity = bookModel.toEntity();
