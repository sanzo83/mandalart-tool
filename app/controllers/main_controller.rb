class MainController < ApplicationController
  before_action :authenticate_user!
  def index
    user = current_user
    @records = user.records
  end

  def new
  end

  def create
    data = {
        'goal' => params[:goal],
        'main_target1' => params[:main_target1],
        'main_target2' => params[:main_target2],
        'main_target3' => params[:main_target3],
        'main_target4' => params[:main_target4],
        'main_target5' => params[:main_target5],
        'main_target6' => params[:main_target6],
        'main_target7' => params[:main_target7],
        'main_target8' => params[:main_target8],
    }
    record = Record.new(data: data)
    record.users << current_user
    record.save
    redirect_to('/main/index')
  end

  def edit
    @record_id = params[:record_id]
    @record = Record.find(@record_id)
  end

  def update
    @record_id = params[:record_id]
    @record = Record.find(@record_id)
    data = {
        'goal' => params[:goal],
        'main_target1' => params[:main_target1],
        'main_target2' => params[:main_target2],
        'main_target3' => params[:main_target3],
        'main_target4' => params[:main_target4],
        'main_target5' => params[:main_target5],
        'main_target6' => params[:main_target6],
        'main_target7' => params[:main_target7],
        'main_target8' => params[:main_target8],
        'target1_1' => 'abc'
    }
    @record.update(data: params)
    render('/main/edit')
  end

  def delete
    @record_id = params[:record_id]
    @record = Record.find(@record_id)
    @record.destroy
    redirect_to('/main/index')
  end
end
