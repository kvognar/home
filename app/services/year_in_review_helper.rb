class YearInReviewHelper

  MONTHS = %w[January February March April May June July August September October November December].freeze

  def initialize(sessions)
    @sessions          = sessions
    @sessions_by_month = @sessions.group_by { |s| s.day.day_of.month }

  end

  def data
    {
        months:                 months,
        most_thought_provoking: most_thought_provoking,
        medium_stats:           medium_stats
    }
  end

  private

  def months
    months = []
    @sessions_by_month.keys.sort.each do |month|
      deciduous        = []
      evergreens       = []
      sessions         = @sessions_by_month[month]
      sessions_by_work = sessions.group_by { |session| session.media_work }

      sessions_by_work.values.sort_by { |s| [s.first.media_work.medium, s.length] }.each do |work_sessions|
        work    = work_sessions.first.media_work
        summary = {
            work:   work,
            medium: work.medium,
            title:  work.title,
            count:  work_sessions.length,
            days:   work_sessions.map do |s|

              icon = if s == s.media_consumption.media_sessions.last && s.media_consumption.finished?
                '✔'
              elsif s == s.media_consumption.media_sessions.first
                '➤'
              else
                '◉'
              end
              {
                  day:  s.day,
                  icon: icon
              }

            end
        }
        # if work.perennial?
          evergreens << summary
        # else
        #   deciduous << summary
        # end
      end
      months << {
          month: MONTHS[month - 1],
          works: deciduous + evergreens
      }
    end
    months
  end

  def most_thought_provoking
    @sessions.group_by(&:media_work).values.sort_by { |sessions| sessions.map { |session| ((session.text || '') + (session.spoiler_text || '')).length } }.last.last.media_work
  end

  def medium_stats
    @sessions.map { |i| i.media_work }.uniq.group_by(&:medium).map { |k, v| [k, v.count] }.to_h
  end
end
