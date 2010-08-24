module CustomMatchers

  class CommutationMatcher

    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      @actual.sort == @expected.sort
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to be commutative with #{@expected.inspect}"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} not to be commutative with #{@expected.inspect}"
    end
  end

  def be_commutative_with(expected)
    CommutationMatcher.new(expected)
  end

end
