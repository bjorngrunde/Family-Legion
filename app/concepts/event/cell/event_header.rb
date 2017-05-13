module Event::Cell
  class EventHeader < Event::Cell::Master

    def name
      model.name.humanize
    end

    def start_and_end_time
      "#{model.start_time} - #{model.end_time }"
    end

    def readable_date
      model.start_date.to_date
    end
  end
end
