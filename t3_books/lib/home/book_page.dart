import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BookPage extends StatefulWidget {
  final Map<String, dynamic> book;
  BookPage({super.key, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  bool expand = false;
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
                  Share.share(
                      "Check out ${widget.book["title"]}! pages: ${widget.book["pages"]}");
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
                  widget.book["cover"] != null
                      ? Image.network(
                          widget.book["cover"],
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
                    widget.book["title"],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.book["publishedDate"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Pages: ${widget.book["pages"]}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      expand = !expand;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Expanded(child: _toggleDescription()),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  _toggleDescription() {
    if (expand == true) {
      return Text(widget.book["description"],
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          textAlign: TextAlign.justify);
    } else {
      return Text(
        widget.book["description"],
        style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        textAlign: TextAlign.justify,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
