import 'package:flutter/material.dart';
import 'package:m_hike_flutter/helper/db_helper.dart';
import 'package:m_hike_flutter/helper/hike_model.dart';

class MainViewModel extends ChangeNotifier {

  final dbHelper = DatabaseHelper.instance;

  List<HikeModel> alldata = [];
  HikeModel? hikeModel;

  void insert(context, data, {callback}) async {
    try {
      final response = await dbHelper.insert(data);
      queryAll();
      if (callback != null) {
        callback();
      }
      _showSnackBar("Hike details added.", context);
    } catch(e) {
      _showSnackBar("Something went wrong. Try again later.", context);
    }
  }

  void queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    alldata.clear();
    for (var row in allRows) {
      alldata.add(HikeModel.fromMap(row));
    }
    notifyListeners();
  }

  _showSnackBar(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  deleteItem(id) async {
    final rowsDeleted = await dbHelper.delete(id);
    queryAll();
  }

  void update(BuildContext context, data) async {
    try {
      final rowsAffected = await dbHelper.update(data);
      queryAll();
      _showSnackBar("Hike details updated.", context);
    } catch(e) {
      _showSnackBar("Something went wrong. Try again later.", context);
    }
  }

  void saveImage(Map<String, Object?> data, context) async {
    try {
      final response = await dbHelper.insertImg(data);
      _showSnackBar("Image added.", context);
      queryAllImage();
    } catch(e) {
      _showSnackBar("Something went wrong. Try again later.", context);
    }
  }

  List<dynamic> imageData = [];
  void queryAllImage() async {
    imageData = [];
    final allRows = await dbHelper.queryAllImg();
    imageData = allRows;
    notifyListeners();
  }
}