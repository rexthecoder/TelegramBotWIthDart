import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:telegrambot/telegrambot.dart';

Future<void> main() async {
  // variable to store the bot
  var telegram = Telegram(envVars['BOT_TOKEN']!);
  var event = Event((await telegram.getMe()).username!);
  var teledart = TeleDart(telegram, event);

  // Initialize the telegram bot
  teledart.start();

  // welcome message
  teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
        (message) => teledart.telegram.sendMessage(
          message.chat.id,
          'Hello Flutter Hero!',
        ),
      );

  // send a facts message to the user
  teledart.onMessage(entityType: 'bot_command', keyword: 'jokes').listen(
    (message) async {
      var response = await BotConfiguration.jokes();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['value']['joke']}🤣",
      );
    },
  );
  teledart.onMessage(entityType: 'bot_command', keyword: 'insult').listen(
    (message) async {
      var response = await BotConfiguration.insult();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['insult']}😜",
      );
    },
  );
  teledart.onMessage(entityType: 'bot_command', keyword: 'advice').listen(
    (message) async {
      var response = await BotConfiguration.advice();
      teledart.telegram.sendMessage(
        message.chat.id,
        "${response['slip']['advice']}",
      );
    },
  );

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
