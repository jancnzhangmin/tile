class WorkrecordsController < ApplicationController
  def index
@workrecordes = Workrecord.all.paginate(:page => params[:page], :per_page => 20)
  end
end
