# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  title       :string
#  permissions :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  #validates_inclusion_of :permissions, in: %w(private viewable open), :on => :update, :message => "value %s is invalid!"

  validate :validate_permissions, :on => :update

  private

  def validate_permissions
      unless ["private",  "viewable", "open"].include?(self.permissions)
        errors.add(:base, "Permission denied!")
      end
  end



end
