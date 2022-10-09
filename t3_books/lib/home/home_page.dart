import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:t3_books/home/book_page.dart';

import 'bloc/books_bloc.dart';
import 'book_card.dart';

class HomePage extends StatelessWidget {
  final searchController = TextEditingController();
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Free to play Library'),
        ),
        body: BlocConsumer<BooksBloc, BooksState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            print("BUILDING state: ${state}");
            return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BooksBloc>(context).add(
                                  SearchBookEvent(book: searchController.text));
                            }),
                        border: OutlineInputBorder(),
                        label: Text("Type book title"),
                      ),
                    ),
                    (state is BookFoundState)
                        ? SizedBox(height: 30)
                        : SizedBox(),
                    Expanded(
                      child: _getChild(context, state),
                    ),
                  ],
                ));
          },
        ));
  }

  Widget _getChild(context, state) {
    print("Getting child from: ${state}");
    if (state is BookSearchingState) {
      return _loadingView();
    } else if (state is BookFoundState) {
      return _booksResults(context, state.books);
    } else if (state is BookNotFoundState) {
      return Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset(
              'assets/images/books_stack.png',
              scale: 2.2,
            ),
            SizedBox(height: 20),
            Text("No book was found")
          ]),
        ),
      );
    } else if (state is ConnectivityErrorState) {
      return Center(child: Text(state.errorMsg));
    }

    return Center(child: Text("Type something to search book"));
  }

  Widget _loadingView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          PlayStoreShimmer(
            hasBottomSecondLine: false,
            beginAlign: Alignment.topRight,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          ),
          SizedBox(height: 20),
          PlayStoreShimmer(
            hasBottomSecondLine: false,
            beginAlign: Alignment.topRight,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          ),
          SizedBox(height: 20),
          PlayStoreShimmer(
            hasBottomSecondLine: false,
            beginAlign: Alignment.topRight,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          ),
        ],
      ),
    );
  }

  GridView _booksResults(context, books) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.5),
      ),
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookPage(book: books[index])));
            },
            child: BookCard(book: books[index]));
      },
    );
  }
}
