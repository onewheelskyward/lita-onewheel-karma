module Lita
  module Handlers
    class OnewheelKarma < Handler
      route /(.+)\+\+$/, :add_one_karma,
            help: 'object++: Add one karma to [object].'

      def add_one_karma(response)
        karma_object = response.matches[0][0]
        karma = redis.get(karma_object)
        if karma.nil?
          karma = 1
        else
          karma += 1
        end

        redis.set(karma_object, karma)
        response.reply "#{karma_object} has #{karma} karma!"
      end
    end

    Lita.register_handler(OnewheelKarma)
  end
end
