module Polycon
    module Models
      class Professional

        attr_accessor :name

        def self.create(name)
          name = Polycon::Utils::guion (name)
            if Polycon::Utils::professional_exists(name)
              return false
            end
            new(name)
            Polycon::Utils.create_professional(name)
            return true
        end

        def initialize (name)
          self.name = name
        end

        def self.rename(old_name, new_name)
      end
    end
end