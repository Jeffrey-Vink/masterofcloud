module DbStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include DbStack::DBS

    description generate_stack_description("DbStack")
  end
end
