import 'package:book_app/features/book/domain/entities/books.dart';
import 'package:equatable/equatable.dart';

abstract class NewestBooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewestBooksInitial extends NewestBooksState {}

class NewestBooksLoading extends NewestBooksState {}

class NewestBooksSuccess extends NewestBooksState {
  final BookEntity books;

  NewestBooksSuccess(this.books);

  @override
  List<Object?> get props => [books];
}

class NewestBooksFailure extends NewestBooksState {
  final String error;

  NewestBooksFailure(this.error);

  @override
  List<Object?> get props => [error];
}
