class MainController < ApplicationController

  def reports
    if params[:date_range] && params[:date_range][:starts_at] && params[:date_range][:ends_at]
      starts_at = params[:date_range][:starts_at].to_time
      ends_at = params[:date_range][:ends_at].to_time

      if starts_at > ends_at
        starts_at, ends_at = ends_at, starts_at
      elsif starts_at == ends_at
        redirect_to root_path and return
      end

      @ufs = Currency.between(starts_at, ends_at, :uf, true)
      @dolares = Currency.between(starts_at, ends_at, :dolar, true)
      @tmcs = TMC.between(starts_at, ends_at, true)

    else
      redirect_to root_path and return
    end
  end

end
