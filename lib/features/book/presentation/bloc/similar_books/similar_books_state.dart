import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:equatable/equatable.dart';

abstract class SimilarBooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SimilarBooksInitial extends SimilarBooksState {}

class SimilarBooksLoading extends SimilarBooksState {}

class SimilarBooksSuccess extends SimilarBooksState {
  final BookEntity books;

  SimilarBooksSuccess(this.books);

  @override
  List<Object?> get props => [books];
}

class SimilarBooksFailure extends SimilarBooksState {
  final String error;

  SimilarBooksFailure(this.error);

  @override
  List<Object?> get props => [error];
}
