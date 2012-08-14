class Api::AppsController < Api::ApplicationController
  before_filter :find_app, only: [:show, :update]

  def index
  end

  def create
    @app = App.create(params[:app])
    respond_with @app
  end

  def show
  end

  def update
  end

  protected

  def find_app
    @app = App.find_by_id(params[:id]) or head(:not_found) and return
  end
end
