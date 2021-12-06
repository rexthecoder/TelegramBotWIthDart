import 'dart:convert';

import 'package:telegrambot/src/cubit/bot_cubit.dart';
import 'package:http/http.dart' as http;

import 'env.dart';

final botCubit = BotCubit();

class BotConfiguration {
  /// Random Facts
  static Future<Map<String, dynamic>> facts() async {
    try {
      http.Response response = await http.get(
        Uri.parse(envVars['FACT']!),
      );
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (e) {
      return {'facts': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> jokes() async {
    try {
      http.Response response = await http.get(
        Uri.parse(envVars['JOKES']!),
      );
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (e) {
      return {
        'value': {'joke': 'Something went wrong'}
      };
    }
  }

  static Future<Map<String, dynamic>> insult() async {
    try {
      http.Response response = await http.get(
        Uri.parse(envVars['INSULT']!),
      );
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (e) {
      return {'insult': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> advice() async {
    try {
      http.Response response = await http.get(
        Uri.parse(envVars['ADVICE']!),
      );
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (e) {
      return {
        'slip': {'advice': 'Something went wrong'}
      };
    }
  }

  static Future<Map<String, dynamic>> bible(String book) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${envVars['BIBLE']!}/$book'),
      );
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (e) {
      return {'text': 'Book not found'};
    }
  }
}
