import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:t3_books/home/repositories/GoogleBooks_repo.dart';
import 'package:t3_books/utils/exceptions.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<SearchBookEvent>(_searchBook);
  }

  FutureOr<void> _searchBook(
      SearchBookEvent event, Emitter<BooksState> emit) async {
    if (event.book.isEmpty) {
      emit(BooksInitial());
      return;
    }

    emit(BookSearchingState());

    try {
      List<dynamic> _books =
          (await GoogleBooksRequest().searchBook(event.book));
      print('Books found: ${_books.length}');

      emit(BookFoundState(books: _books));
    } on NoBookFoundEx {
      emit(BookNotFoundState());
    } on ConnectivityErrorEx catch (e) {
      emit(ConnectivityErrorState(errorMsg: "${e}"));
    }
  }
}
