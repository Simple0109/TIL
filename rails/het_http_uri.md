# net/http
汎用データ転送プロトコルHTTPを扱うライブラリ

```ruby
require "net/http"
uri = "http://www.example.com/index.html"
response = Net::HTTP.get_response(URI.parse(uri))
p response.header
#=> => #<Net::HTTPOK 200 OK readbody=true>
```
