import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t3_books/home/bloc/books_bloc.dart';

class BookPage extends StatelessWidget {
  final Map<String, dynamic> book;
  const BookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  context.read<BooksBloc>().add(ShareBookEvent(book: book));
                }),
            Padding(padding: EdgeInsets.all(6))
          ],
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  book["cover"] != null
                      ? Image.network(
                          book["cover"],
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 3,
                        )
                      : Image.asset(
                          'assets/images/book_cover.jpg',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                  SizedBox(height: 30),
                  Text(
                    book["title"],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(book["publishedDate"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Pages: ${book["pages"]}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<BooksBloc>()
                          .add(ExpandBookDescriptionEvent());
                    },
                    child: Row(
                      children: [
                        Expanded(child: BlocBuilder<BooksBloc, BooksState>(
                            builder: (context, state) {
                          if (state is ExpandedBookDescriptionState) {
                            return Text(book["description"],
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                                textAlign: TextAlign.justify);
                          } else {
                            return Text(
                              book["description"],
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        })),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
