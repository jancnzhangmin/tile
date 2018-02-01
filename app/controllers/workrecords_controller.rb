class WorkrecordsController < ApplicationController
  def index
@workrecordes = Workrecord.all
  end
end
