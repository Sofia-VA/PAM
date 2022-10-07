part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {}

class SearchBookEvent extends BooksEvent {}

class BookDetailsEvent extends BooksEvent {}
