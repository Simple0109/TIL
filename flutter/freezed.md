[公式pub.dev](https://pub.dev/packages/freezed)

Dartはモデルを作成するのがめんどい

- 公式曰くやらないといけないこと
    
    ```bash
    define a constructor + properties
    override toString, operator ==, hashCode
    implement a copyWith method to clone the object
    handle (de)serialization
    ```
    

これらを実装するには手間も時間もかかるし、エラーも起きやすい

freezedを使うことで、この手間もミスも減らしてくれる

before(freezed使わない場合)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/78a5cebe-360a-4e14-a2fe-42852a33aec8/75449b5c-f262-4f1d-b10a-9f2c47f8c304/image.png)

after(freezed使った場合)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/78a5cebe-360a-4e14-a2fe-42852a33aec8/35a0716c-3be4-48a2-92c5-f2eab9fa36e7/image.png)

freezedはstateを作ってくれていると勘違いしていた

作っているのはあくまでモデル→モデルで定義したものは全て「状態として管理できる」？！！？

じゃあstateか否かの判断をしているのはなに？→ただ見やすくしているだけ

モデルは「データ構造」や「どのようにそのデータを扱うか」を定義する

状態管理を通じて、アプリのUIや動作を更新することができる。ただしモデルの全てを状態として管理する必要はなく、アプリの動的な部分のみ状態として管理することが多い。

# Freezedの使い方

```dart
// freezedをインポート
import 'package:freezed_annotation/freezed_annotation.dart';

// freezedで自動生成をされるサービス
part 'person.freezed.dart'

// freezedアノテーション
@freezed

// Personクラスの作成、Personクラスをプライベートクラスである_$Persoonクラスに移乗している
class Person with _$Person {
 const factory Person ({
 required String name,
 required int age,
 }) = Person; 
}
```

## 自動生成されるファイル

```dart
part 'person.freezed.dart'
part 'person.g.dart'
```

freezedパッケージがこれらのファイルを自動で生成する。

`copyWithメソッド` : https://pryogram.com/flutter/what-is-copywith/, https://api.flutter.dev/flutter/material/TextTheme/copyWith.html

`toString()` : https://api.flutter.dev/flutter/dart-core/Type/toString.html

これらのメソッドや演算子は、Freezedが自動的に生成し、オブジェクトの比較や操作を容易にします。特に`hashCode`は、オブジェクトのハッシュ値を計算するために使用され、コレクション内でのオブジェクトの効率的な検索や比較に重要な役割を果たします。Freezedは、これらの機能を自動生成することで、開発者がモデルクラスを定義する際の労力を大幅に削減し、より信頼性の高いコードを書くことを可能にします。

`==演算子` : https://zenn.dev/hs7/articles/243f7193f351ea

※ dartでは ==演算子はオブジェクトの参照を比較するため、異なるインスタンス同士で内容が同じでもfalseが返ってくる

```dart
class Parson {
	final String name,
	final int age,
	
	Person({
		required this.name,
		required age
		})
}

final person1 = Person(name: ikegami, age: 66);
final person2 = Person(name: ikegami, age: 66);

print(person1 == person2)
// => false
```

`hashCode` : ハッシュ値を生成してオブジェクトに付与する。オブジェクトのプロパティの値に応じて、付与されるため、プロパティの値が同じ場合、同じハッシュ値がオブジェクトに付与される

https://zenn.dev/shoyu88/articles/6d083865d8e841

## Freezedアノテーション

```dart
// freezedアノテーション
@freezed
```

- アノテーション is 何？
    
    とあるデータに対して関連する情報（メタデータ）を注釈として付与すること by [Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%8E%E3%83%86%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)
    
    - is 何？
        
        ```dart
        class InspectionScreen extends HookConsumerWidget {
          const InspectionScreen({super.key});
        
          @override //これアノテーション
        -------------------------------------------------------------------------  
        @freezed // これアノテーション
        class User with _$User {
          const factory User({
            required String name,
            required int age,
          }) = _User;
        }
        --------------------------------------------------------------------------
        @freezed
        class User with _$User {
          const factory User({
            required String name,
            @Default(18) int age, // @Default これアノテーション
          }) = _User;
        }
        ```
        

よく見る `@override` この子も、`@Default` このコも、`@freezed`この娘もみんな`annotation` 

https://dart.dev/language/metadata

アノテーション以下に書かれたコードの注釈となっていて、freezed公式が

`freezed`使うなら`freezed_annotation` と`build_runner`を一緒に入れてくれと書いてある、`freezed_annotation` がアノテーションを提供するパッケージで、`freezed`がアノテーションを処理してファイルを自動生成する。freezed自体を動かすの`build_runner` さん。だからfreezed使ったコード書いたあとに `flutter pun run build_runner` しないといけないのね

## クラスの作成、機能の追加

```dart
// Personクラスの作成、Personクラスをプライベートクラスである_Persoonクラスに移乗している
class Person with _$Person {
 const factory Person ({
 required String name,
 required int age,
 }) = Person; 
```