module DBStack
  module DBS
    extend ActiveSupport::Concern

    included do
      db_names = ["dbstack"]
      resource :db_stack,
               amount: db_names.count,
               type: "AWS::RDS::DBInstance" do |r, index|
        r.property(:engine) { "mysql" }
        r.property(:db_instance_class) { "db.t2.micro" }
        r.property(:db_instance_identifier) { db_names[index] }
        r.property(:master_username) { ENV["DBU"] }
        r.property(:master_user_password) { ENV["DBP"] }
      end
    end
  end
end