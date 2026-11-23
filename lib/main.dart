import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;

@JS('window.open')
external void _openUrl(String url, String target);

@JS('fetch')
external JSPromise<_JsResponse> _fetch(String url);

extension type _JsResponse(JSObject _) implements JSObject {
  external bool get ok;
  external JSPromise<JSString> text();
}

void main() {
  runApp(const FwebApp());
}

class FwebApp extends StatelessWidget {
  const FwebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fweb',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _apiUrl =
      'https://api.github.com/repos/mathiu-06/fweb/contents/tunnel.json';

  String? _tunnelUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTunnelUrl();

    // Use <object> instead of <img> to allow SVG animations to play
    ui_web.platformViewRegistry.registerViewFactory(
      'animated-rata',
      (int viewId) {
        final element = web.document.createElement('object') as web.HTMLObjectElement;
        element.type = 'image/svg+xml';
        element.data = 'assets/rata.svg'; // Make sure this matches your pubspec.yaml exactly
        element.style.width = '100%';
        element.style.height = '100%';
        element.style.border = 'none';
        
        // Prevents the browser from showing a default background or scrollbars
        element.style.overflow = 'hidden'; 
        element.style.backgroundColor = 'transparent';
        
        return element;
      },
    );
  }

  Future<void> _loadTunnelUrl() async {
    try {
      final cacheBust = DateTime.now().millisecondsSinceEpoch;
      final res = await _fetch('$_apiUrl?t=$cacheBust').toDart;
      if (!res.ok) throw Exception('Not found');

      final body = (await res.text().toDart).toDart;
      final apiJson = jsonDecode(body) as Map<String, dynamic>;
      final rawBase64 = (apiJson['content'] as String).replaceAll('\n', '');
      final decoded =
          jsonDecode(utf8.decode(base64Decode(rawBase64))) as Map<String, dynamic>;

      setState(() {
        _tunnelUrl = decoded['url'] as String?;
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _tunnelUrl = null;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: HtmlElementView(viewType: 'animated-rata'),
        ),
      ),
    );
  }
}
