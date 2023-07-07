import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controller/hadistController.dart';
import 'package:quran_app/model/booksHadistModel.dart';
import 'package:quran_app/screen/dashboard.dart';
import 'package:quran_app/screen/hadist/detailhadist.dart';

class Hadist extends StatefulWidget {
  const Hadist({Key? key}) : super(key: key);

  @override
  _HadistState createState() => _HadistState();
}

class _HadistState extends State<Hadist> {
  List<Data> filteredList = <Data>[];
  List<Data> gettedList = <Data>[];
  final HadistController _booksController = Get.put(HadistController());
  late Future<BooksHadist> futureBooks;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureBooks = _booksController.getBooks();
    futureBooks.then((value) {
      value.data!.forEach((element) {
        setState(() {
          filteredList.add(element);
          gettedList.add(element);
        });
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => Dashboard(),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
        );
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 219, 235, 240),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: width * 0.1,
              ),
              header(height, width, context),
              spacer(height),
              Container(
                width: width * 0.86,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
                ),
                child: TextField(
                  onChanged: (value) async {
                    var text = value.toString().toLowerCase();
                    filteredList.clear();
                    gettedList.forEach(
                      (element) {
                        if (element.name!.contains(text)) {
                          setState(() {
                            filteredList.add(element);
                          });
                        }
                      },
                    );
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'Cari Mudawwin atau Ahli Hadist ',
                  ),
                ),
              ),
              filteredList.isEmpty || filteredList.length == 0
                  ? Container(
                      margin: EdgeInsets.only(top: width * 0.2),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: width * 0.86,
                      height: height * 0.75,
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return listPHadist(
                              width,
                              height,
                              index + 1,
                              filteredList[index].name,
                              filteredList[index].available,
                              filteredList[index].id);
                        },
                      ),
                    )
            ],
          )),
    );
  }
}

Widget listPHadist(width, height, index, name, available, id) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    onTap: () {
      Get.offAll(
        () => Detailhadist(
          id: id,
          first: "1",
          second: "100",
        ),
        transition: Transition.fade,
        duration: Duration(seconds: 1),
      );
    },
    leading: Stack(
      children: [
        Image.asset(
          'assets/frame.png',
          width: width * 0.2,
        ),
        if (index < 10)
          Positioned(
            left: width * 0.09,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          ),
        if (index >= 10 && index < 100)
          Positioned(
            left: width * 0.082,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          ),
        if (index >= 100)
          Positioned(
            left: width * 0.07,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          )
      ],
    ),
    title: Text(
      name,
      style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      "Tersedia: ${available}",
      style: TextStyle(
        fontSize: width * 0.03,
        color: Color.fromARGB(120, 3, 3, 3),
      ),
    ),
  );
}

Widget spacer(height) {
  return SizedBox(
    height: height * 0.04,
  );
}

Widget header(height, width, context) {
  return Container(
    margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 219, 235, 240),
      borderRadius: BorderRadius.all(Radius.circular(width * 0.025)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // Offset of the shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: IconButton(
            icon: Icon(
              Icons.home_outlined,
              size: width * 0.08,
              color: Color.fromRGBO(32, 105, 95, 1),
            ),
            onPressed: () {
              Get.offAll(
                () => Dashboard(),
                transition: Transition.fade,
                duration: Duration(seconds: 1),
              );
            },
          ),
        ),
        Text(
          'myQuran',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(33, 139, 95, 1),
          ),
        ),
        SizedBox(
          width: width * 0.08,
        )
      ],
    ),
  );
}
