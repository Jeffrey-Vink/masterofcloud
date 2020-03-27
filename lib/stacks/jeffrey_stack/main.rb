module JeffreyStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include JeffreyStack::Jeffrey

    description generate_stack_description("JeffreyStack")
  end
end
