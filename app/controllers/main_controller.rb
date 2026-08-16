class MainController < ApplicationController
  DATA_KEYS = ['goal'] + (1..8).flat_map { |number|
    ["main_target#{number}"] + (1..8).map { |item|
      "target#{number}_#{item}"
    }
  }.freeze

  def index
    @records = Record.where(access_token: recent_record_tokens).order(created_at: :desc)
  end

  def new; end

  def create
    record = Record.create!(data: record_data)
    remember_record(record)
    redirect_to edit_main_path(token: record.access_token), notice: 'マンダラートを作成しました。'
  end

  def import
    payload = JSON.parse(params.require(:backup).read)
    data = payload.fetch('data', payload)
    raise ActionController::BadRequest unless data.is_a?(Hash)

    record = Record.create!(data: imported_record_data(data))
    remember_record(record)
    redirect_to edit_main_path(token: record.access_token), notice: 'バックアップを開きました。'
  rescue JSON::ParserError, KeyError, ActionController::ParameterMissing, ActionController::BadRequest
    redirect_to root_path, alert: 'バックアップファイルを読み込めませんでした。'
  end

  def edit
    @record = find_record
  end

  def update
    @record = find_record
    @record.update!(data: @record.data.merge(record_data))
    redirect_to edit_main_path(token: @record.access_token), notice: '保存しました。'
  end

  def delete
    find_record.destroy!
    redirect_to main_index_path, notice: 'マンダラートを削除しました。'
  end

  private

  def record_data
    params.permit(*DATA_KEYS).to_h
  end

  def imported_record_data(data)
    data.stringify_keys.slice(*DATA_KEYS).transform_values { |value| value.to_s.first(500) }
  end

  def find_record
    Record.find_by!(access_token: params[:token])
  end

  def recent_record_tokens
    session[:recent_record_tokens] || []
  end

  def remember_record(record)
    session[:recent_record_tokens] = ([record.access_token] + recent_record_tokens).uniq.first(20)
  end
end
