module Mongoid
  module CounterCache
    extend ActiveSupport::Concern

    module ClassMethods
      def counter_cache(metadata)
        counter_name = "#{metadata[:inverse_of]}_count"

        set_callback(:create, :after) do |document|
          relation = document.send(metadata[:name])
          if relation
            relation.inc(counter_name.to_sym, 1) if relation.class.fields.keys.include?(counter_name)
          end
        end

        set_callback(:destroy, :after) do |document|
          relation = document.send(metadata[:name])
          if relation && relation.class.fields.keys.include?(counter_name)
            relation.inc(counter_name.to_sym, -1)
          end
        end

      end

    end #ClassMethods

  end #CounterCache
end #Mongoid
