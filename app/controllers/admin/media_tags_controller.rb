class Admin::MediaTagsController < ApplicationController
	before_action :require_admin!

	def index
		@tags = MediaTag.roots
	end
end
