# frozen_string_literal: true

class MainController < ApplicationController
  def reports
    if params[:date_range] && params[:date_range][:starts_at].presence && params[:date_range][:ends_at].presence
      @starts_at = params[:date_range][:starts_at].to_time
      @ends_at = params[:date_range][:ends_at].to_time

      # Manage special conditions
      @starts_at, @ends_at = @ends_at, @starts_at if @starts_at > @ends_at
      if @starts_at == @ends_at
        flash[:alert] = 'Las fechas no pueden ser iguales!'
        redirect_to(root_path) && return
      elsif @ends_at > Time.zone.now
        flash[:alert] = 'Las fechas no pueden ser en el futuro!'
        redirect_to(root_path) && return
      end

      @ufs = Currency.between(@starts_at, @ends_at, :uf, true)
      @dolares = Currency.between(@starts_at, @ends_at, :dolar, true)
      @tmcs = TMC.between(@starts_at, @ends_at, true)

      if @ufs.nil? && @dolares.nil? && @tmcs.nil?
        render file: "#{Rails.root}/public/404", status: :not_found && return
      end

      @points = (@ends_at - @starts_at) / 1.day <= 40
    else
      flash[:alert] = 'Rellene todos los datos antes de continuar!'
      redirect_to(root_path) && return
    end
  end
end
