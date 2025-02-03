import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert'; // Import this for Encoding

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    print("Initializing WebView...");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    String htmlContent = '''
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Simple HTML Page</title>
  </head>
  <body>
      <h1>Welcome to My Simple HTML Page</h1>
      <p>This is a paragraph of text on my simple HTML page.</p>
      <script src="https://cdn.botpress.cloud/webchat/v2.2/inject.js"></script>
      <script src="https://files.bpcontent.cloud/2025/02/01/15/20250201152731-CHK1SHFO.js"></script>
  </body>
  </html>
  ''';

    _controller.loadRequest(Uri.dataFromString(htmlContent,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Bot"),
        backgroundColor: Colors.green.shade700,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
