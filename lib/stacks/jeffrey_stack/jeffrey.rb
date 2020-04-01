module JeffreyStack
  module Jeffrey
    extend ActiveSupport::Concern

    included do
      bucket_names = ["my_amazing_bucket", "my_great_bucket"]
      resource :my_amazing_bucket,
               amount: bucket_names.count,
               type: "AWS::S3::Bucket" do |r, index|
        r.property(:bucket_name) { bucket_names[index] }
      end
    end
  end
end