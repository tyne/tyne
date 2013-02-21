# This migration comes from tyne_auth (originally 20121109231041)
class AddGravatarIdToTyneAuthUsers < ActiveRecord::Migration
  def change
    add_column :tyne_auth_users, :gravatar_id, :string
  end
end
