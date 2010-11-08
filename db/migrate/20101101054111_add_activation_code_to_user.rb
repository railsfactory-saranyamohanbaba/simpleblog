class AddActivationCodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :Activation_code, :string
  end

  def self.down
    remove_column :users, :Activation_code
  end
end
