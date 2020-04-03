module DbStack
  module DBS
    extend ActiveSupport::Concern

    included do
      resource :db_stack,
               type: "AWS::RDS::DBInstance" do |r|
        r.property(:engine) { "mysql" }
        r.property(:db_snapshot_identifier) { "my-amazing-snapshot" }
        r.property(:db_instance_class) { "db.t2.micro" }
        r.property(:master_username) { ENV["DBU"] }
        r.property(:master_user_password) { ENV["DBP"] }
        r.property(:allocated_storage) { 50 }
      end
    end
  end
end