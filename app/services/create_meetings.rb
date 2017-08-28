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
      if !weekend?(date)
        Meeting.create(name: 'Standup', event_type: :standup, start_date: datetime(date, '11:00'),
                       end_date: datetime(date, '11:30'), location: 'mumble')
      end
    end
  end

  def create_planning(date)
    Meeting.create(name: 'Planning part 1', event_type: :planning, start_date: datetime(date, '11:00'),
                   end_date: datetime(date, '12:00'), location: 'gotomeeting')
    Meeting.create(name: 'Planning part 2', event_type: :planning, start_date: datetime(date, '13:30'),
                   end_date: datetime(date, '15:30'), location: 'gotomeeting')
  end

  def create_grooming(start_date, end_date)
    (start_date..end_date).each do |date|
      if date.monday?
        Meeting.create(name: 'Grooming', event_type: :grooming, start_date: datetime(date, '14:00'),
                       end_date: datetime(date, '16:00'), location: 'gotomeeting')
      end
    end
  end

  def create_review(date)
    Meeting.create(name: 'Review', event_type: :review, start_date: datetime(date, '11:00'),
                   end_date: datetime(date, '12:00'), location: 'gotomeeting')
  end

  def create_retrospective(date)
    Meeting.create(name: 'Retrospective', event_type: :retrospective, start_date: datetime(date, '14:00'),
                   end_date: datetime(date, '16:00'), location: 'mumble')
  end

  private

  def weekend?(date)
    [0,6,7].include?(date.wday)
  end

  def datetime(date, time)
    [date,time].join(' ').to_datetime
  end
end
