import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Added flutter_svg import

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
    return Scaffold(
      body: Center(
        // Replaced placeholder with SvgPicture
        child: SvgPicture.asset(
          'assets/images/rata.svg',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
