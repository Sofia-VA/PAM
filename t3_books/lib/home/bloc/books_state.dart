part of 'books_bloc.dart';

@immutable
abstract class BooksState {}

class BooksInitial extends BooksState {}

class BookSearchingState extends BooksState {}

class BookFoundState extends BooksState {}

class BookNotFoundState extends BooksState {}

class ConnectivityErrorState extends BooksState {
  final String errorMsg;

  ConnectivityErrorState({required this.errorMsg});

  List<Object> get props => [errorMsg];
}
