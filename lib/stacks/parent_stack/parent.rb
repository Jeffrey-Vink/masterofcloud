require_relative "../../core/applications"

module InfraStack
  module Parent
    extend ActiveSupport::Concern
    included do
      generate_bootstrap_parameters

      resource :vpc_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "vpcstack" }
        r.property(:tags) { default_tags }
      end

      resource :acm_stack,
               amount: 0,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "acmstack" }
        r.property(:tags) { default_tags }
      end

      resource :ecs_stack,
               amount: 0,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "ecsstack" }
        r.property(:parameters) do
          {
            "Vpc": "VpcStack".ref("Outputs.VpcId"),
            "Subnets": [
              :vpc_stack.ref("Outputs.Ec2PrivateSubnetName"),
              :vpc_stack.ref("Outputs.Ec2PrivateSubnet2Name"),
              :vpc_stack.ref("Outputs.Ec2PrivateSubnet3Name")
            ].fnjoin(","),
            "PublicSubnets": [
              :vpc_stack.ref("Outputs.Ec2PublicSubnetName"),
              :vpc_stack.ref("Outputs.Ec2PublicSubnet2Name"),
              :vpc_stack.ref("Outputs.Ec2PublicSubnet3Name")
            ].fnjoin(",")
          }
        end
      end

      resource :one_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "onestack" }
      end

      resource :two_stack,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "twostack" }
        r.property(:parameters) do
          {
            "BucketName": "OneStack".ref("Outputs.MyS3BucketName"),
            "BucketDomainName": "OneStack".ref("Outputs.MyS3BucketDomainName"),
            "WebsiteUrl": "OneStack".ref("Outputs.MyS3BucketDomainUrl")
          }
        end
      end

      resource :jeffrey_stack,
               amount: 0,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "jeffreystack" }
        r.property(:tags) { default_tags }
      end

      resource :db_stack,
               amount: 1,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "dbstack" }
      end

      resource :lambda_stack,
               amount: ENV["ASSIGNMENT_FOUR"] == "true" ? 1 : 0,
               type: "AWS::CloudFormation::Stack" do |r|
        r.property(:template_url) { "lambdastack" }
      end

      create_applications
    end
  end
end
