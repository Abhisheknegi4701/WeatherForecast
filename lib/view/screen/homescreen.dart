
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../bloc/home/home_event.dart';
import '../../data/model/weather.dart';
import '../../data/model/weekweather.dart';
import '../../data/repository/mainrepository.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/globalmethod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository, required this.locality, required this.weatherData, required this.weekWeatherData});
  final Repository repository;
  final String locality;
  final WeatherData weatherData;
  final WeekWeathers weekWeatherData;

  static Route<void> route(String locality, Repository repository, WeatherData weatherData, WeekWeathers weekWeatherData) {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen(repository: repository, locality: locality, weatherData: weatherData, weekWeatherData: weekWeatherData,));
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat format = DateFormat.yMd().add_Hms();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            openHomeEvent(context, const HomePageSearchEvent());
          },
          icon: const Icon(Icons.search, color: Colors.black,),
        ),
        title: Column(
          children: [
            Text(AppConstants.appNAME, style: TextStyle(color: ColorResources.getBlackColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),),
            Text(widget.weatherData.name ?? widget.locality, style: TextStyle(color: ColorResources.getBlackColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
                widget.repository.logOut();
              },
              icon: const Icon(Icons.logout, color: Colors.black,),
          ),
        ],
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: TextField(
            //     onChanged: (value) async {
            //       homeProvider.city = value;
            //       homeProvider.getWeather();
            //     },
            //     onSubmitted: (value){
            //       homeProvider.city = value;
            //       homeProvider.getWeather();
            //     },
            //     controller: homeProvider.searchController,
            //     decoration: const InputDecoration(
            //         labelText: "Search",
            //         hintText: "Search",
            //         prefixIcon: Icon(Icons.search),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            //   ),
            // ),
            if(widget.weatherData.name != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Column(
                  children: [
                    Image.network(
                      "${AppConstants.getIcon}${widget.weatherData.weather![0].icon}.png",
                      width: 100, height: 100, fit: BoxFit.fill,
                      errorBuilder: (a,b,c){
                        return const Icon(Icons.image, size: 80,);
                      },
                    ),
                    Text("${widget.weatherData.weather![0].description}".toUpperCase(), style: TextStyle(color: ColorResources.getBlackColor(context),
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    weatherCircleBox("Temperature", const Icon(Icons.cloud, size: 30,), "${(double.parse(widget.weatherData.main!.temp!) - AppConstants.kelvin).round()}${AppConstants.degree}"),
                    weatherCircleBox("Feels Like", const Icon(Icons.cloud, size: 30,), "${(double.parse(widget.weatherData.main!.feelsLike!) - AppConstants.kelvin).toInt()}${AppConstants.degree}"),
                  ],
                ),
                const SizedBox(height: 10,),
                if(widget.weekWeatherData.list != null)
                  dailyWeatherList(widget.weekWeatherData),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherBox("Max Temperature", const Row(
                      children: [
                        Icon(Icons.cloud, size: 30, color: Colors.red,),
                        Icon(Icons.arrow_upward, size: 20, color: Colors.red,),
                      ],
                    ), "${(double.parse(widget.weatherData.main!.tempMax!) - AppConstants.kelvin).ceil()}${AppConstants.degree}"),
                    weatherBox("Min Temperature", const Row(
                      children: [
                        Icon(Icons.cloud, size: 30, color: Colors.green,),
                        Icon(Icons.arrow_downward, size: 20, color: Colors.green,),
                      ],
                    ), "${(double.parse(widget.weatherData.main!.tempMin!) - AppConstants.kelvin).round()}${AppConstants.degree}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(widget.weatherData.main!.seaLevel != "null")
                    weatherBox("Sea Level", const Icon(Icons.water_drop, size: 30,), "${widget.weatherData.main!.seaLevel}"),
                    if(widget.weatherData.main!.grndLevel != "null")
                    weatherBox("Ground Level", const Icon(Icons.landscape_rounded, size: 30), "${widget.weatherData.main!.grndLevel}"),
                  ],
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      weatherBox(
                          "Wind Speed",
                          const Icon(
                            Icons.air,
                            size: 30,
                          ),
                          "${widget.weatherData.wind!.speed} KmpH"),
                      weatherBox(
                          "Humidity",
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                size: 30,
                              ),
                              Icon(
                                Icons.thermostat,
                                size: 20,
                              ),
                            ],
                          ),
                          "${widget.weatherData.main!.humidity} %"),
                    ],
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    weatherBox("Sun Rise", const Icon(Icons.sunny, size: 30,), DateTime.fromMillisecondsSinceEpoch((widget.weatherData.sys!.sunrise!*1000)).toString().split(" ").last),
                    weatherBox("Sun Set", const Icon(Icons.sunny, size: 30,), DateTime.fromMillisecondsSinceEpoch((widget.weatherData.sys!.sunset!*1000)).toString().split(" ").last),
                  ],
                ),
                const SizedBox(height: 50,),
              ],
            )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sorry, we couldn't fetch new data due to a network issue. "
                      "Please check your internet connection and try again later. "
                      "Thank you for your understanding and patience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorResources.getBlackColor(context),
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold),),
                ],
              ),
          ],
        ),
      ),
    );
  }

  weatherBox(String title, Widget icon, String value){
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      color: ColorResources.getGreyColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width / 2.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: ColorResources.getBlackColor(context),
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  fontWeight: FontWeight.bold),),
              Expanded(
                child: icon,
              ),
              Expanded(child: Text(value,
                style: TextStyle(color: ColorResources.getBlackColor(context),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    );
  }

  weatherCircleBox(String title, Widget icon, String value){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width / 2.5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: ColorResources.getGreyColor(context),
          borderRadius: BorderRadius.circular(100)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: ColorResources.getBlackColor(context),
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Text(value,
            style: TextStyle(color: ColorResources.getBlackColor(context),
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  dailyWeatherList(WeekWeathers weekWeatherData) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: weekWeatherData.list!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  color: ColorResources.getGreyColor(context),
                  borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width / 4.5,
              child: Column(
                children: [
                  Text(weekDays[DateTime.parse(weekWeatherData.list![index].dtTxt!).weekday], style: TextStyle(color: ColorResources.getBlackColor(context),
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.bold),),
                  Text("${DateTime.parse(weekWeatherData.list![index].dtTxt!).hour>9? DateTime.parse(weekWeatherData.list![index].dtTxt!).hour : "0${DateTime.parse(weekWeatherData.list![index].dtTxt!).hour}"}:${DateTime.parse(weekWeatherData.list![index].dtTxt!).minute>9? DateTime.parse(weekWeatherData.list![index].dtTxt!).minute : "0${DateTime.parse(weekWeatherData.list![index].dtTxt!).minute}"}", style: TextStyle(color: ColorResources.getBlackColor(context),
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      fontWeight: FontWeight.bold),),
                  Icon(weekWeatherData.list![index].weather![0].main == AppConstants.rain? Icons.cloudy_snowing : weekWeatherData.list![index].weather![0].main == AppConstants.cloud ? Icons.cloud : weekWeatherData.list![index].weather![0].main == AppConstants.clear ? Icons.sunny: Icons.sunny, size: 25,),
                  Text("${(double.parse(weekWeatherData.list![index].main!.temp!) - AppConstants.kelvin).round()}${AppConstants.degree}", style: TextStyle(color: ColorResources.getBlackColor(context),
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.bold),),
                  Text("${(double.parse(weekWeatherData.list![index].main!.tempMin!) - AppConstants.kelvin).round()}${AppConstants.degree}", style: TextStyle(color: ColorResources.getBlackColor(context),
                    fontSize: Dimensions.FONT_SIZE_SMALL,),),
                ],
              ),
            );
          }
      ),
    );
  }

}