class Meeting < Event
  validates :location, :start_date, :end_date, :event_type, presence: true

  scope :today, (-> { where('DATE(start_date) = ?', Time.zone.today).order(start_date: :asc) })
  scope :this_week, (-> do
    where('DATE(start_date) >= ? AND DATE(end_date) <= ?',
          Time.zone.today.beginning_of_week,
          Time.zone.today.end_of_week).order(start_date: :asc)
  end)
  scope :active, (-> do
    where('DATE(start_date) >= :today OR DATE(end_date) >= :today', today: Time.zone.today)
      .order(start_date: :asc)
  end)
  scope :finished, (-> { where('DATE(end_date) < ?', Time.zone.today).order(start_date: :asc) })

  # Contants
  #
  TYPES = %i[standup planning review retrospective meeting workshop other].freeze
end

# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  location    :string
#  start_date  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_type  :string
#  end_date    :date
#  user_id     :integer
#  type        :string
#  description :text
#
