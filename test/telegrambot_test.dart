/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:telegrambot/telegrambot.dart';
import 'package:test/test.dart';

void main() {
  group('Bot Configuration Test', () {
    test('should return a facts when valid', () async {
      final expected = await BotConfiguration.facts();
      expect(expected['facts'], isA<String>());
    });
    test('should return a jokes when valid', () async {
      final expected = await BotConfiguration.jokes();
      expect(expected['value']['joke'], isA<String>());
    });

    test('should return an insult when valid', () async {
      final expected = await BotConfiguration.insult();
      expect(expected['insult'], isA<String>());
    });
    test('should return an advice when valid', () async {
      final expected = await BotConfiguration.advice();
      expect(expected['slip']['advice'], isA<String>());
    });

    test('should return a bible verse when valid', () async {
      final expected = await BotConfiguration.bible('James 1:1');
      expect(expected['text'], isA<String>());
    });
  });
}
