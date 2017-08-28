class CreateMeetings
  def initialize(sprint)
    @sprint = sprint
  end

  def run
    create_planning(@sprint.start_date)
    create_standup(@sprint.start_date + 1, @sprint.end_date - 1)
    create_grooming(@sprint.start_date + 1, @sprint.end_date - 1)
    create_review(@sprint.end_date)
    create_retrospective(@sprint.end_date)
  end

  def create_standup(start_date, end_date)
    (start_date..end_date).each do |date|
      if !is_weekend?(date)
        Meeting.create(name: 'standup', event_type: :standup, start_date: date, end_date: date, location: 'mumble')
      end
    end
  end

  def create_planning(date)
    Meeting.create(name: 'planning', event_type: :planning, start_date: date, end_date: date, location: 'gotomeeting')
    Meeting.create(name: 'planning', event_type: :planning, start_date: date, end_date: date, location: 'gotomeeting')
  end

  def create_grooming(start_date, end_date)
    (start_date..end_date).each do |date|
      if is_monday?(date)
        Meeting.create(name: 'grooming', event_type: :grooming, start_date: date, end_date: date, location: 'gotomeeting')
      end
    end
  end

  def create_review(date)
    Meeting.create(name: 'planning', event_type: :planning, start_date: date, end_date: date, location: 'gotomeeting')
  end

  def create_retrospective(date)
    Meeting.create(name: 'retrospective', event_type: :retrospective, start_date: date, end_date: date, location: 'mumble')
  end

  private

  def is_weekend?(date)
    [0,6,7].include?(date.wday)
  end

  def is_monday?(date)
    date.wday == 1
  end
end
