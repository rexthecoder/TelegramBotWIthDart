/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:telegrambot/telegrambot.dart';

Future<void> main() async {
  // variable to store the bot
  var telegram = Telegram(envVars['BOT_TOKEN']!);
  var event = Event((await telegram.getMe()).username!);

  var webhook = await Webhook.createHttpWebhok(
    telegram,
    envVars['HOST_URL']!,
    envVars['BOT_TOKEN']!,
    port: int.parse(
      envVars['BOT_PORT']!,
    ),
  );
  var teledart = TeleDart(telegram, event, fetcher: webhook);

  // Initialize the telegram bot
  teledart.start();

  // welcome message
  teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
        (message) => teledart.telegram.sendMessage(
          message.chat.id,
          'Hello Flutter Hero!',
        ),
      );

  // hekp messages
  teledart.onCommand('help').listen(
        (message) => teledart.telegram.sendMessage(
          message.chat.id,
          help,
        ),
      );

  // send a facts message to the user
  teledart.onMessage(entityType: 'bot_command', keyword: 'facts').listen(
    (message) async {
      var response = await BotConfiguration.facts();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['facts']}💙\n${response['url']}",
      );
    },
  );

  // send a random jokes message
  teledart.onMessage(entityType: 'bot_command', keyword: 'jokes').listen(
    (message) async {
      var response = await BotConfiguration.jokes();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['value']['joke']}🤣",
      );
    },
  );

  /// Send random insult messages
  teledart.onMessage(entityType: 'bot_command', keyword: 'insult').listen(
    (message) async {
      var response = await BotConfiguration.insult();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['insult']}😜",
      );
    },
  );

  /// send random advice
  teledart.onMessage(entityType: 'bot_command', keyword: 'advice').listen(
    (message) async {
      var response = await BotConfiguration.advice();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['slip']['advice']}",
      );
    },
  );

  /// Send random bible based on the verse
  teledart.onMessage(keyword: RegExp('bible', caseSensitive: false)).listen(
    (message) async {
      var result = message.text!.replaceAll(
        RegExp('bible', caseSensitive: false),
        '',
      );
      var response = await BotConfiguration.bible(result.trim());
      teledart.telegram.sendMessage(
        message.chat.id,
        "$result\n${response['text']}",
      );
    },
  );
}
