# AssertJson #

Test your JSON strings.

## Installation ##

```sh
cd path/to/your/rails-project
./script/plugin install git://github.com/phillipoertel/assert_json.git
```

## Usage ##

```ruby
class MyActionTest < ActionController::TestCase
  include IncludeJson

  def test_my_action
    get :my_action, :format => 'json'
    # => @response.body= '{"key":[{"inner_key1":"value1"},{"inner_key2":"value2"}]}'
    
    # include_json requires the expected structure in the actual json.
    # it allows other stuff in the actual json, however. that's where equal_json will kick in (to be written).
    include_json({
      key: {
        inner_key1: 'value1',
        inner_key2: /lue2/
      }
    }, @response.body)
    
  end

end
```

## Future ##

rspec compatibility: 

```ruby
user_to_json.should include_json({
  name: 'Peter',
  age: /\d+/,
  _links: {
    next: {
      href: /http.+/
    }
  }
})
```

## Changelog ##

Look at the [CHANGELOG](https://github.com/xing/assert_json/blob/master/CHANGELOG.md) for details.

## Authors ##

[Thorsten Böttger](http://github.com/alto),
[Ralph von der Heyden](http://github.com/ralph),
[Phillip Oertel](http://github.com/phillipoertel)

## License ##

The MIT License
 
Copyright (c) 2009-2012
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
