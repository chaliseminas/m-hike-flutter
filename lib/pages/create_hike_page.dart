import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_hike_flutter/helper/db_helper.dart';
import 'package:m_hike_flutter/utils/colors.dart';
import 'package:m_hike_flutter/utils/dimens.dart';
import 'package:m_hike_flutter/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

class CreateNewHikePage extends StatefulWidget {
  CreateNewHikePage({Key? key}) : super(key: key);

  @override
  State<CreateNewHikePage> createState() => _CreateNewHikePageState();
}

class _CreateNewHikePageState extends State<CreateNewHikePage> {

  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _locationTextEditingController = TextEditingController();
  final TextEditingController _hikeDateTextEditingController = TextEditingController();
  final TextEditingController _parkingAvailableTextEditingController = TextEditingController();
  final TextEditingController _lengthTextEditingController = TextEditingController();
  final TextEditingController _difficultyTextEditingController = TextEditingController();
  final TextEditingController _accommodationTextEditingController = TextEditingController();
  final TextEditingController _personLimitTextEditingController = TextEditingController();
  final TextEditingController _descriptionTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add hike details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingX16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameTextEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: greyColor,
                  border: InputBorder.none,
                  hintText: "Hike name"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _locationTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Hike location"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _hikeDateTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Hike date"
                ),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now().add(const Duration(days: 365 * 10))
                  );
                  if(pickedDate != null ){
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _hikeDateTextEditingController.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _parkingAvailableTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Parking available"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _lengthTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Hike length"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _difficultyTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Level of difficulty"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _accommodationTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Accommodation available"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _personLimitTextEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Person limitation"
                ),
              ),
              SizedBox(height: marginX8),
              TextFormField(
                controller: _descriptionTextEditingController,
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    border: InputBorder.none,
                    hintText: "Description",
                ),
              ),
              SizedBox(height: marginX16),
              InkWell(
                onTap: () => handleDataSave(),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: whiteColor
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  handleDataSave() {
    String name = _nameTextEditingController.text.toString();
    String location = _locationTextEditingController.text.toString();
    String hikeDate = _hikeDateTextEditingController.text.toString();
    String parkAvailable = _parkingAvailableTextEditingController.text.toString();
    String length = _lengthTextEditingController.text.toString();
    String difficulty = _difficultyTextEditingController.text.toString();
    String accommodation = _accommodationTextEditingController.text.toString();
    String personLimit = _personLimitTextEditingController.text.toString();
    String description = _descriptionTextEditingController.text.toString();

    if (name.isEmpty) {
      _showSnackBar("Please Enter Hike Name");
    } else if (location.isEmpty) {
      _showSnackBar("Please Enter Hike Location");
    } else if (hikeDate.isEmpty) {
      _showSnackBar("Please Enter Hike date");
    } else if (parkAvailable.isEmpty) {
      _showSnackBar("Please Enter Parking available");
    } else if (length.isEmpty) {
      _showSnackBar("Please Enter Hike Length");
    } else if (difficulty.isEmpty) {
      _showSnackBar("Please Enter Hike difficulty.");
    } else if (accommodation.isEmpty) {
      _showSnackBar("Please Enter Accommodation Available.");
    } else if (personLimit.isEmpty) {
      _showSnackBar("Please Enter Hike Person limitation.");
    } else {
      var data = {
        DatabaseHelper.columnName: name,
        DatabaseHelper.columnLocation: location,
        DatabaseHelper.columnDate: hikeDate,
        DatabaseHelper.columnParking: parkAvailable,
        DatabaseHelper.columnLength: length,
        DatabaseHelper.columnDifficulty: difficulty,
        DatabaseHelper.columnAccommodation: accommodation,
        DatabaseHelper.columnPersonLimit: personLimit,
        DatabaseHelper.columnDescription: description,
      };
      Provider.of<MainViewModel>(context, listen: false).insert(context, data, callback: callback);
    }
  }

  callback() {
    _nameTextEditingController.clear();
    _locationTextEditingController.clear();
    _hikeDateTextEditingController.clear();
    _parkingAvailableTextEditingController.clear();
    _lengthTextEditingController.clear();
    _difficultyTextEditingController.clear();
    _accommodationTextEditingController.clear();
    _personLimitTextEditingController.clear();
    _descriptionTextEditingController.clear();
  }

  _showSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    ));
  }
}