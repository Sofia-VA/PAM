import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Map<String, dynamic> book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4.7,
            width: 100,
            alignment: Alignment.center,
            child: book["cover"] != null
                ? Image.network(book["cover"], fit: BoxFit.cover)
                : Image.asset('assets/images/book_cover.jpg',
                    fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Row(children: [
            Expanded(
                child: Text(book["title"],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0))),
          ])
        ],
      ),
    );
  }
}
