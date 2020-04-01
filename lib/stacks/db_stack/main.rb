module DBStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include DBStack::DBS

    description generate_stack_description("DBStack")
  end
end
