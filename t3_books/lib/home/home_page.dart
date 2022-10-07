import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/books_bloc.dart';

class HomePage extends StatelessWidget {
  final searchController = TextEditingController();
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Librería free to play'),
        ),
        body: BlocConsumer<BooksBloc, BooksState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: () {}),
                        border: OutlineInputBorder(),
                        label: Text("Ingresa título"),
                      ),
                    ),
                    Expanded(
                      child: _getChild(state),
                    ),
                  ],
                ));
          },
        ));
  }

  Widget _getChild(state) {
    if (state is BookSearchingState) {
      _loadingView();
    } else if (state is BookFoundState) {
      _booksResult();
    } else if (state is BookNotFoundState) {
      return Center(child: Text("No book was found"));
    } else if (state is ConnectivityErrorState) {
      return Center(child: Text(state.errorMsg));
    }

    return Center(child: Text("Type something to search book"));
  }

  Widget _loadingView() {
    return Center(child: Text("Loading"));
  }

  Widget _booksResult() {
    return Center();
  }
}
