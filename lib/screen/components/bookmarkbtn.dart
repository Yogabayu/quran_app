import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Bookmarkbtn extends StatefulWidget {
  final String nameSurah;
  final int noSurah;
  final int? noayat;
  final bool isSave;
  const Bookmarkbtn({
    Key? key,
    required this.nameSurah,
    required this.noSurah,
    required this.noayat,
    required this.isSave,
  }) : super(key: key);

  @override
  _BookmarkbtnState createState() => _BookmarkbtnState();
}

class _BookmarkbtnState extends State<Bookmarkbtn> {
  final storage = GetStorage();
  bool _isSave = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isSave = widget.isSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        try {
          if (_isSave) {
            storage.remove('name');
            storage.remove('id');
            storage.remove('noayat');
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Sukses"),
              ),
            );
            setState(() {
              _isSave = false;
            });
          } else {
            storage.write('name', widget.nameSurah);
            storage.write('id', widget.noSurah);
            storage.write('noayat', widget.noayat);
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Sukses menyimpan"),
              ),
            );
            setState(() {
              _isSave = true;
            });
          }
        } catch (e) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${e}"),
            ),
          );
        }
      },
      icon: _isSave
          ? Icon(
              Icons.bookmark_add,
              color: Colors.blue,
            )
          : Icon(
              Icons.bookmark_add,
              color: Colors.white,
            ),
    );
  }
}
