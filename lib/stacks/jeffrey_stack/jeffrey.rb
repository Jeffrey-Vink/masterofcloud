module JeffreyStack
  module Jeffrey
    extend ActiveSupport::Concern

    included do
      resource :my_amazing_bucket,
               type: "AWS::S3::Bucket"
    end
  end
end