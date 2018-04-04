# frozen_string_literal: true

class MainController < ApplicationController
  def reports
    if params[:date_range] && params[:date_range][:starts_at] && params[:date_range][:ends_at]
      @starts_at = params[:date_range][:starts_at].to_time
      @ends_at = params[:date_range][:ends_at].to_time

      if @starts_at > @ends_at
        @starts_at, @ends_at = @ends_at, @starts_at
      elsif @starts_at == @ends_at
        redirect_to(root_path) && return
      end
      redirect_to(root_path) && return if @ends_at > Time.zone.now
      @ufs = Currency.between(@starts_at, @ends_at, :uf, true)
      @dolares = Currency.between(@starts_at, @ends_at, :dolar, true)
      @tmcs = TMC.between(@starts_at, @ends_at, true)
      @points = (@ends_at - @starts_at) / 1.day <= 40
    else
      redirect_to(root_path) && return
    end
  end
end
