import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:equatable/equatable.dart';

abstract class FeaturedBooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeaturedBooksInitial extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksSuccess extends FeaturedBooksState {
  final BookEntity books;

  FeaturedBooksSuccess(this.books);

  @override
  List<Object?> get props => [books];
}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String error;

  FeaturedBooksFailure(this.error);

  @override
  List<Object?> get props => [error];
}
