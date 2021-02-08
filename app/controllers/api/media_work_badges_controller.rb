class Api::MediaWorkBadgesController < ApplicationController

  before_action 'require_admin!'

  def toggle
    badge = Badge.find_by(id: params[:badge_id])
    media_work = MediaWork.find_by(id: params[:media_work_id])
    media_work_badge = MediaWorkBadge.find_or_initialize_by(badge: badge, media_work: media_work)
    if media_work_badge.persisted?
      media_work_badge.destroy
    else
      media_work_badge.save
    end
    head :ok
  end
end
