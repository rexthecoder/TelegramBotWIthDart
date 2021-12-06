/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'env.dart';

class BotConfiguration {
  /// Mange http request
  static Future<Map<String, dynamic>> getData(String variable) async {
    http.Response response = await http.get(
      Uri.parse(variable),
    );
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  /// Random Facts
  static Future<Map<String, dynamic>> facts() async {
    try {
      Map<String, dynamic> data = await getData(envVars['FACT']!);
      return data;
    } catch (e) {
      return {'facts': 'Something went wrong'};
    }
  }

  /// Random Jokes
  static Future<Map<String, dynamic>> jokes() async {
    try {
      Map<String, dynamic> data = await getData(envVars['JOKES']!);
      return data;
    } catch (e) {
      return {
        'value': {'joke': 'Something went wrong'}
      };
    }
  }

  /// Random Insult
  static Future<Map<String, dynamic>> insult() async {
    try {
      Map<String, dynamic> data = await getData(envVars['INSULT']!);
      return data;
    } catch (e) {
      return {'insult': 'Something went wrong'};
    }
  }

  /// Random Advice
  static Future<Map<String, dynamic>> advice() async {
    try {
      Map<String, dynamic> data = await getData(envVars['ADVICE']!);
      return data;
    } catch (e) {
      return {
        'slip': {'advice': 'Something went wrong'}
      };
    }
  }

  /// Read bible verse
  static Future<Map<String, dynamic>> bible(String book) async {
    try {
      Map<String, dynamic> data = await getData('${envVars['BIBLE']!}/$book');
      return data;
    } catch (e) {
      return {'text': 'Book not found'};
    }
  }
}
