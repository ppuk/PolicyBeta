class AddPreviousVersionToPolicies < ActiveRecord::Migration
  def change
    add_reference :policies, :previous_version, index: true
  end
end
