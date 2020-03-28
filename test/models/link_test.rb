require 'test_helper'

class LinkTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_code_is_required
    link = Link.create(url: "https://example#{rand(10000)}.com")

    assert !link.valid?
  end

  def test_code_is_unique
    code = SecureRandom.alphanumeric
    link = Link.create!(url: "https://example#{rand(10000)}.com", code: code)

    assert_equal link.code, code

    link = Link.create(url: "https://example#{rand(10000)}.com", code: code)

    assert !link.valid?
  end
end
