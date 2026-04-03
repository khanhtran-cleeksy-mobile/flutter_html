import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';
// import 'package:flutter_math_fork/flutter_math.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(title: 'flutter_html Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

const htmlData = '<p>Estimate card List Integration App Management<br/>Qa 1 round 4h trên môi trường QA<br/>plan test:<br/>1&#47; UI&#47;UX<br/>2&#47; funtional:<br/>Sau khi kết nối sẽ hiển thị trên page tích hợp:</p><ul><li>mở chi tiết tích hợp =&gt; hiển thị hành động tích hợp</li><li>khi thêm hành động tích hợp =&gt; hiển thị số lần tích hợp trên M - invoice</li><li>Hủy kết nối tích hợp</li></ul><p>Sau khi ngắt kết nối sẽ ko hiển thị M- invoice trên page tích hợp<br/>kết nối nhiều lần =&gt; báo error message<br/><br/><span class="dx-mention" spellcheck="false" data-marker="@" data-mention-value="testmia" data-id="22141" data-parent-id="null" data-type="3" data-color="undefined" data-task-type-icon="null">﻿<span contenteditable="false"><span>@</span>testmia</span>﻿</span> </p>';

final staticAnchorKey = GlobalKey();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('flutter_html Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: () {
          final anchorContext = AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
          if (anchorContext != null) {
            Scrollable.ensureVisible(anchorContext);
          }
        },
      ),
      body: SingleChildScrollView(
        child: ColoredBox(
          color: Colors.redAccent,
          child: Html(
            anchorKey: staticAnchorKey,
            data: htmlData,
            style: {
              "*": Style(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                fontSize: FontSize(14),
                maxLines: 2,
              )
            },
            tagsList: Html.tags..addAll(['tex', 'bird', 'flutter']),
            // customRenders: {
            //   // tagMatcher("tex"): CustomRender.widget(widget: (context, buildChildren) => Math.tex(
            //   //   context.tree.element?.innerHtml ?? '',
            //   //   mathStyle: MathStyle.display,
            //   //   textStyle: context.style.generateTextStyle(),
            //   //   onErrorFallback: (FlutterMathException e) {
            //   //     return Text(e.message);
            //   //   },
            //   // )),
            //   tagMatcher("bird"): CustomRender.inlineSpan(inlineSpan: (context, buildChildren) => TextSpan(text: "🐦")),
            //   tagMatcher("flutter"): CustomRender.widget(widget: (context, buildChildren) => FlutterLogo(
            //     style: (context.tree.element!.attributes['horizontal'] != null)
            //         ? FlutterLogoStyle.horizontal
            //         : FlutterLogoStyle.markOnly,
            //     textColor: context.style.color!,
            //     size: context.style.fontSize!.size! * 5,
            //   )),
            //   // tagMatcher("table"): CustomRender.widget(widget: (context, buildChildren) => SingleChildScrollView(
            //   //   scrollDirection: Axis.horizontal,
            //   //   child: tableRender.call().widget!.call(context, buildChildren),
            //   // )),
            //   // audioMatcher(): audioRender(),
            //   // iframeMatcher(): iframeRender(),
            //   // mathMatcher(): mathRender(onMathError: (error, exception, exceptionWithType) {
            //   //   print(exception);
            //   //   return Text(exception);
            //   // }),
            //   // svgTagMatcher(): svgTagRender(),
            //   // svgDataUriMatcher(): svgDataImageRender(),
            //   // svgAssetUriMatcher(): svgAssetImageRender(),
            //   // svgNetworkSourceMatcher(): svgNetworkImageRender(),
            //   networkSourceMatcher(domains: ["flutter.dev"]): CustomRender.widget(
            //       widget: (context, buildChildren) {
            //         return FlutterLogo(size: 36);
            //       }),
            //   networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
            //     headers: {"Custom-Header": "some-value"},
            //     altWidget: (alt) => Text(alt ?? ""),
            //     loadingWidget: () => Text("Loading..."),
            //   ),
            //   // On relative paths starting with /wiki, prefix with a base url
            //       (context) => context.tree.element?.attributes["src"] != null
            //       && context.tree.element!.attributes["src"]!.startsWith("/wiki"):
            //   networkImageRender(mapUrl: (url) => "https://upload.wikimedia.org" + url!),
            //   // Custom placeholder image for broken links
            //   networkSourceMatcher(): networkImageRender(altWidget: (_) => FlutterLogo()),
            //   // videoMatcher(): videoRender(),
            // },
            onLinkTap: (url, _, __, ___) {
              print("Opening $url...");
            },
            onImageTap: (src, _, __, ___) {
              print(src);
            },
            onImageError: (exception, stackTrace) {
              print(exception);
            },
            onCssParseError: (css, messages) {
              print("css that errored: $css");
              print("error messages:");
              messages.forEach((element) {
                print(element);
              });
            },
          ),
        ),
      ),
    );
  }
}

CustomRenderMatcher texMatcher() => (context) => context.tree.element?.localName == 'tex';

CustomRenderMatcher birdMatcher() => (context) => context.tree.element?.localName == 'bird';

CustomRenderMatcher flutterMatcher() => (context) => context.tree.element?.localName == 'flutter';
