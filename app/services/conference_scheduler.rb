class ConferenceScheduler
  def initialize(talks)
    @talks = parse_talks(talks)
  end

  def schedule
    tracks = { 'Track A' => [], 'Track B' => [] }
    remaining_talks = @talks.dup

    tracks.each_key do |track|
      morning_session, remaining_talks = allocate_session(remaining_talks, 180)
      afternoon_session, remaining_talks = allocate_session(remaining_talks, 240)
      tracks[track] = {
        morning: morning_session,
        afternoon: afternoon_session
      }
    end

    tracks
  end

  private

  def parse_talks(talks)
    talks.map do |talk|
      title, duration = talk.match(/(.+) (\d+min|lightning)$/).captures
      duration = duration == "lightning" ? 5 : duration.to_i
      { title: title, duration: duration }
    end.sort_by { |t| -t[:duration] }
  end

  def allocate_session(talks, max_time)
    session = []
    time_used = 0
    remaining_talks = talks.dup

    talks.each do |talk|
      break if time_used + talk[:duration] > max_time
      session << talk
      time_used += talk[:duration]
      remaining_talks.delete(talk)
    end

    [session, remaining_talks]
  end
end
