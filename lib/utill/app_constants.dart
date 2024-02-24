
class AppConstants {
  static const String appNAME = 'WEATHER FORECAST';
  static const double appVERSION = 1.0;
  static String baseURL = "https://api.openweathermap.org/data/2.5"; /////PRODUCTION URL//////
  static String getWeather2 = "&APPID=$weatherAPIKey";
  static String getWeather = "/weather";
  static String getWeekWeather2 = "&appid=$weatherAPIKey";
  static String getWeekWeather = "/forecast";
  static String getIcon = "https://openweathermap.org/img/w/";

  static String weatherAPIKey = "114ba7630b612d3b7e4c2be0dc773782";
  static String defaultCity = "delhi";
  // Shared Key
  static const String spLogin = 'LOGIN';
  static const String spEmail = 'EMAIL';
  static const String spWeekWeatherData = 'WeekWeather';
  static const String spWeatherData = 'Weather';
  static const String spName = 'NAME';
  static const String spPassword = 'PASSWORD';


  static const String success = 'Success';

  static const String theme = 'theme';
  static const String themeDark = 'Dark';
  static const String themeLight = 'Light';
  static const String rain = 'Rain';
  static const String cloud = 'Clouds';
  static const String clear = 'Clear';
  static const String degree = ' \u2103';
  static const double kelvin = 273.15;


}

List<String> weekDays = ["Off", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];