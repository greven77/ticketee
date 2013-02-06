class Comment < ActiveRecord::Base
  attr_accessible :text, :state_id, :tag_names
  attr_accessor :tag_names

  after_create :set_ticket_state
  before_create :set_previous_state

  after_create :associate_tags_with_ticket

  belongs_to :ticket
  belongs_to :user
  belongs_to :previous_state
  belongs_to :state
  validates :text, :presence => true

  delegate :project, :to => :ticket

  private

  def set_ticket_state
    self.ticket.state = self.state
    self.ticket.save!
  end

  def set_previous_state
    self.previous_state = ticket.state
  end

  def associate_tags_with_ticket
    if tag_names
      tags = tag_names.split(" ").map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
    self.ticket.tags += tags
    self.ticket.save
  end
end

