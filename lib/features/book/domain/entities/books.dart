import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String? kind;
  final num? totalItems;
  final List<BookItemsEntity>? items;

  const BookEntity({this.kind, this.totalItems, this.items});

  @override
  List<Object?> get props => [kind, totalItems, items];
}

class BookItemsEntity extends Equatable {
  final String? id;
  final VolumeInfoEntity? volumeInfo;
  final SaleInfoEntity? saleInfo;

  const BookItemsEntity({this.id, this.volumeInfo, this.saleInfo});

  @override
  List<Object?> get props => [id, volumeInfo, saleInfo];
}

class VolumeInfoEntity extends Equatable {
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final num? pageCount;
  final num? averageRating;
  final num? ratingsCount;
  final ImageLinksEntity? imageLinks;
  final List<String>? categories;

  const VolumeInfoEntity({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.averageRating,
    this.ratingsCount,
    this.imageLinks,
    this.categories,
  });

  @override
  List<Object?> get props => [
    title,
    authors,
    publisher,
    publishedDate,
    description,
    pageCount,
    averageRating,
    ratingsCount,
    imageLinks,
    categories,
  ];
}

class ImageLinksEntity extends Equatable {
  final String? thumbnail;

  const ImageLinksEntity({this.thumbnail});

  @override
  List<Object?> get props => [thumbnail];
}

class SaleInfoEntity extends Equatable {
  final String? country;
  final String? saleability;
  final bool? isEbook;
  final ListPriceEntity? listPrice;
  final ListPriceEntity? retailPrice;
  final String? buyLink;

  const SaleInfoEntity({
    this.country,
    this.saleability,
    this.isEbook,
    this.listPrice,
    this.retailPrice,
    this.buyLink,
  });

  @override
  List<Object?> get props => [
    country,
    saleability,
    isEbook,
    listPrice,
    retailPrice,
    buyLink,
  ];
}

class ListPriceEntity extends Equatable {
  final num? amount;
  final String? currencyCode;

  const ListPriceEntity({this.amount, this.currencyCode});

  @override
  List<Object?> get props => [amount, currencyCode];
}
