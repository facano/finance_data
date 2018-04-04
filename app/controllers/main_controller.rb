class MainController < ApplicationController

  def draw_report
    if params[:date_range] && params[:date_range][:starts_at] && params[:date_range][:ends_at]
      @ufs = Integration::SBIF::UF.between(params[:date_range][:starts_at].to_time, params[:date_range][:ends_at].to_time)
      @dolares = Integration::SBIF::Dolar.between(params[:date_range][:starts_at].to_time, params[:date_range][:ends_at].to_time)
     
      @ufs = Hash[*@ufs.map{|data| [data["Fecha"], data["Valor"].gsub(".", "").gsub(",", ".")]}.flatten]
      @dolares = Hash[*@dolares.map{|data| [data["Fecha"], data["Valor"].gsub(".", "").gsub(",", ".")]}.flatten]
    else
      redirect_to :back
    end
  end
    
end
