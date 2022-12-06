import 'package:flutter/material.dart';
import 'package:m_hike_flutter/pages/create_hike_page.dart';
import 'package:m_hike_flutter/pages/edit_hike.dart';
import 'package:m_hike_flutter/pages/photo_file.dart';
import 'package:m_hike_flutter/utils/dimens.dart';
import 'package:m_hike_flutter/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    Provider.of<MainViewModel>(context, listen: false).queryAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(paddingX16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Welcome to M-Hike",
                    style: TextStyle(
                        fontSize: fontHeadingSubTitle,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateNewHikePage())),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    child: const Text("Create Hike")
                  )
                ],
              ),
              SizedBox(height: marginX16),
              Consumer<MainViewModel>(
                builder: (context, mainViewModel, child) {
                  if (mainViewModel.alldata.isEmpty) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: marginX48),
                          child: const Text("No hikes data available.")),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: mainViewModel.alldata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(paddingX8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditHikePagePage(
                                        data: mainViewModel.alldata[index]))),
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () => mainViewModel.deleteItem(mainViewModel.alldata[index].id),
                                    icon: Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => PhotoPage(id: mainViewModel.alldata[index].id))),
                                    icon: Icon(Icons.add_photo_alternate),
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Hike Name: ",
                                    style: TextStyle(
                                      fontSize: fontBodyTextLarge,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                     "${mainViewModel.alldata[index].name}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Hike Location: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].location}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Hike Date: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].date}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "parking Available: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].parking}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Hike Length: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].length}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Level of Difficulty: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].difficulty}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Accommodation available: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].accommodation}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Person Limitation: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].personLimit}"
                                  )
                                ],
                              ),
                              SizedBox(height: marginX4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Description: ",
                                    style: TextStyle(
                                        fontSize: fontBodyTextLarge,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                      "${mainViewModel.alldata[index].description}"
                                  )
                                ],
                              ),
                            ],
                          )
                        );
                      },
                    ),
                  );
                },
              )
            ]
          )
        )
      )
    );
  }
}
