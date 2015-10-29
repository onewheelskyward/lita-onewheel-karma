require 'roman-numerals'

module Lita
  module Handlers
    class OnewheelKarma < Handler
      route /([^\s]+)\+\+(\s|$)/, :add_one_karma,
            help: {'object++:' => 'Add one karma to [object].'}
      route /([^\s]+)--(\s|$)/, :remove_one_karma,
            help: {'object++:' => 'Remove one karma from [object].'}
      route /([^\s]+)\*=\s*([-\d]+)/, :multiply_karma,
            help: {'object*=n:' => 'Multiply karma by n'}
      route /([^\s]+)\+=\s*([-\d]+)/, :add_arbitrary_karma,
            help: {'object+=n:' => 'Add n karma to [object].'}
      route /([^\s]+)-=\s*([-\d]+)/, :remove_arbitrary_karma,
            help: {'object-=n:' => 'Remove n karma from [object].'}

      def add_one_karma(response)
        karma_object = response.matches[0][0]
        karma = find_and_set_karma(karma_object)
        response.reply reply_with_karma(karma_object, karma)
      end

      def remove_one_karma(response)
        karma_object = response.matches[0][0]
        karma = find_and_set_karma(karma_object, -1)
        response.reply reply_with_karma(karma_object, karma)
      end

      def add_arbitrary_karma(response)
        karma_object = response.matches[0][0]
        increment_value = response.matches[0][1].to_i
        karma = find_and_set_karma(karma_object, increment_value)
        response.reply reply_with_karma(karma_object, karma)
      end

      def remove_arbitrary_karma(response)
        karma_object = response.matches[0][0]
        increment_value = response.matches[0][1].to_i * -1  # -= means we negate the increment_value.  - -9 = + 9
        karma = find_and_set_karma(karma_object, increment_value)
        response.reply reply_with_karma(karma_object, karma)
      end

      def multiply_karma(response)
        karma_object = response.matches[0][0]
        multiplier = response.matches[0][1]
        karma = find_and_set_karma(karma_object, multiplier, true)
        response.reply reply_with_karma(karma_object, karma)
      end

      def reply_with_karma(karma_object, karma)
        # if karma >= 0
          "#{karma_object} has #{karma} karma!"
        # else
          # "#{karma_object} has #{RomanNumerals.to_roman(karma * -1)}💩 karma!"
          # "#{karma_object} has #{RomanNumerals.to_roman(karma * -1)}💩 karma!"
        # end
      end

      # Find the karma object from redis and increment appropriately.
      def find_and_set_karma(karma_object, increment_value = 1, multiply = false)
        karma = redis.get(karma_object).to_i

        if multiply
          karma *= increment_value.to_i
        else
          karma += increment_value
        end

        redis.set(karma_object, karma)
        karma
      end

    end

    Lita.register_handler(OnewheelKarma)
  end
end
