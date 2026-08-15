class MainController < ApplicationController
  before_action :authenticate_user!

  DATA_KEYS = ['goal'] + (1..8).flat_map { |number| ["main_target#{number}"] + (1..8).map { |item| "target#{number}_#{item}" } }.freeze

  def index
    @records = current_user.records.order(created_at: :desc)
  end

  def new
  end

  def create
    record = Record.new(data: record_data)
    record.users << current_user
    record.save
    redirect_to edit_main_path(record_id: record.id), notice: 'マンダラートを作成しました。'
  end

  def edit
    @record = current_user.records.find(params[:record_id])
  end

  def update
    @record = current_user.records.find(params[:record_id])
    @record.update!(data: @record.data.merge(record_data))
    redirect_to edit_main_path(record_id: @record.id), notice: '保存しました。'
  end

  def delete
    @record = current_user.records.find(params[:record_id])
    @record.destroy
    redirect_to main_index_path, notice: 'マンダラートを削除しました。'
  end

  private

  def record_data
    params.permit(*DATA_KEYS).to_h
  end
end
