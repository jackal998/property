class Api::BaseController < ApplicationController

  before_action :enable_cors

  private

  def enable_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST' #CRUD
    response.headers['Access-Control-Request-Methods'] = 'POST' #CRUD（基本沒差，可能是clien端名稱問題）
  end


  # 設定預設格式為json
  def method_name
    request.format = 'json'  if request.format = 'text/html'
  end
end
