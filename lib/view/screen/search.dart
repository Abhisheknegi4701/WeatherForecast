
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/utill/globalmethod.dart';

import '../../data/repository/mainrepository.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key, required this.repository});
  final Repository repository;

  static Route<void> route(Repository repository) {
    return MaterialPageRoute<void>(builder: (_) => CitySearch(repository: repository));
  }

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            openHomeEvent(context, HomePageMainEvent());
          },
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.black,),
        ),
        title: Column(
          children: [
            Text(AppConstants.appNAME, style: TextStyle(color: ColorResources.getBlackColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),),
          ],
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onSubmitted: (value){
                  openHomeEvent(context, HomePageLoadingEvent(locality: searchController.text));
                },
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
