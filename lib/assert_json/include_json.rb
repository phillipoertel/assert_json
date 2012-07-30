module IncludeJson
  
  # thanks to alto and ralph, this fellow does all the work.
  include AssertJson
  
  # TODO refactor to be used as rspec matcher like this:
  # something.to_json.should include_json({:id => 42, :name => /\A\w{2,20}\Z/})
  def include_json(expected, actual)
    @json = AssertJson::Json.new(actual)
    expected.each do |key, value|
      # key.to_s is OK since JSON has only the string type for keys.
      @json.has(key.to_s, value)
    end
  end
  
  def not_include_json(expected, actual)
    @json = AssertJson::Json.new(actual)
    expected.each do |key, value|
      # key.to_s is OK since JSON has only the string type for keys.
      @json.has_not(key.to_s, value)
    end
  end
  
  # TODO implement
  # the same as include_json but alarms when other keys/json is present in the actual data  
  def equal_json(expected, actual)
    raise "Will require an exact match of expected and actual to pass. Not yet implemented."
  end
  
end