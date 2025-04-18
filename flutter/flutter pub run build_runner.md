freezedパッケージを使ってコードを生成モデルを作成するときに使用する

`flutter pub run build_runner build --delete-conflicting-outputs` 

`flutter pub run build_runner build`

これらの違い

---

## 寄り道（だった）

そもそもflutterのコマンドだと思っていたけど、違うみたい

`freezed`パッケージを見ると以下のように書かれている

```bash
To use Freezed, you will need your typical build_runner/code-generator setup.
First, install build_runner and Freezed by adding them to your pubspec.yaml file:

// Freezedを使うにはbuild_runner/code-generatorのセットアップが必要
// まずbuild_runnerとFreezedをpubspec.yamlに追加してインストールしてくれさい
```

さらに説明を読むと以下のように書かれている

```bash
This installs three packages:

build_runner, the tool to run code-generators
freezed, the code generator
freezed_annotation, a package containing annotations for freezed.
```

`build_runner`はcode-generatorを実行するツール

`freezed`はcode-generator

`freezed_annotation`は`freezed`の注釈を含むパッケージ

- アノテーション（annotation）ってなに？
    
    コードやクラスに対して特別な振る舞いを持たせるための機構
    
    - ちょっと何言ってるかわからない
        
        ソースコードに付加される「特定の意味を持つラベル」や「メタデータ」のようなもの
        
        - ちょっと言ってるかわからない
            
            具体例
            
            ```dart
            class InspectionScreen extends HookConsumerWidget {
              const InspectionScreen({super.key});
            
              @override //これアノテーション
            ```
            
            ```dart
            @freezed // これアノテーション
            class User with _$User {
              const factory User({
                required String name,
                required int age,
              }) = _User;
            }
            ```
            
            ```dart
            @freezed
            class User with _$User {
              const factory User({
                required String name,
                @Default(18) int age, // @Default これアノテーション
              }) = _User;
            }
            ```
            
        
    
    つまり
    

つまり`freezed_annotation`が提供しているのは`@freezed`アノテーションであり、`freezed`パッケージは`@freezed`アノテーションを解釈してコードを生成する持ちつ持たれつ共依存ダメカップルな関係

その`freezed（コード生成パッケージ）`を動かすのが`build_runner`

すっきり

---

## 寄り道②（だった）

次に`build_runner`の[公式pub.dev](https://pub.dev/packages/build_runner)を見る

```bash
The build_runner package exposes a binary by the same name,
which can be invoked using dart run build_runner <command>.
```

今まで`flutter pub run build_runner build`しか使ったことなかったけど`dart run build_runner`もあるんだなあ。へー

- どんな違いがあるか調べてもわからんからChatGPTに聞いてみた
    
    `flutter run build_runner` と `dart run build_runner` の違いについて説明します。両者の違いは、主に**FlutterプロジェクトかDartプロジェクトか**による環境の違いにあります。以下、それぞれのコマンドについて詳しく解説します。
    
    ### 1. **`flutter pub run build_runner`**
    
    - このコマンドは、**Flutterプロジェクトで`build_runner`を実行する**ために使用します。
    - `flutter pub` コマンドを使うことで、Flutter特有の環境（例えば、Flutter SDKに関連する依存関係）を考慮して、`build_runner`を実行します。
    - Flutterアプリは通常、Dart SDKだけでなく、Flutter SDKも依存しているため、`flutter`コマンドを使ってプロジェクトを管理するのが一般的です。
    
    ### 2. **`dart pub run build_runner`**
    
    - こちらは、**通常のDartプロジェクトで`build_runner`を実行する**ために使用します。
    - Flutterではなく、Dartのみを使用したプロジェクト（例えば、コマンドラインツールやサーバーサイドアプリケーション）で使う場合に適しています。
    - このコマンドは、`dart`ツールを直接使ってDartプロジェクトを管理・ビルドします。Flutter SDKには依存しない環境で使います。
    
    ### それぞれの違い
    
    - **`flutter pub run build_runner`**: Flutterプロジェクトで使用する。Flutter SDKを考慮した環境でビルドを行います。
    - **`dart pub run build_runner`**: Dartプロジェクトで使用する。Flutter SDKが不要な、Dartだけのプロジェクトで使用します。
    
    ### コマンドの実行結果について
    
    - 両方とも、`build_runner`の動作自体（コード生成）は同じです。例えば、`freezed`や`json_serializable`などを使ったコード生成はどちらのコマンドでも同じ結果になります。
    - **違いは、Flutter特有の依存関係があるかどうか**です。Flutterプロジェクトの場合は、`flutter pub run build_runner`を使うことで、Flutter SDKが正しく読み込まれた環境で`build_runner`が動作します。
    
    ### 例:
    
    - **Flutterプロジェクトの場合**:
        - Flutter SDKに依存するコード生成（例えば、`freezed`や`json_serializable`をFlutter環境で使う場合）では、`flutter pub run build_runner`を使います。
        - 例: FlutterアプリのUIで使用されるモデルクラスのコード生成。
    - **Dartプロジェクトの場合**:
        - Dart SDKだけで動作するコード生成（例えば、サーバーサイドで使うデータモデルの生成）では、`dart pub run build_runner`を使います。
    
    ### まとめ
    
    - **Flutterプロジェクトの場合は `flutter pub run build_runner` を使う**のが基本です。これにより、Flutterの環境設定や依存関係が適切に考慮されます。
    - *Dartプロジェクトの場合は `dart pub run build_runner`*を使います。こちらは、Flutterの環境が不要なDartのみのプロジェクトで使用します。
    
    どちらを使うかは、プロジェクトのタイプ（Flutter or Dart）によって決まります。あなたがFlutterプロジェクトで作業している場合は、今まで通り`flutter pub run build_runner`を使うのが適切です。
    

`flutter pub`コマンドを使うことでFlutter特有の環境（例えばFlutter SDKに関連する依存関係）を考慮して`build_runner`を実行する。へー

さらに公式を見ると

```bash
The available commands are build, watch, serve, and test.

// 単一のビルドを実行し終了する
build: Runs a single build and exits.
// ファイルシステムの編集を監視し、必要に応じて再構築を行う永続的なビルドサーバーを実行する
watch: Runs a persistent build server that watches the files system for edits and does rebuilds as necessary.
// watchと同じだが、開発用サーバーも実行する。デフォルトではwebとtestディレクトリをそれぞれ8080番と8081番で提供する
serve: Same as watch, but runs a development server as well.
By default this serves the web and test directories, on port 8080 and 8081 respectively. See below for how to configure this.
// 
test: Runs a single build, creates a merged output directory, and then runs dart run test --precompiled <merged-output-dir>. See below for instructions on passing custom args to the test command.
```