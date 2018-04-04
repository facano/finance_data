class MainController < ApplicationController

  def draw_report
    if params[:date_range] && params[:date_range][:starts_at] && params[:date_range][:ends_at]
      starts_at = params[:date_range][:starts_at].to_time
      ends_at = params[:date_range][:ends_at].to_time

      @ufs = Currency.between(starts_at, ends_at, :uf, true)
      @dolares = Currency.between(starts_at, ends_at, :dolar, true)
     
    else
      redirect_to :back
    end
  end
    
end
