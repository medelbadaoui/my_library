import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  BookItem(
      {this.id,
      this.title,
      this.author,
      this.categorie,
      this.image,
      this.onClick});
  final String id;
  final String author;
  final String title;
  final String image;
  final String categorie;

  Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: (Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.white,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.green,
                offset: const Offset(0, 0),
                blurRadius: 0.1,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: const Offset(0, 0),
                      blurRadius: 1.1,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                height: 130,
                width: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          author,
                          style: TextStyle(color: Colors.black45, fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 0),
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                      ),
                      Container(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        padding: EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 10),
                        margin: EdgeInsets.only(top: 0),
                      ),
                      Container(
                        color: Color(0xFFD8F2E6),
                        child: Text(
                          categorie,
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
