require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class AssertJsonNewDslTest < Test::Unit::TestCase
  include IncludeJson

  def test_single_hash
    actual = '{"key": "value"}'
    include_json({
      key: "value"
    }, actual)
  end
  
  def test_regular_expression_for_hash_values
    actual = '{"key": "value"}'
    include_json({
      key: /alu/
    }, actual)
  end

  def test_single_hash_crosscheck_for_key
    assert_raises(MiniTest::Assertion) do
      actual = '{"wrong_key": "value"}'
      include_json({
        key: "value"
      }, actual)
    end
  end
  
  def test_single_hash_crosscheck_for_value
    assert_raises(MiniTest::Assertion) do
      actual = '{"key": "wrong_value"}'
      include_json({
        key: "value"
      }, actual)
    end
  end
  
  def test_array
    actual = '["value1", "value2", "value3"]'
    include_json(%w(value1 value2 value3), actual)
  end
  
  def test_array_crosscheck_order
    assert_raises(MiniTest::Assertion) do
      actual = '["value1", "value2", "value3"]'
      include_json(%w(value2), actual)
    end
  end
  
  def test_array_crosscheck_for_first_item
    assert_raises(MiniTest::Assertion) do
      actual = '["value1", "value2", "value3"]'
      include_json(%w(wrong_value1), actual)
    end
  end
  
  def test_array_crosscheck_for_second_item
    assert_raises(MiniTest::Assertion) do
      actual = '["value1", "value2", "value3"]'
      include_json(%w(value1 wrong_value2), actual)
    end
  end
  
  def test_hash_with_value_array
    actual = '{"key":["value1","value2"]}'
    include_json({
      key: %w(value1 value2)
    }, actual)
  end
  
  # TODO
  #def test_nested_arrays
  #  assert_json '[[["deep","another_depp"],["second_deep"]]]' do
  #    has [["deep","another_depp"],["second_deep"]]
  #  end
  #end
  #def test_nested_arrays
  #  actual = '[[["deep","another_depp"],["second_deep"]]]'
  #  include_json([[["deep","another_depp"],["second_deep"]]], actual)
  #end
  
  def test_has_not
    actual = '{"key": "value"}'
    not_include_json({
      key_not_included: "value"
    }, actual)
  end
  
  def test_has_not_crosscheck
    assert_raises(MiniTest::Assertion) do
      actual = '{"key": "value"}'
      not_include_json({
        key: "value"
      }, actual)
    end
  end
  
=begin

  #
  # WIP
  #
  
  def test_has_not_array
    assert_json '["value1","value2"]' do
      has 'value1'
      has 'value2'
      has_not 'value3'
    end
  end  

  def test_single_hash_with_outer_variable
    @values = {'value' => 'value'}
    assert_json '{"key":"value"}' do
      has 'key', @values['value']
    end
  end
  def test_nested_arrays_crosscheck
    assert_raises(MiniTest::Assertion) do
      assert_json '[[["deep","another_depp"],["second_deep"]]]' do
        has [["deep","wrong_another_depp"],["second_deep"]]
      end
    end
    assert_raises(MiniTest::Assertion) do
      assert_json '[[["deep","another_depp"],["second_deep"]]]' do
        has [["deep","another_depp"],["wrong_second_deep"]]
      end
    end
  end
  
  def test_hash_with_value_array_crosscheck_wrong_key
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":["value1","value2"]}' do
        has 'wrong_key', ['value1', 'value2']
      end
    end
  end
  def test_hash_with_value_array_crosscheck_wrong_value1
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":["value1","value2"]}' do
        has 'key', ['wrong_value1', 'value2']
      end
    end
  end
  def test_hash_with_value_array_crosscheck_wrong_value2
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":["value1","value2"]}' do
        has 'key', ['value1', 'wrong_value2']
      end
    end
  end
  
  def test_hash_with_array_of_hashes
    assert_json '{"key":[{"inner_key1":"value1"},{"inner_key2":"value2"}]}' do
      has 'key' do
        has 'inner_key1', 'value1'
        has 'inner_key2', 'value2'
      end
    end
  end
  def test_hash_with_array_of_hashes_crosscheck_inner_key
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":[{"inner_key1":"value1"},{"inner_key2":"value2"}]}' do
        has 'key' do
          has 'wrong_inner_key1', 'value1'
        end
      end
    end
  end
  def test_hash_with_array_of_hashes_crosscheck_inner_value
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":[{"inner_key1":"value1"},{"inner_key2":"value2"}]}' do
        has 'key' do
          has 'inner_key1', 'wrong_value1'
        end
      end
    end
  end
  
  def test_array_with_two_hashes
    assert_json '[{"key1":"value1"}, {"key2":"value2"}]' do
      has 'key1', 'value1'
      has 'key2', 'value2'
    end
  end
  def test_array_with_nested_hashes
    assert_json '[{"key1":{"key2":"value2"}}]' do
      has 'key1' do
        has 'key2', 'value2'
      end
    end
  end
  def test_array_with_two_hashes_crosscheck
    assert_raises(MiniTest::Assertion) do
      assert_json '[{"key1":"value1"}, {"key2":"value2"}]' do
        has 'wrong_key1', 'value1'
        has 'key2', 'value2'
      end
    end
    assert_raises(MiniTest::Assertion) do
      assert_json '[{"key1":"value1"}, {"key2":"value2"}]' do
        has 'key1', 'value1'
        has 'key2', 'wrong_value2'
      end
    end
  end
  
  def test_nested_hashes
    assert_json '{"outer_key":{"key":{"inner_key":"value"}}}' do
      has 'outer_key' do
        has 'key' do
          has 'inner_key', 'value'
        end
      end
    end
  end
  def test_nested_hashes_crosscheck
    assert_raises(MiniTest::Assertion) do
      assert_json '{"outer_key":{"key":{"inner_key":"value"}}}' do
        has 'wrong_outer_key'
      end
    end
    assert_raises(MiniTest::Assertion) do
      assert_json '{"outer_key":{"key":{"inner_key":"value"}}}' do
        has 'outer_key' do
          has 'key' do
            has 'inner_key', 'wrong_value'
          end
        end
      end
    end
  end
  
  def test_real_xws
    assert_json '[{"contact_request":{"sender_id":"3","receiver_id":"2","id":1}}]' do
      has 'contact_request' do
        has 'sender_id', '3'
        has 'receiver_id', '2'
        has 'id', 1
      end
    end
  
    assert_json '[{"private_message":{"sender":{"display_name":"first last"},"receiver_id":"2","body":"body"}}]' do
      has 'private_message' do
        has 'sender' do
          has 'display_name', 'first last'
        end
        has 'receiver_id', '2'
        has 'body', 'body'
      end
    end
  end
  
  def test_not_enough_hass_in_array
    assert_raises(MiniTest::Assertion) do
      assert_json '["one","two"]' do
        has "one"
        has "two"
        has "three"
      end
    end
  end
  
  def test_not_enough_hass_in_hash_array
    assert_raises(MiniTest::Assertion) do
      assert_json '{"key":[{"key1":"value1"}, {"key2":"value2"}]}' do
        has 'key' do
          has 'key1', 'value1'
          has 'key2', 'value2'
          has 'key3'
        end
      end
    end
  end
=end
end
