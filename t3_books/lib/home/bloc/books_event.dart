part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {}

class SearchBookEvent extends BooksEvent {
  final String book;

  SearchBookEvent({required this.book});
  List<Object> get props => [book];
}

class BookDetailsEvent extends BooksEvent {
  final String book;

  BookDetailsEvent({required this.book});
  List<Object> get props => [book];
}
