part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {}

class SearchBookEvent extends BooksEvent {
  final String book;

  SearchBookEvent({required this.book});
  List<Object> get props => [book];
}

class ExpandBookDescriptionEvent extends BooksEvent {}

class ShareBookEvent extends BooksEvent {
  final Map<String, dynamic> book;

  ShareBookEvent({required this.book});
  List<Object> get props => [book];
}
