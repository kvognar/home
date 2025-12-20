class LinksController < ApplicationController

	before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@links = Link.all.sort_by { [-_1.order, -_1.id] }
		@links_by_category = @links.group_by(&:category)
	end

	def new
		@link = Link.new
	end

	def create
		@link = Link.new(link_params)
		if @link.save
			redirect_to links_path
		else
			render :new
		end
	end

	def edit
		@link = Link.find(params[:id])
	end

	def update
		@link = Link.find(params[:id])
		if @link.update(link_params)
			redirect_to links_path
		else
			render :edit
		end
	end

	private

	def link_params
		params.require(:link).permit(:name, :url, :description, :category, :order)
	end

end
